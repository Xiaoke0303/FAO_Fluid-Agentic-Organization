#!/usr/bin/env bash
# scripts/external-write-gate.sh
# FAO External Write Gate — Minimal Vertical Slice
# Target action class: git remote push
#
# Governance rule enforced:
#   "commit 授权 ≠ push 授权" (framework/runtime/EXTERNAL-CALL-PROTOCOL.md §External Write Gate)
#   "Push only after the human explicitly says push." (同上节：外部写入需单独授权，条件不满足则 [blocked])
#
# This script reads a machine-readable authorization state and deterministically
# allows or blocks a git push. It is called by .git/hooks/pre-push.
#
# Checks: action type / state+expiry / target_remote match / target_ref match
# (every pre-push stdin ref must equal target_ref; deletions, tags, malformed
# records and empty stdin are blocked). authorized_commit 未解析、未执行
# —— 它只是授权文件中的声明字段，对本脚本不可见。
#
# v0 Status: collaborative guardrail (deterministic but co-located with agent)
# Not an independent enforcement boundary — agent can bypass via:
#   --no-verify, fresh clone, GitHub API direct write, credential extraction
# v0.1 requires: GitHub remote policy + independent agent identity
#
# See: notes/governance-line/external-write-gate-maturity-note.md

set -euo pipefail

AUTH_FILE=".fao-gate-auth.json"
REMOTE="${1:-}"

log() {
    echo "[fao-gate] $*" >&2
}

# --- No auth state → block ---
if [[ ! -f "$AUTH_FILE" ]]; then
    log "[blocked] No authorization state found at $AUTH_FILE"
    log "[blocked] Rule: commit 授权 ≠ push 授权. Explicit push authorization required."
    exit 1
fi

# --- Parse JSON via Python (minimal dependency) ---
read_auth() {
    python3 -c '
import json, sys
try:
    with open(sys.argv[1]) as f:
        d = json.load(f)
    for k in ("state", "expires_at", "target_remote", "target_ref", "action_type"):
        print(d.get(k, ""))
except Exception as e:
    print("ERROR", file=sys.stderr)
    sys.exit(1)
' "$AUTH_FILE"
}

AUTH_OUT=$(read_auth) || {
    log "[blocked] Authorization state file is unreadable or invalid JSON"
    exit 1
}

STATE=$(echo "$AUTH_OUT" | sed -n '1p')
EXPIRES=$(echo "$AUTH_OUT" | sed -n '2p')
AUTH_REMOTE=$(echo "$AUTH_OUT" | sed -n '3p')
AUTH_REF=$(echo "$AUTH_OUT" | sed -n '4p')
ACTION_TYPE=$(echo "$AUTH_OUT" | sed -n '5p')

# --- Action type check ---
if [[ "$ACTION_TYPE" != "git-push" ]]; then
    log "[blocked] Action type mismatch. Expected 'git-push', got '$ACTION_TYPE'"
    exit 1
fi

# --- Expiry check ---
# 时间格式：UTC ISO-8601 严格格式 YYYY-MM-DDTHH:MM:SSZ（Z 表示 UTC）。
# 缺失、空值或格式错误的 expires_at 一律默认阻断（fail-closed）：
# 不依赖字典序比较未校验的输入。
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
if [[ ! "$EXPIRES" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$ ]]; then
    log "[blocked] Authorization expires_at missing, empty or malformed (expected UTC ISO-8601: YYYY-MM-DDTHH:MM:SSZ)"
    exit 1
fi
if [[ "$NOW" > "$EXPIRES" ]]; then
    log "[blocked] Authorization expired at $EXPIRES (now: $NOW)"
    exit 1
fi

# --- State check ---
if [[ "$STATE" != "authorized" ]]; then
    log "[blocked] Authorization state is '$STATE', expected 'authorized'"
    exit 1
fi

# --- Remote match (if specified) ---
# 现行协议口径：target_remote 为空时不校验 remote 别名（视为不限定），
# 非空时必须精确匹配。此行为本次不变更；如需强制限定 remote，属授权协议扩展，另行评审。
if [[ -n "$AUTH_REMOTE" && "$AUTH_REMOTE" != "$REMOTE" ]]; then
    log "[blocked] Remote mismatch. Authorized: $AUTH_REMOTE, attempted: $REMOTE"
    exit 1
fi

# --- Ref scope check (pre-push stdin) ---
# pre-push hook 的标准输入为每行 4 列：
#   <local ref> <local sha> <remote ref> <remote sha>
# 删除 ref 的判定依据是 local sha 全零；remote sha 全零仅表示远端尚无该 ref（新建）。
# 全零判定用正则 ^0+$，兼容任意对象 ID 长度（SHA-1 40 位 / SHA-256 64 位等）。
# hook 通过 exec 启动本脚本，stdin 继承，此处直接读取。
# 每条记录的 remote ref 必须与授权的 target_ref 精确一致，任一不符整体阻断。
# 输入文本只做拆分与字符串比较，不执行。

if [[ -z "$AUTH_REF" ]]; then
    log "[blocked] Authorization has no target_ref; push scope cannot be verified"
    exit 1
fi

REF_LINES=0
# || [[ -n "$RAW_LINE" ]]：最后一行无结尾换行时仍进入循环被处理（不静默跳过），
# 并受同样的四列与授权检查；校验通过即视为普通记录。
while IFS= read -r RAW_LINE || [[ -n "$RAW_LINE" ]]; do
    REF_LINES=$((REF_LINES + 1))

    # 空白行
    if [[ -z "$RAW_LINE" ]]; then
        log "[blocked] Blank line in push records (line $REF_LINES); cannot verify scope"
        exit 1
    fi

    # 严格四列校验：read 会把第 5 列及以后并入最后一个变量，
    # 故用 REST 捕获多余列；任一字段为空即缺列。
    read -r LOCAL_REF LOCAL_SHA REMOTE_REF REMOTE_SHA REST <<< "$RAW_LINE"
    if [[ -z "$LOCAL_REF" || -z "$LOCAL_SHA" || -z "$REMOTE_REF" || -z "$REMOTE_SHA" ]]; then
        log "[blocked] Malformed push record: fewer than 4 columns (line $REF_LINES); cannot verify scope"
        exit 1
    fi
    if [[ -n "$REST" ]]; then
        log "[blocked] Malformed push record: more than 4 columns (line $REF_LINES); cannot verify scope"
        exit 1
    fi

    # tag 一律阻断：即使授权文件的 target_ref 恰好就是该 tag
    if [[ "$REMOTE_REF" == refs/tags/* ]]; then
        log "[blocked] Tag push is not covered by authorization: $REMOTE_REF"
        exit 1
    fi

    # 删除 ref：local sha 全零
    if [[ "$LOCAL_SHA" =~ ^0+$ ]]; then
        log "[blocked] Ref deletion is not covered by authorization: $REMOTE_REF"
        exit 1
    fi

    if [[ "$REMOTE_REF" != "$AUTH_REF" ]]; then
        log "[blocked] Ref mismatch. Authorized: $AUTH_REF, attempted: $REMOTE_REF"
        exit 1
    fi
done

# 空输入：无法确认推送目标，默认阻断
if [[ $REF_LINES -eq 0 ]]; then
    log "[blocked] No push records on stdin; push target cannot be confirmed"
    exit 1
fi

# --- Allow ---
log "[allowed] Push authorized. remote=$REMOTE ref=$AUTH_REF lines=$REF_LINES expires=$EXPIRES"
exit 0
