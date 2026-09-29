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
  "target_ref": "refs/heads/$TEST_BRANCH",
  "authorized_commit": "$LOCAL_SHA",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
# 10 分钟短期授权，写入隔离工作区，随 cleanup 删除。
# 限定：门禁不删除授权文件（用后由本测试自行清理）；target_ref 比对为 gate 现行行为（见 scripts/external-write-gate.sh）。

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
        ALLOWED_SHA="$REMOTE_SHA"
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
  "target_ref": "refs/heads/$TEST_BRANCH",
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
echo "=== TEST 4: ref scope — authorization bound to specific refs ==="

# 4a: 授权 main，推其他分支 → blocked
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "refs/heads/main",
  "authorized_commit": "$LOCAL_SHA",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
git checkout -q -b "gate-scope-a-$$"
echo "a" > "scope-a-$$.md" && git add "scope-a-$$.md" && git commit -q -m "scope-a"
set +e
PUSH_OUT=$(git push origin "gate-scope-a-$$" 2>&1)
PUSH_STATUS=$?
set -e
if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: push to non-authorized ref succeeded"
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "Ref mismatch"; then
    echo "FAIL: blocked but without ref-mismatch reason"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 4a blocked — authorized main, attempted other branch"
fi

# 4b: 一次 push 同时含获授权 ref 与未授权 ref → 整体阻断，且远端两者均无新增
# 授权 target_ref = TEST_BRANCH（远端已存在，远端 SHA 为 ALLOWED_SHA）
git checkout -q "$TEST_BRANCH"
echo "mix" > "mix-$$.md" && git add "mix-$$.md" && git commit -q -m "mix-update"
git checkout -q main
git checkout -q -b "gate-mix-b1-$$"
echo "b1" > "mix-b1-$$.md" && git add "mix-b1-$$.md" && git commit -q -m "mix-b1"
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "refs/heads/$TEST_BRANCH",
  "authorized_commit": "mix",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" "gate-mix-b1-$$" 2>&1)
PUSH_STATUS=$?
set -e
REMOTE_TEST_SHA=$(git ls-remote origin "refs/heads/$TEST_BRANCH" | awk '{print $1}')
REMOTE_B1=$(git ls-remote origin "refs/heads/gate-mix-b1-$$" | awk '{print $1}')
if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: mixed push (authorized + unauthorized ref) succeeded"
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "Ref mismatch"; then
    echo "FAIL: mixed push blocked without ref-mismatch reason"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
elif [[ "$REMOTE_TEST_SHA" != "$ALLOWED_SHA" ]]; then
    echo "FAIL: authorized ref advanced on remote despite overall block (remote=$REMOTE_TEST_SHA expected=$ALLOWED_SHA)"
    FAILURES=$((FAILURES + 1))
elif [[ -n "$REMOTE_B1" ]]; then
    echo "FAIL: unauthorized ref created on remote despite overall block"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 4b blocked — mixed push rolled back entirely; remote unchanged"
fi

