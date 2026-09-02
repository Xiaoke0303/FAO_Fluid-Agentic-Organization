# External Write Gate — Maturity Note

> **Status:** governance-line sidecar — records engineering audit conclusions  
> **Created:** 2026-09-03  
> **Scope:** FAO External Write Gate v0 → v0.1 boundary  
> **Not framework content. Not whitepaper content.**

---

## Current Maturity Level

| Component | Level |
|-----------|-------|
| External Write Gate v0 | **Executable deterministic guardrail** |
| Independent enforcement | **Not achieved** |
| GitHub remote enforcement | **Platform-feasible, not configured** |
| Independent Agent identity | **Infrastructure dependency, unconfigured** |

---

## What v0 Is

- A **collaborative guardrail** that reminds the agent to seek explicit authorization before push
- A **deterministic check** that reads `.fao-gate-auth.json` and blocks/allows based on stated rules
- A **local hook** that runs before git push when installed in `.git/hooks/pre-push`

## What v0 Is Not

- **Not** an independent enforcement boundary
- **Not** a security boundary the agent cannot bypass
- **Not** proof that "deterministic = enforceable"
- **Not** proof that "credential separation = actor separation"

---

## Audit-Proven Bypass Paths

The following bypasses were **verified** during adversarial audit (2026-09-02):

1. `git push --no-verify` — skips pre-push hook entirely
2. Fresh clone — new repo has no hook installed
3. GitHub API direct write — bypasses all local gates using stored credential
4. `chmod -x` on hook — makes hook non-executable
5. New remote with separate auth — gate checks remote alias, not actual destination

**Conclusion**: The gate is deterministic in behavior but **co-located with the governed actor**. It can be bypassed because the agent controls the same filesystem where the gate runs.

---

## Principles Verified

| Principle | Status |
|-----------|--------|
| Deterministic ≠ Enforceable | **Verified** — deterministic script ≠ boundary the agent cannot close |
| Credential separation ≠ Actor separation | **Verified** — same GitHub user with different token is still same actor |
| Governed actor ≠ Policy administrator | **Verified** — current agent uses admin OAuth token = same identity |
| Proposal ≠ Publication | **Verified** — PR proposal ≠ direct push; commit auth ≠ push auth |
| Identity ≠ Role ≠ Credential Capability | **Verified** — three distinct layers confirmed |

---

## v0.1 Requirements

To achieve independent enforcement, the following must be true:

1. **Proposal actor ≠ Approval actor**
   - Agent proposes via PR (bot identity)
   - Human approves via PR review (human identity)

2. **Governed actor ≠ Policy administrator**
   - Agent credential has no `administration` permission
   - Human admin controls branch protection / ruleset

3. **Remote policy outside agent control domain**
   - GitHub branch protection on `main`
   - Required PR review = 1
   - Agent not in bypass actor list

4. **Platform-recorded evidence**
   - PR author = bot
   - Reviewer = human
   - Merge event = GitHub platform log

---

## Infrastructure Dependency

| Dependency | Status |
|------------|--------|
| GitHub App creation | Requires human admin action |
| App installation to FAO repo | Requires human admin action |
| Fine-grained permission config | Requires human admin action |
| Branch protection on `main` | Requires human admin action |
| Installation token injection | Requires credential delivery to runtime |

**These are not FAO engineering tasks. They are infrastructure provisioning tasks.**

---

## What Changed in This Note

- v0 hook comments corrected: no longer claim "machine-level enforcement that cannot be bypassed"
- `.fao-gate-auth.json` role clarified: local workflow hint / state, not trusted authorization authority
- Framework does not claim v0 achieves independent enforcement

---

*Next step: Human admin provisions GitHub App + branch protection → runtime receives bot token → v0.1 verification.*
