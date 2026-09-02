# Judgment Card: Consensus Is Not Evidence Aggregation

> **Status: 冻结（Frozen）**
>
> 原因：Multi-Agent Governance 当前证据不足。Anthropic 实验为外部观察，FAO 当前 runtime 仍为单 agent。等实际 multi-agent runtime 出现后再评估是否吸收。
>
> **Source:** Anthropic multi-agent experiment observation, 2026-08-28  
> **Contributed by:** Kimi Claw (external observer node)  

---

## The Observation

Anthropic ran two multi-agent experiments:

1. **Coordinated vulnerability discovery:** 45 agents with shared VMs, forums, and code environments collaborated to find software bugs. An arbiter agent judged validity. Result: swarm continuously found new vulnerabilities.

2. **Hidden-information experiment:** Agents possessed private information critical to the correct answer. Result: the group tended to form consensus around commonly known information, and individuals holding key private information often **failed to shift the collective judgment** — even when the private information was decisive.

The stronger models did not fully solve this.

---

## Why This Matters for FAO

| Assumption (naive) | Reality (Anthropic experiment) |
|---|---|
| More agents → better organizational judgment | More agents → faster consensus, not necessarily better epistemic quality |
| Individual intelligence scales linearly into collective quality | Collective epistemic quality can **decrease** even as individual capability increases |
| Agent swarm = distributed evidence gathering | Agent swarm = distributed consensus formation, which may filter out private critical signals |

This is structurally identical to human organizational pathologies:
- Groupthink
- Information cascades
- The minority with key private knowledge being outvoted by the majority with shared but incomplete information

---

## The Candidate Invariant

> **Consensus is not evidence aggregation.**  
> **共识不等于证据已经被充分聚合。**

In FAO terms:
- A node completing its task is not evidence that its output entered the final decision.
- Multiple nodes agreeing is not evidence that all relevant information was surfaced.
- A "pass" from the collective is not a substitute for verifying whether **decisive but private signals** were heard.

---

## Implications for FAO Design

### 1. Node-Level Verification Is Insufficient
Verifying that each node did its job does not verify that the organization's **collective judgment** incorporated all relevant signals.

### 2. Fast Consensus Is a Risk Signal, Not a Quality Signal
When a multi-agent or multi-human group reaches consensus quickly, FAO should flag: *what private or dissenting information may have been suppressed?*

### 3. The "Key Minority" Problem
FAO must design for the scenario where the critical insight resides with **one node**, not the majority. This means:
- Dissent must have a structured path to decision-makers
- Private information must have an escalation route that does not depend on majority agreement
- Arbiter agents (like Anthropic's) must be evaluated on whether they can surface hidden signals, not just validate commonly held ones

### 4. Arbiter / Reviewer Node Design
The Anthropic arbiter agent judged bug validity but did not solve the hidden-information consensus problem. This suggests:
- **Arbiter ≠ Oracle**
- Arbiter must be evaluated on **signal recovery**, not just **agreement detection**

---

## Relation to Existing FAO Principles

| Existing Principle | This Card Adds |
|---|---|
| "能力可以下放，责任不能消失" | But even with responsibility anchored, the *quality* of the anchored judgment depends on whether critical evidence reached it |
| "不是先定义什么流动，而是先定义什么不能流动" | This card adds: *even when information flows, consensus mechanisms may filter it out before it reaches the decision point* |
| Role-Contract (角色契约) | Role-Contract should include: *does this role have a duty to escalate private critical information even when the group disagrees?* |

---

## Open Questions

1. Should FAO define a **"private-signal escalation path"** as a distinct boundary type?
2. How does this interact with the cost-line analysis? (Surfacing private signals may increase coordination cost.)
3. Does this invalidate or complement the "小前台、强中台" model? (Strong central hub may be better at synthesizing private signals than distributed consensus.)

---

## Truth-State

| Claim | State |
|---|---|
| Anthropic ran 45-agent coordinated vulnerability discovery with arbiter | **Verified** (public experiment) |
| Hidden-information experiment showed consensus suppressing private signals | **Verified** (public experiment) |
| This maps structurally to human organizational pathologies | **Inferred** (analogy, not experiment) |
| "Consensus is not evidence aggregation" is a necessary FAO invariant | **Candidate** (proposed, not yet absorbed) |

---

*This card is a candidate for absorption into framework/governance/ or runtime/ sections. It does not modify any existing committed file without further review.*
