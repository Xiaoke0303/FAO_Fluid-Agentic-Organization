# FAO (Fluid Agentic Organization)

**任务可以流动，但责任未必能流动。**

FAO（Fluid Agentic Organization，流态代理组织）关注人类主体与智能体主体共存时，任务如何在不同主体之间流转，以及这种流转对责任边界、真实性与治理结构提出的要求。

FAO 不是又一个 agent 编排框架、业务自动化方案或某个 runtime 的配置模板。它不追求让 agent 跑得更快，而是追问：当任务流动时，责任如何保持可追溯，真实性如何保持可验证，边界如何不被模糊的"协作"掩盖。

## 当前阶段说明

白皮书第一轮成稿（`whitepaper/FAO-Whitepaper.md`）是理解 FAO 组织分析主线的入口之一。当前项目已扩展为组织分析层与通用工作节点框架双层并行。

`framework/` 是通用工作节点框架，与白皮书并行，不是白皮书的附属实现。

`notes/cost-line.md` 与 `notes/memory-line.md` 是 sidecar working notes，不是 framework 本体，对外正式口径以白皮书正文为准。

---

## 当前结构

| 目录 | 说明 |
|------|------|
| **[framework/](framework/)** | 通用工作节点框架。当前新的上位骨架候选，包含框架定义、元动作、OpenClaw 映射、角色、真实性、运行规则、前置检查、薄记忆、纠错协议、迁移计划等核心文件。 |
| **[toolkit/](toolkit/)** | 旧分组仍保留。[minimal-core/](toolkit/minimal-core/) 与 [governance/](toolkit/governance/) 当前作为 legacy grouping / implementation source，后续按迁移计划逐步映射。 |
| **[domains/](domains/)** | 领域包占位。预留 framework 向具体专业域的扩展接口，当前无已展开的活跃领域包。 |

---

## framework 骨架

`framework/` 是通用工作节点框架。以下为核心文件索引：

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

## 主线笔记入口

以下 working notes 作为 sidecar 保留，不替代白皮书主文，也不直接构成 framework 的一部分。

- `notes/cost-line.md` —— 成本主线 working note
- `notes/memory-line.md` —— 记忆主线 working note

---

## 成本主线占位

成本是白皮书中的重要主线。运行时成本最小闭环已形成（`OPERATING-RULES.md` 承接触发条件与推进规则，`CONTEXT-BUDGET.md` 承接量化接口），组织级成本仍在白皮书展开。

---

## 阅读入口

本项目当前有三个并行入口：

- `whitepaper/` —— 组织分析层
- `framework/` —— 通用工作节点框架
- `framework/mapping/verification/` —— 映射与实例验证层

读者可按需求进入对应入口，无需强制单一路径。

### 组织分析层

面向 FAO 的组织分析与核心论述。

- `whitepaper/FAO-Whitepaper.md` —— FAO 组织分析主文
- `whitepaper/README.md` —— 白皮书目录与章节入口

### 通用工作节点框架

面向通用工作节点的框架定义、元动作与运行规则。与白皮书并行，不是白皮书的附属实现。

- `framework/core/UNIVERSAL-WORK-NODE-FRAMEWORK.md` —— 框架总定义
- `framework/README.md` —— 框架目录与全部文件索引

### 映射与实例验证层

面向框架在真实运行时中的映射衔接与验证记录。当前已启动，尚处早期。

- `framework/mapping/verification/` —— 实例验证记录（第一条 OpenClaw 样本已落盘）
- `framework/mapping/MIGRATION-PLAN.md` —— framework 迁移计划与阶段定义
- `framework/mapping/OPENCLAW-MAPPING.md` —— OpenClaw 映射文档

### 参考目录

以下目录不作为当前主入口，仅供参考。

- `toolkit/` —— 早期实验与 legacy 分组，历史记录与实现来源
- `whitepaper/cases/` —— 白皮书配套案例与观察材料，随白皮书正文阅读
- `notes/` —— sidecar working notes，见上方「主线笔记入口」节

---

## 当前状态

- **仓库版本**：v0.4
- **白皮书版本**：v0.3 → 第4-6章已完成本轮改写（路由接入成本约束、验证与纠错机制替代治理问题、成本约束并入边界讨论），当前进入第一轮成稿整理阶段
- **框架版本**：framework v1 骨架已形成，与白皮书并行维护
- **当前重点**：framework v1 收口后的入口对齐与 mapping 验证推进
- **参与方式**：提修正 / 补案例 / 指出不清楚之处

---

## 当前如何参与

本仓库由组织分析层（whitepaper）、通用工作节点框架（framework）与映射验证层（mapping）三层并行构成。欢迎围绕文档清晰度、接口边界、框架与 runtime 的映射衔接提出修正。
