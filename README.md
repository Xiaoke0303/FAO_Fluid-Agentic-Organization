# FAO (Fluid Agentic Organization)

FAO 是一个面向人类主体与智能体主体协作的组织框架项目。

## 当前阶段说明

当前主交付物为白皮书第一轮成稿（`whitepaper/FAO-Whitepaper.md`），它是理解 FAO 主线的首要入口。

`framework/` 是内部支撑骨架，用于承接与验证白皮书中的工作节点逻辑，不是当前对外交付的主阅读对象。

`domains/guarantee/` 是支撑白皮书第4-5章主线的试点假设，用于把抽象主线压到真实业务场景，不是完整产品方案。

`notes/cost-line.md` 是工作线索笔记，对外正式口径以白皮书正文为准。

---

## 当前结构

| 目录 | 说明 |
|------|------|
| **[framework/](framework/)** | 通用工作节点框架。当前新的上位骨架候选，包含框架定义、元动作、OpenClaw 映射、角色、真实性、运行规则、前置检查、薄记忆、纠错协议、迁移计划等核心文件。 |
| **[toolkit/](toolkit/)** | 旧分组仍保留。[minimal-core/](toolkit/minimal-core/) 与 [governance/](toolkit/governance/) 当前作为 legacy grouping / implementation source，后续按迁移计划逐步映射。 |
| **[domains/](domains/)** | 领域包层。当前已有 [domains/guarantee/](domains/guarantee/) 作为最小占位，依赖 [framework/](framework/)，不是通用框架正文的一部分。 |

---

## framework 骨架

[framework/](framework/) 是内部支撑骨架，用于承接与验证白皮书中的工作节点逻辑，不是当前对外交付的主阅读对象。实现支撑结构如下：

- [core/UNIVERSAL-WORK-NODE-FRAMEWORK.md](framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md) — 框架总定义，六个功能模块说明
- [core/META-ACTIONS.md](framework/core/META-ACTIONS.md) — 14 个元动作表，骨架的元操作层
- [mapping/OPENCLAW-MAPPING.md](framework/mapping/OPENCLAW-MAPPING.md) — 与 OpenClaw 默认 bootstrap 规则的映射文档
- [assurance/TRUTH-CONTRACT.md](framework/assurance/TRUTH-CONTRACT.md) — 真实性合同
- [runtime/OPERATING-RULES.md](framework/runtime/OPERATING-RULES.md) — 运行母规则
- [runtime/CONTEXT-BUDGET.md](framework/runtime/CONTEXT-BUDGET.md) — 运行时成本量化接口
- [continuity/MEMORY-INDEX.md](framework/continuity/MEMORY-INDEX.md) — 长期连续性薄索引
- [continuity/CORRECTION-WRITEBACK.md](framework/continuity/CORRECTION-WRITEBACK.md) — 纠错写回协议

其余文件在此骨架下展开：角色契约、前置检查序列、判断卡片接口、迁移计划等。

---

## toolkit 退位说明

[toolkit/minimal-core/](toolkit/minimal-core/) 与 [toolkit/governance/](toolkit/governance/) 继续保留，主要作为：

- 旧分组的历史记录
- 实现来源与参考
- 迁移计划的映射来源

当前不直接删除，不宣布作废。后续以 [framework/mapping/MIGRATION-PLAN.md](framework/mapping/MIGRATION-PLAN.md) 为准，逐步完成内容级映射。

---

## domains 占位

[domains/guarantee/](domains/guarantee/) 当前只是最小领域包占位：

- 证明 [framework/](framework/) 可以承接具体专业域
- 不代表保函领域包已完整成形
- 不代表仓库已内置完整法律意见系统

---

## 成本主线占位

成本是白皮书中的重要主线。运行时成本最小闭环已形成（`OPERATING-RULES.md` 承接触发条件与推进规则，`CONTEXT-BUDGET.md` 承接量化接口），组织级成本仍在白皮书展开。

---

## 建议阅读顺序

1. [whitepaper/FAO-Whitepaper.md](whitepaper/FAO-Whitepaper.md) —— FAO 组织分析主文
2. [framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md](framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md) —— 如需查看实现支撑
3. [domains/guarantee/](domains/guarantee/) —— 如需查看业务落点

---

## 白皮书入口

- [whitepaper/FAO-Whitepaper.md](whitepaper/FAO-Whitepaper.md) —— FAO 组织分析主文，当前唯一首要入口
- [whitepaper/README.md](whitepaper/README.md) —— 白皮书目录与章节入口

需要查看实现支撑时，再进入 `framework/`；需要查看业务落点时，再进入 `domains/guarantee/`。

---

## 成本工作笔记

- [notes/cost-line.md](notes/cost-line.md) —— 成本主线工作笔记（working note）

成本是 FAO 后续需要展开的重要主线，当前先以 working note 形式保留。它不替代白皮书主文，也不直接构成 framework 的一部分。

---

## 当前状态

- **仓库版本**：v0.4
- **白皮书版本**：v0.3 → 第4-6章已完成本轮改写（路由接入成本约束、验证与纠错机制替代治理问题、成本约束并入边界讨论），当前进入第一轮成稿整理阶段
- **框架版本**：framework v1 骨架已形成，与白皮书并行维护
- **当前重点**：白皮书主文口径统一、分章同步、README 对齐
- **参与方式**：提修正 / 补案例 / 指出不清楚之处

---

## 当前如何参与

当前仓库以白皮书主文为首要入口，framework/ 为支撑骨架。欢迎围绕文档清晰度、接口边界、领域包形态提出修正。
