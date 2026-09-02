#!/usr/bin/env bash
# scripts/external-write-gate.sh
# FAO External Write Gate — Minimal Vertical Slice
# Target action class: git remote push
#
# Governance rule enforced:
#   "commit 授权 ≠ push 授权" (EXTERNAL-CALL-PROTOCOL.md §External Write Gate)
#   "Push only after the human explicitly says push." (PUBLIC-PUSH-GATE.md)
#
# This script reads a machine-readable authorization state and deterministically
# allows or blocks a git push. It is called by .git/hooks/pre-push.
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
NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
if [[ -n "$EXPIRES" && "$NOW" > "$EXPIRES" ]]; then
    log "[blocked] Authorization expired at $EXPIRES (now: $NOW)"
    exit 1
fi

# --- State check ---
if [[ "$STATE" != "authorized" ]]; then
    log "[blocked] Authorization state is '$STATE', expected 'authorized'"
    exit 1
fi

# --- Remote match (if specified) ---
if [[ -n "$AUTH_REMOTE" && "$AUTH_REMOTE" != "$REMOTE" ]]; then
    log "[blocked] Remote mismatch. Authorized: $AUTH_REMOTE, attempted: $REMOTE"
    exit 1
fi

# --- Allow ---
log "[allowed] Push authorized. remote=$REMOTE ref=$AUTH_REF expires=$EXPIRES"
exit 0
