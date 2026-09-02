# Toolkit

> 早期最小工具集与治理实验的历史参考

---

## 当前定位

**Status: non-active legacy reference**

toolkit/ 不再作为当前运行时、治理或定向入口。它保留为历史参考，用于：

- **historical traceability**：追溯 FAO 早期最小工具集与治理实验的设计意图
- **legacy schemas**：保留旧版 schema 文件（evidence_record、execution_record、failure_object）
- **partially superseded templates**：`identity-cloud-node.md` 角色边界已承接但 "Cloud Node" 身份定位无一对一 successor；`user.md` 与根目录 `USER.md` 定位不等价
- **early minimal-core and governance history**：方向、薄记忆、节律、真实性约束的早期表述

当前正式的运行时与接口定义位于 [framework/](../framework/)。

## 为什么不是 fully retired

- Cloud Node 模板尚未被 framework 完全替代
- user 模板与根目录 USER.md 定位不等价
- legacy schemas 保留但未迁移

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
