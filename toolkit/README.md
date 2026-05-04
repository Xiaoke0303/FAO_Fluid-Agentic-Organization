# Toolkit

> 早期最小工具集与治理实验的历史参考

---

## 当前定位

toolkit/ 保留早期 minimal-core 与 governance 实验的历史痕迹。

**它不是 FAO 的当前正式运行入口。**

当前正式的运行时与接口定义位于 [framework/](../framework/)。

## 如何阅读

仅在追溯历史设计意图、早期治理语言或最小核心实验时回看 toolkit/。

涉及当前执行、路由、成本、角色与纠错接口时，请以 framework/ 为准。

## 与 framework/ 的关系

- [framework/](../framework/) 是当前正式的运行时与接口层
- toolkit/ 中的内容可作为历史分组、实现来源或迁移对象
- **当 toolkit/ 与 framework/ 存在冲突时，framework/ 优先**
- 后续迁移以 [framework/mapping/MIGRATION-PLAN.md](../framework/mapping/MIGRATION-PLAN.md) 为准

---

## 子目录

| 目录 | 说明 |
|------|------|
| [minimal-core/](minimal-core/) | 早期最小内核分组。包含方向、薄记忆、节律等概念的历史表述。对 FAO 的气质与约束有历史参考价值，但不再是当前 runtime 的正式入口。 |
| [governance/](governance/) | 早期治理实现分组。包含真实性、外部调用、失败暴露等历史表述。部分治理组件仍被 framework/ 引用，但 toolkit/governance/ 本身不再作为项目主入口。 |
