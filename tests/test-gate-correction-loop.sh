#!/usr/bin/env bash
# tests/test-gate-correction-loop.sh
# Gate 阻断—授权纠正—重试 闭环验证（隔离测试）
#
# 验证对象：护栏被调用条件下，错误授权被阻断 → 操作者据阻断原因
# 纠正授权中的对应字段 → 重试恢复执行，且各阶段远端状态符合预期。
#
# 性质：新增测试代码，零生产代码变更。本运行 = 设计自测，不构成独立外部验证。
# 不代表：FAO 完整纠错写回机制被验证 / 独立强制边界 / 防绕过 / 真实远端有效性。
#
# 隔离模型：与 tests/test-external-write-gate.sh 相同——自建 mktemp 工作仓库
# + 本地 bare remote，完全不使用当前仓库的 origin、分支、工作区或授权文件。
# 测试授权仅为夹具，不代表真实人类授权；纠正动作只改授权中的对应字段，
# 不扩大授权范围、不延长权限、不重新生成任意授权。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

ISOLATE_DIR=$(mktemp -d /tmp/fao-gate-loop.XXXXXXXX)
WORK="$ISOLATE_DIR/work"
BARE="$ISOLATE_DIR/origin.git"
BYPASS_DIR="$ISOLATE_DIR/bypass"
FAILURES=0

cleanup() {
    rm -rf "$ISOLATE_DIR" 2>/dev/null || echo "CLEANUP-FAIL: $ISOLATE_DIR" >&2
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

log_case() { echo ""; echo "=== $1 ==="; }

git init --bare -q "$BARE"
git init -q -b main "$WORK"
cd "$WORK"
git config user.email "gate-loop-test@local"
git config user.name "Gate Loop Test"
git remote add origin "$BARE"

# 防改写断言：origin 必须是本测试自建的本地 bare 路径
if [[ "$(git remote get-url origin)" != "$BARE" ]]; then
    echo "FAIL: origin URL mismatch. expected local bare: $BARE"
    exit 1
fi

# hook 安装前完成 main 初始化
git commit -q --allow-empty -m "init: main"
git push -q origin main
mkdir -p scripts
cp "$REPO_ROOT/scripts/external-write-gate.sh" scripts/
printf '%s\n' "#!/usr/bin/env bash" "exec \"$(pwd)/scripts/external-write-gate.sh\" \"\$1\"" > .git/hooks/pre-push
chmod +x .git/hooks/pre-push

echo "隔离环境: $ISOLATE_DIR"
echo "验证对象: 错误授权被阻断 → 纠正对应字段 → 重试恢复 → 各阶段远端状态符合预期"

remote_refs() { git ls-remote origin | awk '{print $1" "$2}' | sort; }

# ---------- SCENARIO 1: 错误 target_ref → 阻断，远端 refs 未变化 ----------
log_case "SCENARIO 1: 错误 target_ref 授权导致阻断"
git checkout -q -b "loop-fix-$$"
echo "fix" > "fix-$$.md" && git add "fix-$$.md" && git commit -q -m "fix: content"
LOCAL_SHA=$(git rev-parse HEAD)

NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "refs/heads/wrong-branch-$$",
  "authorized_commit": "$LOCAL_SHA",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
echo "授权夹具: target_ref=refs/heads/wrong-branch-$$ (错误字段), expires_at=$EXPIRES (有效)"

REFS_BEFORE=$(remote_refs)
set +e
PUSH_OUT=$(git push origin "loop-fix-$$" 2>&1)
PUSH_STATUS=$?
set -e
REFS_AFTER=$(remote_refs)

if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: 错误 target_ref 未阻断"; echo "$PUSH_OUT"; FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "Ref mismatch"; then
    echo "FAIL: 阻断但原因非 Ref mismatch"; echo "$PUSH_OUT"; FAILURES=$((FAILURES + 1))
elif [[ "$REFS_BEFORE" != "$REFS_AFTER" ]]; then
    echo "FAIL: 阻断后远端 refs 发生变化"; FAILURES=$((FAILURES + 1))
else
    echo "阻断原因: Ref mismatch (authorized=wrong-branch-$$, attempted=loop-fix-$$)"
    echo "退出码: $PUSH_STATUS (非0)"
    echo "远端前后对照: 无变化"
    echo "PASS: scenario 1"
fi

# ---------- SCENARIO 2: 仅修正 target_ref 字段 → 重试成功，SHA 回读一致 ----------
log_case "SCENARIO 2: 仅修正授权对应字段后重试成功"
# 只改 target_ref 一个字段；authorized_commit 故意填虚假值，实证该字段不被校验
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EXPIRES=$(date -u -d '+10 minutes' +%Y-%m-%dT%H:%M:%SZ)
cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "refs/heads/loop-fix-$$",
  "authorized_commit": "decoy-sha-not-the-pushed-commit",
  "granted_at": "$NOW",
  "expires_at": "$EXPIRES"
}
EOF
echo "修正字段: target_ref → refs/heads/loop-fix-$$（仅此字段）"
echo "注意: authorized_commit 填虚假值 decoy-sha-not-the-pushed-commit，用于实证字段不校验"

