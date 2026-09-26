#!/usr/bin/env bash
# tests/test-external-write-gate.sh
# Test suite for FAO External Write Gate — Minimal Vertical Slice

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

AUTH_FILE=".fao-gate-auth.json"
TEST_BRANCH="test/external-write-gate-$$"
DUMMY_FILE="test-gate-dummy-$$.md"

# --- 前提检查（在注册任何清理钩子、创建任何文件或分支之前）---
HOOK=".git/hooks/pre-push"
if [[ ! -f "$HOOK" ]]; then
    echo "SKIP: pre-push hook not installed at $HOOK"
    echo "      这是测试前提未满足，不是门禁逻辑失败，也不是测试通过。"
    echo "      本地安装（仅写入本仓库 .git/，不改全局 Git 配置），在仓库根执行："
    echo '        printf "%s\n" "#!/usr/bin/env bash" "exec \"$(git rev-parse --show-toplevel)/scripts/external-write-gate.sh\" \"\$1\"" > .git/hooks/pre-push && chmod +x .git/hooks/pre-push'
    echo "      安装后重新运行本测试。退出码 77 = 跳过（autoconf 惯例）：0 仅表示真正通过。"
    exit 77
fi

if [[ -f "$AUTH_FILE" ]]; then
    echo "FAIL: $AUTH_FILE already exists."
    echo "      测试不会删除用户既有的授权文件。请先消费或手动移除后再运行测试。"
    exit 1
fi

# --- 副作用标志：cleanup 只清理本次运行实际创建的资源 ---
DUMMY_CREATED=0
BRANCH_CREATED=0
REMOTE_BRANCH_CREATED=0
AUTH_WRITTEN=0

cleanup() {
    if [[ "$DUMMY_CREATED" -eq 1 ]]; then
        rm -f "$DUMMY_FILE"
    fi
    if [[ "$BRANCH_CREATED" -eq 1 ]]; then
        git checkout -q main 2>/dev/null || git checkout -q - 2>/dev/null || true
        git branch -D "$TEST_BRANCH" 2>/dev/null || true
    fi
    if [[ "$REMOTE_BRANCH_CREATED" -eq 1 ]]; then
        # 清理专用的临时授权：仅允许删除本测试分支，用完即删。
        # 否则门禁会拦下删除（无授权或过期授权均 blocked），导致远端测试分支残留。
        NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
        EXPIRES=$(date -u -d '+5 minutes' +%Y-%m-%dT%H:%M:%SZ)
        cat > "$AUTH_FILE" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "$TEST_BRANCH",
  "authorized_commit": "cleanup",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
        git push origin --delete "$TEST_BRANCH" 2>/dev/null || echo "WARN: remote test branch cleanup failed: $TEST_BRANCH"
    fi
    if [[ "$AUTH_WRITTEN" -eq 1 || "$REMOTE_BRANCH_CREATED" -eq 1 ]]; then
        rm -f "$AUTH_FILE"
    fi
}
trap cleanup EXIT

git checkout -b "$TEST_BRANCH"
BRANCH_CREATED=1
echo "# test" > "$DUMMY_FILE"
DUMMY_CREATED=1
git add "$DUMMY_FILE"
git commit -q -m "test: external write gate dummy"
LOCAL_SHA=$(git rev-parse HEAD)

echo ""
echo "=== TEST 1: NEGATIVE — no authorization ==="
rm -f "$AUTH_FILE"

set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: push should have been blocked"
    exit 1
fi
if ! echo "$PUSH_OUT" | grep -q "\[blocked\]"; then
    echo "FAIL: no [blocked] marker"
    exit 1
fi
echo "PASS: blocked without authorization"

echo ""
echo "=== TEST 2: POSITIVE — valid authorization ==="
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$AUTH_FILE" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "$TEST_BRANCH",
  "authorized_commit": "$LOCAL_SHA",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
AUTH_WRITTEN=1

set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -ne 0 ]]; then
    echo "FAIL: push should have been allowed"
    echo "$PUSH_OUT"
    exit 1
fi
if ! echo "$PUSH_OUT" | grep -q "\[allowed\]"; then
    echo "FAIL: no [allowed] marker"
    exit 1
fi
REMOTE_BRANCH_CREATED=1
echo "PASS: allowed with valid authorization"

echo ""
echo "=== TEST 3: NEGATIVE — expired authorization ==="
EXPIRED=$(date -u -d '-1 hour' +%Y-%m-%dT%H:%M:%SZ)
cat > "$AUTH_FILE" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "$TEST_BRANCH",
  "authorized_commit": "$LOCAL_SHA",
  "granted_at": "$EXPIRED",
  "expires_at": "$EXPIRED"
}
EOF

set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: push should have been blocked (expired)"
    exit 1
fi
if ! echo "$PUSH_OUT" | grep -q "\[blocked\]"; then
    echo "FAIL: no [blocked] marker for expired auth"
    exit 1
fi
echo "PASS: blocked with expired authorization"

echo ""
echo "ALL TESTS PASSED"
