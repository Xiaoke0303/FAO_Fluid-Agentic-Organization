# FAO Runtime Back-Pressure Review

> **Truth-State**: analysis only. no repo write. no commit. no push. based on 2026-06-09 repository coherence review. no external re-check performed.

---

## Purpose

本文记录 Cross-Runtime Adapter Map 对 framework / whitepaper / case line 的反向压力复核结果。

不是重构计划。不是 governance patch。只是 pressure-test 记录。

---

## What Was Verified

| 对象 | 结果 | 证据 |
|---|---|---|
| **whitepaper** | clean | grep 零匹配：OpenClaw, Hermes, Codex, Claude Code, cron, gateway, MCP, subagent 等 |
| **mapping** | correctly externalized | HERMES-MAPPING.md 明确区分组织路由与运行时路由；无 governance 概念混用 |
| **framework gaps** | emerging but not patch-ready | 5 个缺口已识别，但阈值不足，暂不补 |
| **guarantee case line** | missing | 保函 maker-checker / external commitment / context drift 等尚未形成独立案例 |

---

## Framework Gap Candidates

| 缺口 | 当前状态 | 为什么暂不补 |
|---|---|---|
| runtime action vs retained capability | not found | 仅 3 个 runtime 均暴露，但无 case line 吸收 |
| memory recall vs memory injection | not found | 同理；需 case line 验证 |
| unattended execution / cron tiering | not found | 同理；需 case line 验证 |
| professional workspace responsibility | partially covered | 已有 EXTERNAL-CALL-PROTOCOL 副作用边界，但无显式命名 |
| local body / remote host / permission boundary | partially covered | 已有目标存在性检查，但无 body boundary 概念 |

### Cross-Runtime Execution Validation Gap

> 来源：歸藏《万字长文：做了些爆款 Skills 以后，我对 Skills 的看法》（2026-06-14），外部观察材料，未验证为框架依据。

Skill 实践中的外部观察：同一个 Skill 在一个模型或 Agent harness 下能正常工作，在另一个下可能失败——因为路由解释、版式约束、脚本调用、文件访问或工具调用行为在不同 runtime 之间存在差异。

FAO mapping 存在同样的压力点。runtime 映射不能仅仅因为文档内部自洽就视为已验证。应仅在映射规则已在目标 runtime 环境中实际执行并复核后，才标记为执行验证通过。

建议最小状态词汇：

- **documented**：映射存在，但未执行验证
- **partially exercised**：存在有限的本地测试，但覆盖不完整
- **execution-verified**：代表性任务已在目标 runtime 中运行且结果已复核
- **evidence pending**：声称存在兼容性，但尚未附上运行日志或收口记录

治理含义：跨 runtime 兼容性应被视为验证对象，而非写作风格。Cross-Runtime Adapter Map 和 Runtime Back-Pressure Review 应区分「已文档化的兼容性」和「已执行的兼容性」。

各 runtime 的当前证据状态应单独追踪，不做统一结论。

### Thin Harness, Fat Skills as Runtime Pressure Relief

> 来源：歸藏《万字长文：做了些爆款 Skills 以后，我对 Skills 的看法》（2026-06-14），外部观察材料，未验证为框架依据。

歸藏提出一个 Skill 架构原则：harness 保持薄，只负责模型循环、文件读写、权限、安全边界和上下文管理；Skill 承载流程、领域知识、模板、scripts、eval、gotchas 和失败经验。这被概括为 **Thin Harness, Fat Skills**。

从 runtime 压力角度，这一结构的价值是：

- **降低 harness 复杂度**：harness 不膨胀为「大而全 Agent」，避免 context rot 和无限累积的治理负担
- **隔离能力迭代**：Skill 的更新不触及 harness 核心，降低了能力迭代的回滚风险
- **可分发、可审查、可替换**：Skill 作为独立单元，可被审计、被替换、被弃用，而不影响 harness 稳定性
- **失败局部化**：单个 Skill 的失败（gotchas 失效、eval 漏过）可以被定位到该 Skill，而非扩散到整个 harness

**与 FAO 的映射**：这对应「收窄」元动作在 runtime 层的具体实现。harness 保持薄 = 收窄后的通用角色；Skill 保持厚 = 专业能力的边界封装。能力可以被分发，但 harness 本身不承载能力分发后的责任追踪。

**但有一个 governance 张力**：当 Skill 被分发到多个 harness 时，谁来维护 Skill 的 gotchas 和 eval？歸藏的建议是——人定义品味和边界，Agent 负责收集证据、提出改动、补充 eval 和维护长尾经验。这与 FAO 的「人保留判断，Agent 辅助验证」一致，但尚缺 case line 验证。

**当前状态**：作为 framework 缺口观察记录，不进入主干。待至少 1 个 case line 吸收后，再评估是否进入 runtime 母规则。

以下产品细节**不应**进入 framework 主干：

- OpenClaw 实现细节（gateway daemon, channel plugins, bootstrap injection 规则）
- Hermes 功能列表（六 backend, Honcho dialectic, Hindsight, MCP）
- Codex / Claude Code 产品细节（diff-first, staged/unstaged, IDE 集成）
- Desktop / gateway / backend 技术说明
- 任何未验证的外部 runtime 实现细节

---

## Minimal Decision Rule

**framework 修改门槛**：

- 至少 3 个独立 runtime 验证同一缺口
- 至少 1 个 case line 吸收该缺口
- 两者同时满足，才进入 framework 主干讨论

当前缺口：尚未满足 case line 条件。

---

## Recommended Next Step

1. **保函 case line / LG responsibility mapping**：优先补，作为压力测试层。
2. **notes-sidecar**：framework 缺口先以 sidecar 记录，不立即 patch。
3. **framework 主干**：冻结，待 case line 吸收后再评估。

---

## End State Declaration

本文不修改 framework。不修改 whitepaper。不新增理论。不创建新 governance 模块。

如需更新，在 framework/mapping/ 内完成，不回合并 framework/core/ 或 framework/runtime/。


## Hermes Local Test Note (2026-06-12)

- Hermes local L4 AGENTS.md test supports the retained capability concern: Hermes refused delegation, memory persistence, and skill creation under project-scoped constraints. Memory / skill refusal boundaries are practical governance surfaces. **Do not convert this into a framework patch yet.**

---

*版本：v1.0 | 基于 2026-06-09 验证结果 | 追加：2026-06-12*