REFS_BEFORE=$(remote_refs)
set +e
PUSH_OUT=$(git push origin "loop-fix-$$" 2>&1)
PUSH_STATUS=$?
set -e
REMOTE_SHA=$(git ls-remote origin "refs/heads/loop-fix-$$" | awk '{print $1}')

if [[ $PUSH_STATUS -ne 0 ]]; then
    echo "FAIL: 修正后重试应放行"; echo "$PUSH_OUT"; FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "\[allowed\]"; then
    echo "FAIL: 无 [allowed] 标记"; FAILURES=$((FAILURES + 1))
elif [[ "$REMOTE_SHA" != "$LOCAL_SHA" ]]; then
    echo "FAIL: SHA 不一致 remote=$REMOTE_SHA local=$LOCAL_SHA"; FAILURES=$((FAILURES + 1))
else
    echo "重试结果: [allowed], 远端 SHA=$REMOTE_SHA 与本地一致"
    echo "实证记录: authorized_commit=虚假值仍放行 → 该字段不被校验，授权不绑定提交"
    echo "远端前后对照: 新增 refs/heads/loop-fix-$$ = $REMOTE_SHA"
    echo "PASS: scenario 2"
fi

# ---------- SCENARIO 3: 纠正后授权仍过期 → 继续阻断，远端不变 ----------
log_case "SCENARIO 3: 授权仍过期时继续阻断"
git checkout -q -b "loop-late-$$"
echo "late" > "late-$$.md" && git add "late-$$.md" && git commit -q -m "late content"
LATE_SHA=$(git rev-parse HEAD)
EXPIRED=$(date -u -d '-1 hour' +%Y-%m-%dT%H:%M:%SZ)
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
# target_ref 已纠正为正确值，仅 expires_at 过期
cat > "$WORK/.fao-gate-auth.json" << EOF
{
  "state": "authorized",
  "action_type": "git-push",
  "target_remote": "origin",
  "target_ref": "refs/heads/loop-late-$$",
  "authorized_commit": "$LATE_SHA",
  "granted_at": "$EXPIRED",
  "expires_at": "$EXPIRED"
}
EOF
echo "授权夹具: target_ref 正确, expires_at=$EXPIRED (已过期)"

REFS_BEFORE=$(remote_refs)
set +e
PUSH_OUT=$(git push origin "loop-late-$$" 2>&1)
PUSH_STATUS=$?
set -e
REFS_AFTER=$(remote_refs)

if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: 过期授权应阻断"; FAILURES=$((FAILURES + 1))
elif ! echo "$PUSH_OUT" | grep -q "expired"; then
    echo "FAIL: 阻断但原因非 expired"; echo "$PUSH_OUT"; FAILURES=$((FAILURES + 1))
