# Codex vs FAO Constraint Comparison Note

> Status: sidecar observation only  
> Not a framework rule. Not a whitepaper proof. Not a product endorsement. Not a local configuration sync. No immediate mainline absorption.

---

## 1. Observation Context

A local Codex workspace configuration was compared against FAO governance constraints.

Codex is treated here as a mature coding-agent / workspace execution product sample, not as a dependency of FAO.

The comparison focuses on governance constraints, not product features.

---

## 2. Core Finding

**FAO does not invent every constraint.**  
It names, aligns, and governs constraints that mature agent systems already need.

**FAO 并不发明所有约束；**  
它命名、对齐并治理成熟智能体系统本来就需要的约束。

---

**FAO gives Codex responsibility language.**  
Codex gives FAO execution-state discipline.

**FAO 给 Codex 补责任语言；**  
Codex 给 FAO 补执行状态纪律。

---

## 3. Set A — Shared Constraints

| Shared constraint | Codex-side expression | FAO-side expression | Judgment |
|---|---|---|---|
| Preflight / scope check | `Check preflight state before any action` | `PRE-FLIGHT-SEQUENCE.md` scope anchoring | Both enforce "do not act before boundary confirmation" |
| Truth-state reporting | `Use truth-state labels: verified, inferred, not checked` | `TRUTH-CONTRACT.md` explicit state labels | FAO formalizes; Codex operationalizes |
| No unverified claim | `Do not claim success without verification` | `no unverified` in truth-state table | Identical intent |
| Failure reporting | `Report failure mode explicitly` | `FAILURE-PROTOCOL.md` failure-type taxonomy | FAO adds writeback routing; Codex adds CLI exit codes |
| Target existence check | `Verify file exists before read/edit` | `Target existence / 目标存在性` in EXTERNAL-CALL-PROTOCOL | Both enforce pre-call verification |
| Minimal change / convergence | `Prefer minimal change; stop when no new insight` | `Convergence before expansion` in OPERATING-RULES | Both enforce cost control |
| Correction writeback | `Write correction to sidecar, not overwrite main state` | `Correction writeback` in FAILURE-PROTOCOL | FAO adds organizational routing; Codex adds local artifact |
| Thin memory | `Keep memory focused; archive long context` | `Thin memory principle` in MEMORY.md | FAO adds governance layer; Codex adds tool-level pruning |
| Term disambiguation | `Disambiguate terms before proceeding` | `TERM-MAP.md` explicit definition domain | FAO institutionalizes; Codex operationalizes |
| Stop / review rhythm | `Pause for human review at checkpoints` | `Stop conditions` in OPERATING-RULES / HEARTBEAT | FAO adds governance scheduling; Codex adds ad-hoc prompts |
| Git side-effect awareness | `Check git status before and after changes` | `Git diff --stat` verification in runtime | Both enforce version-control awareness |

---

## 4. Set B — FAO-stronger Constraints

| FAO-stronger constraint | FAO emphasis | Codex weaker form | Absorption judgment |
|---|---|---|---|
| Responsibility boundary | Cannot flow to non-consequence-bearing entities | Implied by tool permissions, not explicit | **absorb lightly** — FAO should formalize what Codex implies |
| Judgment boundary | Cannot be automated for consequence-bearing decisions | Implied by human checkpoints, not explicit | **absorb lightly** — FAO already enforces; Codex can add labels |
| External commitment boundary | Cannot be signed/issued/paid by AI | Not explicitly surfaced in Codex | **absorb lightly** — FAO should add to runtime guardrails |
| Role contract beyond current task | ROLE-CONTRACT.md defines standing responsibilities | Task-scoped only | **maybe later** — requires organizational context |
| Definition domain | TERM-MAP.md prevents drift across rounds | Not formalized | **maybe later** — lightweight sidecar possible |
| Human-state governance | HEARTBEAT.md patrols file/memory proliferation | Not present | **do not absorb** — Codex is single-agent; no organizational drift |
| Cost / context budget | CONTEXT-BUDGET.md governs token/tool/human cost | Not explicit | **maybe later** — runtime extension candidate |
| Multi-agent responsibility attribution | AGENTS.md tracks multi-agent boundaries | Not applicable to single-agent | **do not absorb** — Codex does not have multi-agent mode |
| Organizational correction writeback | Memory correction routed to organizational memory | Local artifact only | **maybe later** — sidecar note possible |