# 4c: 删除远端已存在的 ref → blocked
# TEST_BRANCH 已在 TEST 2 推送到远端，此处删除它
git checkout -q main
set +e
PUSH_OUT=$(git push origin --delete "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e
if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: ref deletion succeeded"
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "deletion"; then
    echo "FAIL: deletion blocked without deletion reason"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 4c blocked — ref deletion not covered"
fi

# 4d: tag → blocked
git checkout -q main
git tag "gate-tag-$$"
set +e
PUSH_OUT=$(git push origin "gate-tag-$$" 2>&1)
PUSH_STATUS=$?
set -e
if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: tag push succeeded"
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "Tag push is not covered"; then
    echo "FAIL: tag push blocked without tag-specific reason"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 4d blocked — tag ref not covered"
fi

# 4e: 无 stdin 输入（非 hook 调用或通配推送）→ blocked
set +e
GATE_OUT=$(bash scripts/external-write-gate.sh origin < /dev/null 2>&1)
GATE_STATUS=$?
set -e
if [[ $GATE_STATUS -eq 0 ]]; then
    echo "FAIL: gate allowed invocation without push records"
    FAILURES=$((FAILURES + 1))
elif ! echo "$GATE_OUT" | grep -q "No push records"; then
    echo "FAIL: empty-stdin blocked without reason"
    echo "$GATE_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 4e blocked — empty stdin, scope unverifiable"
fi

# 4f: 授权 target_ref 恰好就是该 tag，仍阻断
git checkout -q main
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "refs/tags/gate-tag-$$",
  "authorized_commit": "tag",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
set +e
PUSH_OUT=$(git push origin "gate-tag-$$" 2>&1)
PUSH_STATUS=$?
set -e
if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: tag push succeeded even with matching target_ref"
    FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "Tag push is not covered"; then
    echo "FAIL: tag push blocked without tag-specific reason"
    echo "$PUSH_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 4f blocked — tag refused even when authorized target_ref is that tag"
fi

echo ""
echo "=== TEST 5: malformed stdin records ==="

# 5a: 三列
set +e
GATE_OUT=$(printf 'a b c\n' | bash scripts/external-write-gate.sh origin 2>&1)
GATE_STATUS=$?
set -e
if [[ $GATE_STATUS -eq 0 ]]; then
    echo "FAIL: 3-column record allowed"
    FAILURES=$((FAILURES + 1))
elif ! echo "$GATE_OUT" | grep -q "fewer than 4 columns"; then
    echo "FAIL: 3-column record blocked without reason"; echo "$GATE_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 5a blocked — fewer than 4 columns"
fi

# 5b: 五列（第 5 列不得被并入第 4 列而漏检）
set +e
GATE_OUT=$(printf 'a b c d e\n' | bash scripts/external-write-gate.sh origin 2>&1)
GATE_STATUS=$?
set -e
if [[ $GATE_STATUS -eq 0 ]]; then
    echo "FAIL: 5-column record allowed"
    FAILURES=$((FAILURES + 1))
elif ! echo "$GATE_OUT" | grep -q "more than 4 columns"; then
    echo "FAIL: 5-column record blocked without reason"; echo "$GATE_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 5b blocked — more than 4 columns"
fi

# 5c: 最后一行无结尾换行——该行必须被处理（不得静默跳过）
set +e
GATE_OUT=$(printf 'refs/heads/x 1111111111111111111111111111111111111111 refs/heads/x 0000000000000000000000000000000000000000' | bash scripts/external-write-gate.sh origin 2>&1)
GATE_STATUS=$?
set -e
if [[ $GATE_STATUS -eq 0 ]]; then
    echo "FAIL: unterminated last line allowed"
    FAILURES=$((FAILURES + 1))
elif echo "$GATE_OUT" | grep -q "No push records"; then
    echo "FAIL: unterminated last line was silently skipped (treated as empty input)"
    FAILURES=$((FAILURES + 1))
elif ! echo "$GATE_OUT" | grep -q "blocked"; then
    echo "FAIL: unterminated last line not blocked"; echo "$GATE_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 5c blocked — unterminated last line processed, not skipped"
fi

# 5d: 空白行
set +e
GATE_OUT=$(printf '\n' | bash scripts/external-write-gate.sh origin 2>&1)
GATE_STATUS=$?
set -e
if [[ $GATE_STATUS -eq 0 ]]; then
    echo "FAIL: blank line allowed"
    FAILURES=$((FAILURES + 1))
elif ! echo "$GATE_OUT" | grep -q "Blank line"; then
    echo "FAIL: blank line blocked without reason"; echo "$GATE_OUT"
    FAILURES=$((FAILURES + 1))
else
    echo "PASS: 5d blocked — blank line rejected"
fi

echo ""
echo "=== TEST 6: expires_at robustness (missing / empty / malformed) ==="
# 过期用例已由 TEST 3 覆盖；此处覆盖 fail-closed 缺口。
# 输入为合法的 4 列 pre-push 记录（feed gate 直接调用）。
git checkout -q main
TEST6_REF="refs/heads/test6-$$"
VALID_LINE="$TEST6_REF aaaaa1111111111111111111111111111111111 $TEST6_REF 0000000000000000000000000000000000000000"

run_expires_case() {
    local name="$1" expires_json="$2" expect_reason="$3"
    cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "$TEST6_REF"${expires_json}
}
EOF
    set +e
    GATE_OUT=$(printf '%s\n' "$VALID_LINE" | bash scripts/external-write-gate.sh origin 2>&1)
    GATE_STATUS=$?
    set -e
    if [[ $GATE_STATUS -eq 0 ]]; then
        echo "FAIL: $name allowed"
        FAILURES=$((FAILURES + 1))
    elif ! echo "$GATE_OUT" | grep -q "$expect_reason"; then
        echo "FAIL: $name blocked without expected reason"
        echo "$GATE_OUT"
        FAILURES=$((FAILURES + 1))
    else
        echo "PASS: $name blocked"
    fi
}

