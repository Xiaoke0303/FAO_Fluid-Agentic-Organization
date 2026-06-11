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

---

## Do Not Move Back Into Framework

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
