# framework/

> framework 目录索引页

---

## 文档定位

本目录是 FAO 当前正式的 **运行时与接口层(runtime and interface layer)**。

framework/ 将 whitepaper/ 中的组织分析主张翻译为可操作的接口与约束,包括工作节点结构、角色契约、运行规则、上下文预算、记忆/纠错写回接口,以及元动作与路由约束。

---

## 与 whitepaper/ 的关系

whitepaper/ 提供组织分析语言与论证。
framework/ 提供运行接口与操作约束。
两者并行,互不替代。

## 与 toolkit/ 的关系

toolkit/ 保留为早期最小工具集与治理实验的历史参考。
当 framework/ 与 toolkit/ 存在冲突时，**framework/ 优先**。

toolkit/ 当前为 **non-active legacy reference**：不再作为运行时、治理或定向入口，仅保留为历史追踪、旧 schema 与部分未完全承接模板的 legacy 来源。

---
---

## Reading Map: Four Roots to Framework Modules

```text
Four roots:

- Orientation / Constitution → core/
  - CONSTITUTION.md anchors non-transferable boundaries and base constraints.
- Role / Responsibility → role/
  - ROLE-CONTRACT.md defines who may do what, and where responsibility remains anchored.
- Continuity / Memory → continuity/
  - MEMORY-INDEX.md and CORRECTION-WRITEBACK.md define what persists, what is corrected, and how judgment remains traceable.
- Rhythm / Cadence → rhythm/
  - HEARTBEAT.md defines when to pause, observe, metabolize, or continue.

Branches grown from the roots:

- Assurance → assurance/
  - Truth, evidence, and completion-state constraints grown from constitutional boundaries.
- Runtime → runtime/
  - Execution rules, pre-flight checks, external calls, failure handling, cost, and term discipline.
- Mapping → mapping/
  - Alignment layer for translating concepts, legacy files, domain cases, and external references into FAO framework layers.
```

---

## 建议阅读顺序

1. [core/UNIVERSAL-WORK-NODE-FRAMEWORK.md](core/UNIVERSAL-WORK-NODE-FRAMEWORK.md) - 框架总定义
2. [core/CONSTITUTION.md](core/CONSTITUTION.md) - 上位约束理由层
3. [core/META-ACTIONS.md](core/META-ACTIONS.md) - 元动作表
4. [rhythm/HEARTBEAT.md](rhythm/HEARTBEAT.md) - 时间组织原则层
5. [role/ROLE-CONTRACT.md](role/ROLE-CONTRACT.md) - 角色契约
6. [runtime/OPERATING-RULES.md](runtime/OPERATING-RULES.md) - 运行母规则
7. [runtime/PRE-FLIGHT-SEQUENCE.md](runtime/PRE-FLIGHT-SEQUENCE.md) - 前置检查序列
8. [runtime/TERM-MAP.md](runtime/TERM-MAP.md) - 术语消歧入口
9. [assurance/TRUTH-CONTRACT.md](assurance/TRUTH-CONTRACT.md) - 真实性合同
10. [runtime/EXTERNAL-CALL-PROTOCOL.md](runtime/EXTERNAL-CALL-PROTOCOL.md) - 外部调用协议
11. [runtime/FAILURE-PROTOCOL.md](runtime/FAILURE-PROTOCOL.md) - 失败协议
12. [continuity/MEMORY-INDEX.md](continuity/MEMORY-INDEX.md) - 长期连续性薄索引
11. [continuity/CORRECTION-WRITEBACK.md](continuity/CORRECTION-WRITEBACK.md) - 纠错写回协议
12. [mapping/OPENCLAW-MAPPING.md](mapping/OPENCLAW-MAPPING.md) - OpenClaw 映射
13. [mapping/MIGRATION-PLAN.md](mapping/MIGRATION-PLAN.md) - 迁移计划

---

## 文件分组

### core/ 骨架定义
- [core/UNIVERSAL-WORK-NODE-FRAMEWORK.md](core/UNIVERSAL-WORK-NODE-FRAMEWORK.md) - 框架总定义,六个功能模块说明
- [core/CONSTITUTION.md](core/CONSTITUTION.md) - 上位约束理由层(冲突仲裁与修订锚定)
- [core/META-ACTIONS.md](core/META-ACTIONS.md) - 14 个元动作表

### role/ 角色层
- [role/ROLE-CONTRACT.md](role/ROLE-CONTRACT.md) - 角色契约(收口资格与边界收窄)

### runtime/ 运行时
- [runtime/OPERATING-RULES.md](runtime/OPERATING-RULES.md) - 运行母规则
- [runtime/PRE-FLIGHT-SEQUENCE.md](runtime/PRE-FLIGHT-SEQUENCE.md) - 前置检查序列
- [runtime/TERM-MAP.md](runtime/TERM-MAP.md) - 术语消歧入口
- [runtime/EXTERNAL-CALL-PROTOCOL.md](runtime/EXTERNAL-CALL-PROTOCOL.md) - 外部调用协议
- [runtime/FAILURE-PROTOCOL.md](runtime/FAILURE-PROTOCOL.md) - 失败协议
- [runtime/CONTEXT-BUDGET.md](runtime/CONTEXT-BUDGET.md) - 上下文预算

### assurance/ 真实性保障
- [assurance/TRUTH-CONTRACT.md](assurance/TRUTH-CONTRACT.md) - 真实性合同

### continuity/ 连续性管理
- [continuity/MEMORY-INDEX.md](continuity/MEMORY-INDEX.md) - 长期连续性薄索引
- [continuity/CORRECTION-WRITEBACK.md](continuity/CORRECTION-WRITEBACK.md) - 纠错写回协议
- [continuity/judgment-cards/README.md](continuity/judgment-cards/README.md) - 判断卡片接口
- [continuity/schemas/correction_record.schema.json](continuity/schemas/correction_record.schema.json) - 纠错记录 Schema

### rhythm/ 节律层
- [rhythm/HEARTBEAT.md](rhythm/HEARTBEAT.md) - 时间组织原则层(止、观、代谢)

### mapping/ 迁移与映射
- [mapping/OPENCLAW-MAPPING.md](mapping/OPENCLAW-MAPPING.md) - OpenClaw 映射文档
- [mapping/HERMES-MAPPING.md](mapping/HERMES-MAPPING.md) - Hermes 运行时路由样本映射
- [mapping/META-ACTIONS-CROSSWALK.md](mapping/META-ACTIONS-CROSSWALK.md) - 元动作交叉映射
- [mapping/MIGRATION-PLAN.md](mapping/MIGRATION-PLAN.md) - 迁移计划

---

*本文件为目录索引,不重复解释 framework 正文内容。*