# 6a: 缺失 expires_at 字段
run_expires_case "6a missing expires_at" "" "missing, empty or malformed"
# 6b: 空值
run_expires_case "6b empty expires_at" ', "expires_at": ""' "missing, empty or malformed"
# 6c: 畸形值（字典序陷阱：NOW > "not-a-date" 为假，旧逻辑会放行）
run_expires_case "6c malformed expires_at" ', "expires_at": "not-a-date"' "missing, empty or malformed"

echo ""
echo "=== TEST 7: calendar validity (real-time check) ==="
# 字形合法但不存在的日历时间必须 blocked；有效时间（含闰日）不得误阻断。
git checkout -q main 2>/dev/null || true
TEST7_REF="refs/heads/test7-$$"
VALID_LINE7="$TEST7_REF aaaaa1111111111111111111111111111111111 $TEST7_REF 0000000000000000000000000000000000000000"

run_cal_case() {
    local name="$1" expires_val="$2" expect_allowed="$3"
    cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "$TEST7_REF",
  "expires_at": "$expires_val"
}
EOF
    set +e
    GATE_OUT=$(printf '%s\n' "$VALID_LINE7" | bash scripts/external-write-gate.sh origin 2>&1)
    GATE_STATUS=$?
    set -e
    if [[ "$expect_allowed" == "yes" ]]; then
        if [[ $GATE_STATUS -eq 0 ]] && echo "$GATE_OUT" | grep -q "\[allowed\]"; then
            echo "PASS: $name allowed"
        else
            echo "FAIL: $name should be allowed"; echo "$GATE_OUT"
            FAILURES=$((FAILURES + 1))
        fi
    else
        if [[ $GATE_STATUS -eq 0 ]]; then
            echo "FAIL: $name allowed"
            FAILURES=$((FAILURES + 1))
        elif ! echo "$GATE_OUT" | grep -q "not a real calendar time"; then
            echo "FAIL: $name blocked without calendar reason"; echo "$GATE_OUT"
            FAILURES=$((FAILURES + 1))
        else
            echo "PASS: $name blocked"
        fi
    fi
}

# 负向：字形合法但日历不存在
run_cal_case "7a month 13"        "2026-13-01T00:00:00Z" no
run_cal_case "7b feb 30"          "2026-02-30T00:00:00Z" no
run_cal_case "7c hour 25:61:61"   "2026-09-29T25:61:61Z" no
run_cal_case "7d non-leap feb 29" "2025-02-29T00:00:00Z" no
# 正向：有效闰日 + 有效未来时间
run_cal_case "7e valid leap day"  "2028-02-29T00:00:00Z" yes
run_cal_case "7f valid future"    "2030-01-01T00:00:00Z" yes

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