elif [[ "$REFS_BEFORE" != "$REFS_AFTER" ]]; then
    echo "FAIL: 阻断后远端 refs 发生变化"; FAILURES=$((FAILURES + 1))
else
    echo "阻断原因: expired at $EXPIRED"
    echo "退出码: $PUSH_STATUS (非0)"
    echo "远端前后对照: 无变化（防“重试到放行”）"
    echo "PASS: scenario 3"
fi

# ---------- SCENARIO 4: 全量 ref 核对，无额外 ref、无意外删除 ----------
log_case "SCENARIO 4: 全量远端 ref 核对"
ACTUAL=$(remote_refs)
EXPECTED=$(printf '%s\n' \
  "$(git ls-remote origin refs/heads/main | awk '{print $1" "$2}')" \
  "$REMOTE_SHA refs/heads/loop-fix-$$" | sort)
if [[ "$ACTUAL" == "$EXPECTED" ]]; then
    echo "实际 refs:"; echo "$ACTUAL" | sed 's/^/  /'
    echo "与预期集一致：无额外 ref、无意外删除"
    echo "PASS: scenario 4"
else
    echo "FAIL: 远端 ref 集合与预期不符"
    echo "--- 预期:"; echo "$EXPECTED"
    echo "--- 实际:"; echo "$ACTUAL"
    FAILURES=$((FAILURES + 1))
fi

# ---------- SCENARIO 5: --no-verify 绕过演示（独立子环境，已知能力上限） ----------
log_case "SCENARIO 5: --no-verify 绕过演示（独立临时环境）"
echo "性质: 已知能力上限记录。绕过成功是预期结果。"
echo "不与上述闭环断言混用；未对任何生产 gate 执行绕过。"
git init -q -b main "$BYPASS_DIR/work"
cd "$BYPASS_DIR/work"
git config user.email "bypass-demo@local"
git config user.name "Bypass Demo"
git remote add origin "$BARE"
# 防改写断言：演示环境的 origin 也必须指向本隔离 bare
if [[ "$(git remote get-url origin)" != "$BARE" ]]; then
    echo "FAIL: bypass 环境 origin URL mismatch"; FAILURES=$((FAILURES + 1))
else
    git commit -q --allow-empty -m "init: bypass demo"
    # 无授权文件 + --no-verify（hook 不执行）→ 预期：绕过成功
    set +e
    BP_OUT=$(git push --no-verify -q origin main:refs/heads/bypass-demo 2>&1)
    BP_STATUS=$?
    set -e
    BP_REMOTE=$(git ls-remote origin refs/heads/bypass-demo | awk '{print $1}')
    BP_LOCAL=$(git rev-parse HEAD)
    if [[ $BP_STATUS -eq 0 && "$BP_REMOTE" == "$BP_LOCAL" ]]; then
        echo "绕过演示结果: --no-verify 推送成功，远端 ref=本地 SHA"
        echo "记录: 协作护栏可被 --no-verify 绕过（脚本头注释已自述，此为实证）"
        echo "PASS: scenario 5 (作为已知上限记录)"
    else
        echo "FAIL: 绕过演示结果异常"; echo "$BP_OUT"; FAILURES=$((FAILURES + 1))
    fi
    # 清理演示 ref，避免污染 scenario 4 的全量断言基线
    git push -q --no-verify origin :refs/heads/bypass-demo 2>/dev/null || true
fi

echo ""
echo "=== 证据摘要 ==="
echo "阻断原因: S1=Ref mismatch / S3=expired"
echo "修正字段: S2 仅 target_ref（单字段）"
echo "重试结果: S2 [allowed] 且 SHA 回读一致"
echo "authorized_commit 实证: 虚假值仍放行 → 字段不被校验（与 maturity note 声明一致）"
echo "--no-verify: 独立子环境演示成功，记为已知能力上限"

if [[ $FAILURES -gt 0 ]]; then
    echo ""; echo "RESULT: FAIL ($FAILURES failure(s))"
    exit 1
fi
echo ""
echo "RESULT: ALL SCENARIOS PASSED"
