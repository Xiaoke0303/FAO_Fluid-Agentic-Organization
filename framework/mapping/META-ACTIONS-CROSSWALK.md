# FAO 元动作跨运行时对照表

> **Truth-State**: mapping document only. no framework patch.  
> **Scope**: 元动作对照 → 参见横向比较：`CROSS-RUNTIME-ADAPTER-MAP.md` / `RUNTIME-BACK-PRESSURE-REVIEW.md`

> FAO 元动作与主流 agent/runtime 注入入口的 crosswalk。

---

## 一、文档定位

本文属于 framework/mapping/，是横向映射与转译层，不是 framework 的核心功能层级。本文仅作为 mapping/ 层的对照参考，帮助理解 FAO 元动作在主流 runtime 中大致落到什么入口。

文中出现的 **E / T / C / S / L / V** 仅作为外部参照坐标系，不替代 FAO 自身结构。

---

## 二、对照方法

| 列 | 含义 |
|----|------|
| **元动作** | FAO 定义的元动作（来自 `framework/core/META-ACTIONS.md`） |
| **当前 framework 承接文件** | FAO 骨架中承接该元动作的显式文件 |
| **Harness 参照部件** | 与 harness 六部件的对应关系（E/T/C/S/L/V） |
| **常见 runtime 落点** | 主流 agent/runtime 中该元动作的通用注入入口类型 |

**Harness 六部件说明**：
- **E** = Execution loop（执行循环）
- **T** = Tool registry（工具注册表）
- **C** = Context manager（上下文管理）
- **S** = State store（状态存储）
- **L** = Lifecycle hooks（生命周期钩子）
- **V** = Evaluation interface（评估接口）

---

## 三、核心 crosswalk 表

| 元动作 | 当前 framework 承接文件 | Harness 参照部件 | 常见 runtime 落点 |
|--------|------------------------|------------------|-------------------|
| **定向** | `SOUL.md` / `CONSTITUTION.md` | L / C | system / instruction |
| **收窄** | `ROLE-CONTRACT.md` | E / C | identity / role |
| **求真** | `TRUTH-CONTRACT.md` | E / V | runtime rules |
| **前置检查** | `PRE-FLIGHT-SEQUENCE.md` | E / L | runtime rules / hooks |
| **运行推进** | `OPERATING-RULES.md` | E | runtime rules |
| **判断调用** | `judgment-cards/README.md` | C / S | memory / repo instructions |
| **纠错写回** | `CORRECTION-WRITEBACK.md` | S / V | memory / hooks |
| **择记** | `MEMORY-INDEX.md` | S / C | memory / state store |
| **映射 / 迁移** | `MIGRATION-PLAN.md` | L / V | workspace instructions |

---

## 四、当前边界

- 本表**不是**主流 agent 平台的完整配置手册。
- 本表**不自动推出** OpenClaw / Hermes / Claude / Copilot 的具体部署文件。
- 本表只回答：**"FAO 的什么东西，大致落到什么入口"**。
- 后续如需平台级细化，应另写单独 mapping 文件（如 `OPENCLAW-MAPPING.md`、`HERMES-MAPPING.md`），而不是把本文写胖。

---

## 五、最小结论

FAO 目前已有可跨 runtime 对照的最小骨架。

mapping/ 层的作用是**翻译**，不是再加一层框架。Harness 的 **E / T / C / S / L / V** 可作为外部参照坐标，帮助理解不同 runtime 的器官划分，但不替代 FAO 自身的 core / runtime / assurance / continuity 结构。

本文保持薄、硬、可对照，作为索引使用即可。

---

*版本：v1.0*  
*性质：crosswalk / 翻译表*  
*所属：framework/mapping/*
