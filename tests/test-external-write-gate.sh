#!/usr/bin/env bash
# tests/test-external-write-gate.sh
# Test suite for FAO External Write Gate — Minimal Vertical Slice
#
# 隔离模型：本测试自建临时本地工作仓库 + 本地 bare remote，
# 完全不使用当前仓库的 origin、分支、工作区文件。
# 所有测试产物位于 mktemp 目录内，cleanup 删除整个目录。
# 退出码约定：0 = 全部通过；1 = 失败；77 = 跳过（前提未满足）。

set -euo pipefail

# === 定位被测脚本所在的仓库根（仅用于拷贝门禁脚本，不做任何 Git 写操作）===
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# === 自建隔离环境 ===
# 本测试不使用原仓库的 origin、分支、工作区或授权文件。
# 所有 Git 操作（init / hook / 授权 / push）只发生在 mktemp 隔离目录内。
ISOLATE_DIR=$(mktemp -d /tmp/fao-gate-test.XXXXXXXX)
WORK="$ISOLATE_DIR/work"
BARE="$ISOLATE_DIR/origin.git"
TEST_BRANCH="test/gate-$$"
FAILURES=0

cleanup() {
    if ! rm -rf "$ISOLATE_DIR" 2>/dev/null; then
        echo "CLEANUP-FAIL: $ISOLATE_DIR" >&2
    fi
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

echo "隔离环境: $ISOLATE_DIR"
echo "bare origin: $BARE（本地路径，与任何网络远端无连接）"

git init --bare -q "$BARE"
git init -q -b main "$WORK"
cd "$WORK"
git config user.email "gate-test@local"
git config user.name "Gate Test"
git remote add origin "$BARE"

# 防改写断言：origin 必须是本测试自建的本地 bare 路径
if [[ "$(git remote get-url origin)" != "$BARE" ]]; then
    echo "FAIL: origin URL mismatch. expected local bare: $BARE"
    exit 1
fi

# hook 安装前完成 main 初始化（避免被被测门禁拦截）
git commit -q --allow-empty -m "init: main"
git push -q origin main

# 安装被测 hook 与门禁脚本
mkdir -p scripts
cp "$REPO_ROOT/scripts/external-write-gate.sh" scripts/
printf '%s\n' "#!/usr/bin/env bash" "exec \"$(pwd)/scripts/external-write-gate.sh\" \"\$1\"" > .git/hooks/pre-push
chmod +x .git/hooks/pre-push

echo ""
echo "=== 前置状态 ==="
echo "本地分支: $(git branch --format='%(refname:short)' | tr '\n' ' ')"
echo "远端分支: $(git --git-dir="$BARE" branch --format='%(refname:short)' | tr '\n' ' ')"

git checkout -q -b "$TEST_BRANCH"
echo "# test" > "dummy-$$.md"
git add "dummy-$$.md"
git commit -q -m "test: gate dummy"
LOCAL_SHA=$(git rev-parse HEAD)

echo ""
echo "=== TEST 1: NEGATIVE — no authorization ==="
set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: gate failed to block unauthorized push; remote branch was created"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
    # 远端分支由本次测试创建，cleanup 将随隔离目录整体删除；保留失败状态
else
    if ! echo "$PUSH_OUT" | grep -q "\[blocked\]"; then
        echo "FAIL: push failed but no [blocked] marker (gate may not be the cause)"
        echo "$PUSH_OUT"
        FAILURES=$((FAILURES + 1))
    else
        echo "PASS: blocked without authorization"
    fi
fi

echo ""
echo "=== TEST 2: POSITIVE — valid authorization + execution receipt ==="
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
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
# 10 分钟短期授权，写入隔离工作区，随 cleanup 删除。
# 限定：当前门禁不消费授权文件，也不比对实际推送 ref 与 target_ref，
# 故 target_ref 的范围仅为声明，不能称“一次性”或“强制限分支”。

set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -ne 0 ]]; then
    echo "FAIL: push should have been allowed"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "\[allowed\]"; then
    echo "FAIL: no [allowed] marker"
    FAILURES=$((FAILURES + 1))
else
    # 执行回读：只读比对远端 ref 与本地 SHA，不凭退出码判定成功
    REMOTE_SHA=$(git ls-remote origin "refs/heads/$TEST_BRANCH" | awk '{print $1}')
    if [[ -z "$REMOTE_SHA" ]]; then
        echo "FAIL: remote ref missing after allowed push"
        FAILURES=$((FAILURES + 1))
    elif [[ "$REMOTE_SHA" != "$LOCAL_SHA" ]]; then
        echo "FAIL: SHA mismatch remote=$REMOTE_SHA local=$LOCAL_SHA"
        FAILURES=$((FAILURES + 1))
    else
        echo "PASS: allowed; execution receipt verified (remote=$REMOTE_SHA)"
    fi
fi

echo ""
echo "=== TEST 3: NEGATIVE — expired authorization ==="
EXPIRED=$(date -u -d '-1 hour' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
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
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "\[blocked\]"; then
    echo "FAIL: no [blocked] marker for expired auth"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: blocked with expired authorization"
fi

echo ""
echo "=== 后置状态（cleanup 前）==="
echo "本地分支: $(git branch --format='%(refname:short)' | tr '\n' ' ')"
echo "远端分支: $(git --git-dir="$BARE" branch --format='%(refname:short)' | tr '\n' ' ')"

if [[ $FAILURES -gt 0 ]]; then
    echo ""
    echo "RESULT: FAIL ($FAILURES failure(s))"
    exit 1
fi
echo ""
echo "RESULT: ALL TESTS PASSED"
