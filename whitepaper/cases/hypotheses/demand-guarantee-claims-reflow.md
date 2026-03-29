> This document records a hypothesis derived from observation or case material.
> It is not yet a validated conclusion.

---

# FAO Hypothesis: Demand Guarantee Claims Reflow

## Background

Demand guarantee claims processing presents a typical scenario where structured tasks coexist with professional judgment. When a beneficiary submits a claim, the bank must examine document conformity against guarantee terms within a limited timeframe, while navigating legal constraints and compliance obligations.

## Current Misalignment

In existing workflows:
- Cognitive load concentrates on frontline operators who perform both structured checks and preliminary judgment calls
- The boundary between "formal examination" and "substantive judgment" remains ambiguous
- AML/sanctions screening often runs as a disconnected batch process, creating timing gaps
- When errors occur, accountability chains become difficult to trace

## Reflow Hypothesis

The claims process can be restructured into three routing categories:

| Category | Tasks | Routing |
|----------|-------|---------|
| **Assignable** | Document parsing, field extraction, formal requirement checking, historical record retrieval, anomaly flagging | Intelligent processing node performs structured extraction; human operator confirms |
| **Must Escalate (Expert/Compliance)** | AML/sanctions hits, fraud signals, legal disputes, clause interpretation, major discrepancies beyond simple correction, counter-guarantee coordination | Escalate to expert/compliance nodes for substantive judgment |
| **Must Escalate (Authorization)** | Amount exceeding authority limits, matters beyond authorization matrix | Route through existing authorization path |
| **Must Close** | Final payment/refusal decision, external commitment, compliance clearance, case archiving | Authorized node only |

## Three Boundaries

**Responsibility Boundary**: Intelligent processing may extract and flag, but final liability for payment/refusal rests with designated authorizers.

**Judgment Boundary**: Fraud determination, legal interpretation, and clause analysis remain with human experts; intelligent processing provides information support only.

**External Boundary**: Any legally binding communication to beneficiaries must be issued by authorized human signatories; intelligent processing may assist drafting but cannot send.

## AML / Sanctions as Cross-Cutting Compliance Layer

AML and sanctions screening function as a mandatory checkpoint across all claims:
- Runs in parallel with initial structured review
- Any hit (regardless of false-positive likelihood) triggers immediate diversion to compliance review path
- Cannot be overridden by operational nodes or intelligent processing
- Subsequent processing contingent on compliance clearance

## Pilot Boundary

This hypothesis proposes a limited pilot scope:
- **Inbound document structured review and escalation routing only**
- Intelligent processing handles parsing, formal checking, anomaly flagging, and template generation
- No modification to existing payment/refusal authorization systems
- No replacement of AML/sanctions infrastructure—only integration as caller
- No change to compliance approval authority
- No change to external notification issuance mechanisms

## What Remains to Be Validated

- Accuracy of structured field extraction against manual review
- Appropriateness of escalation triggers (false positive/negative rates)
- Integration feasibility with existing core banking and compliance systems
- Organizational acceptance of redefined role boundaries
- Measurable impact on operational risk indicators

---

*This hypothesis reflects an internal pilot proposal and has not been validated through real organizational implementation.*
