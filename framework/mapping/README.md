# framework/mapping/

> Horizontal alignment and translation layer. Not framework core grammar. Not governance ontology.

---

## 定位

`framework/mapping/` 是 **横向对齐与转译层**（horizontal alignment and translation layer）。

- 它**不属于** framework 主干语法。
- 它**不定义** FAO 核心概念。
- 它**只负责**把外部 runtime 翻译成 FAO 责任语言。
- 如果文件命名具体产品或 runtime，应留在 mapping。
- 如果文件命名责任边界，才可能进入 framework 主干。

---

## 文件结构

| 文件 | 类型 | 说明 |
|------|------|------|
| `OPENCLAW-MAPPING.md` | 单体映射 | OpenClaw 本地开放运行体映射 |
| `HERMES-MAPPING.md` | 单体映射 | Hermes 技能记忆闭环运行体映射 |
| `CODEX-MAPPING.md` | 单体映射 | Codex / Claude Code 专业编程智能体映射 |
| `META-ACTIONS-CROSSWALK.md` | 元动作对照 | FAO 元动作与 harness 部件 crosswalk |
| `MIGRATION-PLAN.md` | 迁移计划 | framework v1 骨架接管旧分类法的映射方案 |
| `CROSS-RUNTIME-ADAPTER-MAP.md` | 横向比较 | OpenClaw / Hermes / Codex 三类运行体横向对比 |
| `RUNTIME-BACK-PRESSURE-REVIEW.md` | 反向压力复核 | 映射结论对 framework / whitepaper / case line 的反向压力检查 |
| `verification/` | 验证记录 | 已验证的 mapping 断言归档 |

---

## 结构逻辑

单体映射 → 横向比较 → 反向压力复核

- **单体映射**：单个 runtime 的器官结构与 FAO 对应关系
- **横向比较**：跨 runtime 的共性治理压力点提炼
- **反向压力复核**：映射结论是否对 framework / whitepaper / case line 构成 back-pressure

---

## 边界

- mapping 文件**不回流** framework 主干。
- mapping 结论**不直接**成为 governance rule。
- mapping 中的产品细节**不进入** whitepaper 正文。
- 只有经过至少 3 个独立 runtime 验证 + 1 个 case line 吸收后，mapping 结论才考虑进入 framework 主干讨论。

---

*索引文件。非理论文档。非操作手册。*
