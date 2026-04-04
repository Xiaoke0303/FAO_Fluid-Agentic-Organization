# Governance

> 旧治理实现分组 / 历史实现来源

toolkit/governance/ 继续保留，主要作为旧治理实现来源、历史分组与迁移来源之一。当前理解仓库整体结构的首选入口应是 [framework/](../framework/)。

---

## 重新定位

toolkit/governance/ 更接近**旧治理实现分组**，主要承接真实性、外部调用、失败暴露、结构化 schema 等实现来源。它不再单独承担完整工作节点框架的上位定义，但仍然是理解项目演化的重要部分。

**它仍然重要**：
- 代表了真实性约束、外部调用检查、失败暴露、schemas 等关键治理判断的早期沉淀
- 是新框架中 Assurance 模块内容的来源、映射对象或历史实现参考
- 提供了项目早期对"真实性治理"的核心判断

---

## 与 framework 的关系

- [framework/](../framework/) 是当前新的上位骨架候选
- [governance/](./) 中的内容可作为新框架 Assurance 模块的来源、映射对象或历史实现参考
- 后续以 [framework/MIGRATION-PLAN.md](../framework/MIGRATION-PLAN.md) 为准逐步迁移

---

## 原有内容说明

| 文件 | 作用 |
|------|------|
| `TRUTH-CONTRACT-v1.md` | 真实性协议早期版本，约束规则、术语、声明格式 |
| `EXTERNAL-CALL-CHECKLIST.md` | 外部调用检查清单，覆盖网页/文件/API/执行等场景 |
| `FAILURE-REPORT-CHECKLIST.md` | 失败报告检查清单，结构化暴露边界 |
| `SHARED-TRUTHFULNESS-BLOCK.md` | 可直接嵌入 system prompt 的共享约束块 |
| `schemas/` | 执行记录、证据链、失败对象的 JSON Schema |
| `templates/` | 节点接入模板，帮助不同主体在进入协作系统时形成基本锚点 |

---

## 阅读建议

1. 先看 [framework/UNIVERSAL-WORK-NODE-FRAMEWORK.md](../framework/UNIVERSAL-WORK-NODE-FRAMEWORK.md) 理解新骨架
2. 再看 [framework/TRUTH-CONTRACT.md](../framework/TRUTH-CONTRACT.md)、[framework/OPENCLAW-MAPPING.md](../framework/OPENCLAW-MAPPING.md) 理解 Assurance 层
3. 最后回看 [toolkit/governance/](./)，理解其作为历史分组和实现来源的意义
