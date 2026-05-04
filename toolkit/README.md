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
| [minimal-core/](minimal-core/) | **历史定向层**。方向、薄记忆、节律等概念的历史表述。已由根目录 bootstrap 文件和 framework/ 承接，保留为历史参考。 |
| [governance/](governance/) | **历史治理分组**。真实性、外部调用、失败暴露等治理组件的历史表述。部分已迁移至 framework/，其余保留为 legacy 来源。 |
