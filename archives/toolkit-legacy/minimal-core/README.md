# Minimal Core

> 旧分组 / 历史实现来源

toolkit/minimal-core/ 继续保留，主要作为旧分组、历史实现来源与迁移来源之一。当前理解仓库整体结构的首选入口应是 [framework/](../framework/)。

---

## 重新定位

minimal-core 更接近**旧版稳定内核分组**，主要承接方向、薄记忆、节律这几条主线。它不再单独承担完整工作节点框架的上位定义，但仍然是理解项目演化的重要部分。

**它仍然重要**：
- 代表了方向、薄记忆、节律这类核心判断的早期沉淀
- 是新框架中相关内容的来源、映射对象或历史实现参考
- 保留了项目早期对"薄记忆 / 轻载运行"的核心判断

---

## 与 framework 的关系

- [framework/](../framework/) 是当前新的上位骨架候选
- [minimal-core/](./) 中的内容可作为新框架的来源、映射对象或历史实现参考
- 后续以 [framework/MIGRATION-PLAN.md](../framework/MIGRATION-PLAN.md) 为准逐步迁移

---

## 迁移状态

`minimal-core/` 当前作为**历史定向层（historical orientation）**保留，不再是当前 runtime 或治理的正式入口：

- `memory.md` — 已由 [`framework/continuity/MEMORY-INDEX.md`](../../framework/continuity/MEMORY-INDEX.md) **承接**
- `soul.md` — 方向性由根目录 `SOUL.md` 与 [`framework/core/CONSTITUTION.md`](../../framework/core/CONSTITUTION.md) **承接**
- `heartbeat.md` — 节律由根目录 `HEARTBEAT.md` 与 [`framework/rhythm/HEARTBEAT.md`](../../framework/rhythm/HEARTBEAT.md) **承接**

**说明**：minimal-core/ 是项目早期"方向、记忆、节律"三条主线的历史沉淀。这些概念已被 framework/ 和根目录 bootstrap 文件扩展、重构并承接，minimal-core/ 版本仅保留为历史参考。

---

## 原有内容说明

| 文件 | 作用 |
|------|------|
| `soul.md` | 方向层：不争、不夺、知止、不住相 |
| `memory.md` | 记忆层：薄记忆、待验证、可废弃 |
| `heartbeat.md` | 节律层：止、观、代谢 |

---

## 阅读建议

1. 先看 [framework/UNIVERSAL-WORK-NODE-FRAMEWORK.md](../framework/UNIVERSAL-WORK-NODE-FRAMEWORK.md) 理解新骨架
2. 再回看 [toolkit/minimal-core/](./)，理解其作为历史分组和实现来源的意义

---

## 原则

- 不扩展成体系
- 不解释，不辩护
- 允许修订与废弃
