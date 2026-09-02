# TODO: FAO Runtime Guard / 外置规制层

> **Status: 冻结（Frozen）**
> 
> 原因：External Write Gate v0 审计已证明 "Deterministic ≠ Enforceable"，prompt-governance 升级为 policy-as-code 的设想需要独立基础设施（GitHub App / 身份分离），当前不继续实施。
>
> 不删除本文件，仅冻结。未来如需重新打开，需满足：独立 runtime enforcement 可行、有具体 runtime 实例、有验证证据。
>
> Created: 2026-07-08
> Trigger: 自然语言上下文规制稳定性讨论

---

## Problem

当前 FAO 的治理约束主要通过自然语言 prompt / 对话上下文 / 角色说明注入。该方式能表达原则，但不能稳定承担执行约束。

## Risk

- 上下文可能被截断或稀释
- 不同模型对规则解释不同
- 工具调用压力可能覆盖原则声明
- prompt injection 可能污染规制上下文
- Agent 可能"知道应该做什么"，但实际行动偏离
- 跨 runtime 执行结果缺乏一致验证

## Engineering Principle: Weakest Link

系统可靠性不取决于最强的自然语言原则声明，而取决于最弱的执行约束层。

Prompt-level alignment 可以表达意图，但不能单独保证 action-level compliance。当权限判断、工具调用、外部副作用控制、post-check、failure writeback 中任何一环薄弱时，整个治理系统仍会在该环失效。因此，外置 side-effect gate、permission check、post-execution verification、ledger 与 regression eval 是防止最弱链定义系统整体行为的必要补充。

## Direction

将 FAO 从 prompt-governance 升级为：

**policy-as-code + runtime-gate + structured action-card + regression-eval**

## Minimal Design Candidate

候选结构：

```
fao-policy.yaml
role-contracts/
  codex.yaml
  kimi.yaml
  xiaoke.yaml
schemas/
  action-card.schema.json
  truth-state.schema.json
  permission-check.schema.json
evals/
  unauthorized-write.test.yaml
  context-drift.test.yaml
  external-side-effect.test.yaml
  memory-writeback.test.yaml
logs/
  action-ledger.jsonl
```

## Core Mechanism

模型不直接决定行动是否执行。模型只提出 action card，由外置 runtime checker 判断：

- **ALLOW**：允许执行
- **PAUSE**：范围不清，暂停
- **ESCALATE**：需要用户确认
- **REJECT**：越权、触碰 secrets、外部副作用、未授权写入等

## FAO Mapping

"知行合一"的工程化表达：

- **知** = role contract / policy / principle
- **行** = tool call / file write / external side-effect
- **合一** = action 前后的可验证 gate + ledger + writeback

## Truth-State

| 声明 | 状态 |
|------|------|
| Harvey Lederman 研究王阳明"知行合一" | `public-source candidate` |
| Lederman 加入 Anthropic 从事 alignment / character | `public-source candidate` |
| "Anthropic 官方用王阳明训练 Claude" | `unverified / media inference` |
| FAO 工程化方向 | `internal design candidate` |

## Next Step

仅记录为 candidate TODO。后续如用户授权，再展开为：

1. notes candidate
2. runtime design note
3. minimal schema draft
4. cross-runtime validation test plan

---

*closure: 仅记录，未触碰 framework/ whitepaper/ 主干。未 commit。未 push。*