---

## 5. Set C — Codex-stronger Constraints

| Codex-stronger constraint | Why it matters | Possible FAO implication | Absorption judgment |
|---|---|---|---|
| Staged / unstaged / untracked distinction | Distinguishes between changes ready to commit and speculative edits | Could inform `EXTERNAL-CALL-PROTOCOL` pre-call verification | **future sidecar** — runtime/assurance thinking |
| Diff-first workflow | View diff before any write action | Could strengthen `OPERATING-RULES` pre-commit discipline | **future sidecar** — runtime hygiene note |
| Generated outputs vs source files | Separates AI-generated artifacts from human-authored code | Could inform `memory/` or `artifacts/` governance | **future sidecar** — memory-line or governance-line |
| Commit / push separation | Commit locally before remote push, allowing review | Could inform `HEARTBEAT` or runtime patrol rhythm | **future sidecar** — runtime sidecar note |
| No blanket staging | Staging must be explicit, not automatic | Could strengthen `EXTERNAL-CALL-PROTOCOL` write-action confirmation | **future sidecar** — already partially reflected |
| Local success vs remote success | Distinguishes between local tool success and remote deployment success | Could inform `FAILURE-PROTOCOL` success-state taxonomy | **future sidecar** — assurance note |
| Worktree pollution control | Keep workspace clean of untracked / generated noise | Could inform `HEARTBEAT` file-proliferation patrol | **future sidecar** — already partially reflected |
| Tests / lint / build as evidence | Use CI evidence as verification, not just assertion | Could strengthen `TRUTH-CONTRACT` evidence-chain requirement | **future sidecar** — assurance note |
| Rollback / revert discipline | Revert capability is always available | Could inform `FAILURE-PROTOCOL` correction mechanism | **future sidecar** — runtime note |
| Environment / dependency caution | Check environment before execution | Could strengthen `EXTERNAL-CALL-PROTOCOL` pre-flight scope | **future sidecar** — already partially reflected |

> **Note**: These are execution-state disciplines. They may inspire FAO runtime or assurance thinking, but should not be directly copied into the main framework.

---

## 6. Non-Sync Boundary

**Do not sync:**

- Local paths
- Personal project names
- Outputs / logs / reports / state
- Secrets / env / cookies / tokens
- Local agent identity details
- Wallet / trading / signing / deployment permissions
- Codex-specific implementation details
- Vendor-specific product behavior as FAO dependency

---

## 7. Current Recommendation

**Recommendation:**

Codex-local only + future sidecar note.  
No immediate FAO mainline sync.

This note is kept as a governance observation and calibration sample. It may later inform runtime / assurance / mapping discussions, but it does not modify FAO's core framework.

---

## 8. Candidate Future Lessons

| Candidate lesson | Possible FAO landing zone | Current action |
|---|---|---|
| Lifecycle placement before patch | `framework/runtime/` — already partially reflected in `EXTERNAL-CALL-PROTOCOL` / `FAILURE-PROTOCOL` / `OPERATING-RULES` | **Observe only** |
| Execution-state hygiene | `framework/assurance/` or `notes/governance-line/` | **Future note** |
| Artifact / source distinction | `memory/` or `notes/governance-line/` | **Future note** |
| Local vs remote success | `framework/assurance/` | **Future note** |
| Commit / push separation | `framework/runtime/` sidecar | **Future note** |

---

*Sidecar observation. Not framework rule. Not whitepaper proof. Not product endorsement.*  
*Generated: 2026-06-07*  
*Channel: kimi-claw direct*