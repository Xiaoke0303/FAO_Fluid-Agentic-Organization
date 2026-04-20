# FAO (Fluid Agentic Organization)

FAO 是一个面向人类主体与智能体主体协作的组织框架项目。当前重点包括通用工作节点框架、旧工具包迁移与领域包占位。

当前仓库正在形成一个新的通用工作节点框架。[framework/](framework/) 是当前新的上位骨架候选，包含框架定义、元动作、角色契约、真实性合同、运行规则等核心文件。

旧 [toolkit/](toolkit/) 目录仍保留，作为历史分组、实现来源与迁移来源。

---

## 当前结构

| 目录 | 说明 |
|------|------|
| **[framework/](framework/)** | 通用工作节点框架。当前新的上位骨架候选，包含框架定义、元动作、OpenClaw 映射、角色、真实性、运行规则、前置检查、薄记忆、纠错协议、迁移计划等核心文件。 |
| **[toolkit/](toolkit/)** | 旧分组仍保留。[minimal-core/](toolkit/minimal-core/) 与 [governance/](toolkit/governance/) 当前作为 legacy grouping / implementation source，后续按迁移计划逐步映射。 |
| **[domains/](domains/)** | 领域包层。当前已有 [domains/guarantee/](domains/guarantee/) 作为最小占位，依赖 [framework/](framework/)，不是通用框架正文的一部分。 |

---

## framework 骨架

[framework/](framework/) 是当前理解 FAO 的首选入口：

- [core/UNIVERSAL-WORK-NODE-FRAMEWORK.md](framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md) — 框架总定义，六个功能模块说明
- [core/META-ACTIONS.md](framework/core/META-ACTIONS.md) — 14 个元动作表，骨架的元操作层
- [mapping/OPENCLAW-MAPPING.md](framework/mapping/OPENCLAW-MAPPING.md) — 与 OpenClaw 默认 bootstrap 规则的映射文档

其余文件在此骨架下展开：角色契约、真实性合同、运行规则、前置检查序列、薄记忆索引、纠错写回协议、判断卡片接口、迁移计划等。

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

成本是白皮书中的重要主线。当前 framework v1 只内含最弱形式的成本纪律（避免无谓展开、及时收敛、前置检查），尚未在本轮仓库结构中把成本全面展开为独立控制面。

---

## 建议阅读顺序

1. [framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md](framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md)
2. [framework/core/META-ACTIONS.md](framework/core/META-ACTIONS.md)
3. [framework/mapping/OPENCLAW-MAPPING.md](framework/mapping/OPENCLAW-MAPPING.md)
4. 再回看 [toolkit/](toolkit/) 与 [domains/](domains/)
5. [framework/mapping/MIGRATION-PLAN.md](framework/mapping/MIGRATION-PLAN.md) — 迁移计划（延伸阅读）

---

## 白皮书入口

- [whitepaper/FAO-Whitepaper.md](whitepaper/FAO-Whitepaper.md) —— FAO 组织分析主文
- [whitepaper/README.md](whitepaper/README.md) —— 白皮书目录与章节入口

两者并行：骨架提供运行接口，白皮书提供分析语言。

---

## 成本工作笔记

- [notes/cost-line.md](notes/cost-line.md) —— 成本主线工作笔记（working note）

成本是 FAO 后续需要展开的重要主线，当前先以 working note 形式保留。它不替代白皮书主文，也不直接构成 framework 的一部分。

---

## 当前状态

- **仓库版本**：v0.4（framework v1 骨架已形成，进入迁移与整体验证阶段）
- **白皮书版本**：v0.3（概念验证期）
- **参与方式**：提修正 / 补案例 / 指出不清楚之处

---

## 当前如何参与

当前仓库以 [framework/](framework/) 为主入口。欢迎围绕文档清晰度、接口边界、领域包形态提出修正。
