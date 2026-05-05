# FAO (Fluid Agentic Organization)

**任务可以流动，但责任未必能流动。**

FAO（Fluid Agentic Organization，流态代理组织）关注人类主体与智能体主体共存时，任务如何在不同主体之间流转，以及这种流转对责任边界、真实性与治理结构提出的要求。

FAO 不是又一个 agent 编排框架、业务自动化方案或某个 runtime 的配置模板。它不追求让 agent 跑得更快，而是追问：当任务流动时，责任如何保持可追溯，真实性如何保持可验证，边界如何不被模糊的"协作"掩盖。

> **当前阶段**：FAO 是一个正在演化中的组织框架（evolving framework / working hypothesis）。它不是最终理论，也不是已成熟落地的商业产品。当前核心主张已初步成型，细节、案例、量化与跨 runtime 验证仍在持续补充。

---

## 一句话定义

FAO 是一种在人类主体与智能体主体共存条件下，围绕任务路由与责任锚定展开的协作方法论。

## 当前结构

| 目录 | 说明 |
|------|------|
| **[whitepaper/](whitepaper/)** | 思想主干。`FAO-Whitepaper.md` 是唯一主文。[cases/](whitepaper/cases/) 为案例支撑，[references/](whitepaper/references/) 为引用卡。不再维护 `chapters/` 拆分稿。 |
| **[framework/](framework/)** | 工程化框架。承载边界、责任、运行时约束、角色、连续性等结构。与白皮书并行，不是白皮书的附属实现。 |
| **[notes/](notes/)** | 仅保留尚未吸收的横向旁枝。[cost-line](notes/cost-line.md) 与 [memory-line](notes/memory-line.md) 未来可能被吸收进 `whitepaper/` 或 `framework/`。 |
| **[toolkit/](toolkit/)** | 不再作为当前运行时、治理或定向入口；仅保留为历史追踪、旧 schema 与部分未完全承接模板的 legacy reference。当前正式运行接口以 [framework/](framework/) 为准。 |

---

## 推荐阅读顺序

1. **[whitepaper/FAO-Whitepaper.md](whitepaper/FAO-Whitepaper.md)** —— 思想主干与组织分析主文
2. **[framework/README.md](framework/README.md)** —— 工程化框架目录与全部文件索引
3. **[notes/cost-line.md](notes/cost-line.md)** —— 成本线（未吸收旁枝）：人力成本、token 成本、组织成本结构、算法套利与生态位
4. **[notes/memory-line.md](notes/memory-line.md)** —— 记忆线（未吸收旁枝）：薄记忆、纠错写回、判断卡、长期连续性与跨节点沉淀

---

## toolkit 退位说明

`toolkit/minimal-core/` 与 `toolkit/governance/` 继续保留，主要作为旧分组的历史记录、实现来源与参考。当前不直接删除，不宣布作废。后续以 `framework/mapping/MIGRATION-PLAN.md` 为准，逐步完成内容级映射。

---

## 当前状态

- **白皮书**：组织分析主线与核心论证基本成型，细节、案例、量化与成本约束仍在补充
- **framework**：通用工作节点最小骨架已立，mapping verification、增强层协议与跨 runtime 验证仍在持续演化
- **mapping**：已启动，第一条 OpenClaw 实例已落盘，尚处早期验证阶段
- **当前重点**：入口对齐、mapping 验证推进、白皮书细节补充
- **当前适合**：少量熟人试读，不是正式开源推广。最需要反馈：是否读得懂、是否被误解为 agent framework、入口是否清楚。

---

## 实践来源

FAO 的部分判断与框架文件，来自一个持续进行的人类主体与智能体节点协作过程。当前 `mapping/verification/` 中的部分记录，是从真实讨论、纠错与写回中沉淀下来的。

这不表示 FAO 已被证明，也不表示当前协作节点是其唯一实现或指定 runtime。它只说明：framework 中关于责任边界、路由、真实性与记忆的判断，正在接受真实协作场景的检验。

---

## 当前如何参与

本仓库由组织分析层（whitepaper）与通用工作节点框架（framework）两层并行构成。欢迎围绕文档清晰度、接口边界、框架与 runtime 的映射衔接提出修正。

---

*本文件为目录索引,不重复解释 framework 正文内容。*
