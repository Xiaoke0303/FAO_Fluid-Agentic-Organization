# Stateless Decision Memory for Enterprise AI Agents — FAO Memory-Line Sidecar Note

> **定位**：外部概念参照，非白皮书主文组成部分。用于 FAO memory-line 的横向校准，不承担主论证功能。

---

## 论文基本信息

| 字段 | 内容 |
|------|------|
| 标题 | Stateless Decision Memory for Enterprise AI Agents |
| 作者 | Vasundra Srinivasan（AI Architect, O'Reilly; Stanford School of Engineering） |
| 提交日期 | 2026-04-22 |
| arXiv ID | 2604.20158v1 |
| 链接 | https://arxiv.org/abs/2604.20158 |
| 同伴论文 | Four-Axis Decision Alignment for Long-Horizon Enterprise AI Agents（arXiv:2604.XXXXX, 2026） |

---

## 核心命题

企业级 Agent 记忆的首要问题不是「状态更强」，而是以下四项系统属性是否 load-bearing：

1. **Deterministic replay** — 同一输入必须产出同一决策，可被重新评分和复核
2. **Auditable rationale** — 审计方（监管、内审、法庭）能 inspect 完整理由链
3. **Multi-tenant isolation** — A 申请人资料不可泄漏进 B 的决策上下文
4. **Statelessness for horizontal scale** — 千级并发决策不可 bottleneck 于共享可变状态

论文指出： Stateful memory architectures violate these four properties **by construction**，违规幅度随部署成熟度 compounding。 这解释了为什么企业部署在受监管领域（underwriting、claims adjudication、clinical review、tax examination）中，RAG 等「较弱」架构反而压倒 state-of-the-art 的 stateful 记忆方案。

---

## DPM 架构摘要

**全称**：Deterministic Projection Memory

**核心设计**：
- **Append-only immutable event log** — 轨迹作为不可变事件日志，单一事实来源
- **Single task-conditioned projection at decision time** — 决策时执行一次任务条件投影（temperature zero），提取结构化 facts / reasoning points / compliance notes，受预算约束
- **Pure projection** — 从同一日志、同一模型版本回放，产生（在残余 API 不确定性范围内）同一记忆视图

**性能数据**（10 个受监管决策案例，3 档记忆预算）：
- 宽松预算下：与 summarization-based memory **无显著差异**（四轴决策对齐，paired permutation, n=10）
- 预算收紧（20× 压缩比）：
  - factual precision +0.52（Cohen's h=1.17, p=0.0014）
  - reasoning coherence +0.53（h=1.13, p=0.0034）
- 速度：7–15× 更快，决策时 1 次 LLM call vs. trajectory 上 N 次

**审计面**：
- DPM：每决策仅记录 2 次 LLM call（一次 projection）
- Summarization baseline：LongHorizon-Bench 上每决策记录 83–97 次 LLM call

---

## 与 FAO 的对应关系

| DPM 属性 | FAO 对应项 | 说明 |
|----------|-----------|------|
| Append-only event log | **薄记忆** | 不持续改写内部状态，事件是单薄的、不可变的 |
| Deterministic replay | **真相优先** | 同一日志必须回放出同一决策，truth 先于 convenience |
| Auditable rationale | **责任可见** | 审计方能 inspect 完整链路，责任不能躲在黑箱后 |
| Budget-conditioned projection | **成本预算** | 记忆不是无限资源，决策时必须受预算约束 |
| Multi-tenant isolation + statelessness | **边界先于流动** | 什么能共享、什么不能共享，先定义边界再谈流动 |

**深层共鸣**：
- DPM 的「event log 是唯一 source of truth」与 FAO 的「未验证不能冒充已确认」同构
- DPM 的「projection 是 pure function」与 FAO 的「任务投影不应污染共享状态」同构
- 两者都把「记忆」从「累积可变状态」重新定义为「受约束的回放与投影」

---

## 对保函场景的启发

保函（银行保函 / 贸易保函）是受监管决策的典型域：开立、修改、索赔、赔付、拒付，每一步都可能触发合规审查和争议仲裁。

**优先事项**：
1. **建立事件日志** — 保函开立→修改→索赔→赔付/拒付的每一步，都应作为 append-only event 记录，而非 summary 后覆盖
2. **决策点生成结构化投影** — 在「是否赔付」「是否修改条款」等决策点，从事件日志中生成包含 facts / reasoning / compliance notes 的受预算约束投影
3. **拒绝经验型厚记忆** — 不宜先建立「历史案例经验库」作为可变状态，因为经验型记忆会引入不可审计的隐性 bias，且在 multi-tenant 场景下难以隔离

**具体映射**：
- 保函开立：记录 applicant info、条款、反担保结构 → event
- 修改：记录修改请求、审批链、条款 diff → event
- 索赔：记录索赔文件、审核节点、合规检查 → event
- 赔付/拒付：记录最终决策投影、facts、reasoning、compliance notes → event + projection

**警示**： 如果先做「案例经验型记忆」（如把所有历史保函索赔结果压缩成一个向量库），会同时 violate DPM 的四项属性： replay 不可确定、理由不可审计、multi-tenant 不可隔离、状态不可水平扩展。

---

## 限制（未经验证、需审慎吸收）

| 限制项 | 说明 |
|--------|------|
| **arXiv v1** | 未经同行评审，结论可能变动 |
| **样本量小** | n=10 个受监管案例，统计功效有限 |
| **单模型族** | 实验基于 Anthropic 模型，未跨模型族验证 |
| **Temperature zero 仍有 API 残余不确定性** | 论文明确承认 live API 上无法实现 bit-exact replay，需 pairing 确定性推理 runtime 才能达到完整确定性 |
| **超长轨迹需 hierarchical projection** | 超过单 call context window 时，hierarchical projection 会重新引入中间 LLM call，部分恢复审计不确定性和状态耦合问题 |
| **非 accuracy win** | 论文声称贡献不是决策精度提升，而是 statelessness 作为 load-bearing property 的系统论证 |

---

## FAO 暂定吸收句

> 在企业级 Agent 组织中，长期记忆的首要形态不应是可变状态，而应是可审计事件流；所谓记住，不是持续改写内部记忆，而是在决策时从事件流中生成受预算约束的任务投影。

---

## 附：TAMS 启发式（论文 practitioner 工具）

TAMS = **T**enant isolation × **A**uditability × **M**emory budget × **S**tatelessness

当四项中任意一项为 deployment load-bearing 时，stateful memory architectures 的隐性成本会 compounding。FAO 的「边界先于流动」可视为 TAMS 的治理层映射。

---

*文件创建：2026-04-27*
*定位：notes/memory-line/ 外部参照，不进入 whitepaper 主论证*
