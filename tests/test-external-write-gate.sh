#!/usr/bin/env bash
# tests/test-external-write-gate.sh
# Test suite for FAO External Write Gate — Minimal Vertical Slice

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

AUTH_FILE=".fao-gate-auth.json"
TEST_BRANCH="test/external-write-gate-$$"
DUMMY_FILE="test-gate-dummy-$$.md"

cleanup() {
    rm -f "$AUTH_FILE" "$DUMMY_FILE"
    git checkout -q main 2>/dev/null || true
    git branch -D "$TEST_BRANCH" 2>/dev/null || true
    git push origin --delete "$TEST_BRANCH" 2>/dev/null || true
}
trap cleanup EXIT

HOOK=".git/hooks/pre-push"
if [[ ! -f "$HOOK" ]]; then
    echo "FAIL: pre-push hook not installed at $HOOK"
    exit 1
fi

git checkout -b "$TEST_BRANCH"
echo "# test" > "$DUMMY_FILE"
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
echo "PASS: push blocked"

REMOTE_SHA=$(git ls-remote origin "refs/heads/$TEST_BRANCH" 2>/dev/null | awk '{print $1}' || true)
if [[ -n "$REMOTE_SHA" ]]; then
    echo "FAIL: remote should not exist"
    exit 1
fi
echo "PASS: remote unchanged"

echo ""
echo "=== TEST 2: POSITIVE — valid authorization ==="
EXPIRES=$(date -u -d '+1 hour' +%Y-%m-%dT%H:%M:%SZ)
cat > "$AUTH_FILE" <<EOF
{"action_type":"git-push","target_remote":"origin","target_ref":"refs/heads/$TEST_BRANCH","state":"authorized","authorized_by":"human-test","authorized_at":"$(date -u +%Y-%m-%dT%H:%M:%SZ)","expires_at":"$EXPIRES"}
EOF

set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -ne 0 ]]; then
    echo "FAIL: push should succeed"
    exit 1
fi
if ! echo "$PUSH_OUT" | grep -q "\[allowed\]"; then
    echo "FAIL: no [allowed] marker"
    exit 1
fi
echo "PASS: push allowed"

REMOTE_SHA=$(git ls-remote origin "refs/heads/$TEST_BRANCH" 2>/dev/null | awk '{print $1}' || true)
if [[ "$REMOTE_SHA" != "$LOCAL_SHA" ]]; then
    echo "FAIL: SHA mismatch remote=$REMOTE_SHA local=$LOCAL_SHA"
    exit 1
fi
echo "PASS: execution receipt verified remote=$REMOTE_SHA"

echo ""
echo "=== TEST 3: STALE AUTH — expired authorization ==="
cat > "$AUTH_FILE" <<EOF
{"action_type":"git-push","target_remote":"origin","target_ref":"refs/heads/$TEST_BRANCH","state":"authorized","authorized_by":"human-test","authorized_at":"2026-01-01T00:00:00Z","expires_at":"2026-01-01T01:00:00Z"}
EOF

set +e
PUSH_OUT=$(git push origin "$TEST_BRANCH" 2>&1)
PUSH_STATUS=$?
set -e

if [[ $PUSH_STATUS -eq 0 ]]; then
    echo "FAIL: push should be blocked (expired)"
    exit 1
fi
if ! echo "$PUSH_OUT" | grep -q "\[blocked\]"; then
    echo "FAIL: no [blocked] marker for expired auth"
    exit 1
fi
echo "PASS: expired auth blocked"

echo ""
echo "=== ALL TESTS PASSED ==="
