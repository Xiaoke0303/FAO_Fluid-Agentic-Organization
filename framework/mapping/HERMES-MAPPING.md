# Hermes Mapping

> **Truth-State**: mapping document only. no framework patch. no external re-check.  
> **Scope**: 单体映射 → 参见横向比较：`CROSS-RUNTIME-ADAPTER-MAP.md` / `RUNTIME-BACK-PRESSURE-REVIEW.md`

> Hermes Agent 作为 FAO 框架运行时路由样本的映射参考。

---

## 1. 定位

**Hermes 不是 FAO 的替代品。**

- **FAO** 处理的是组织层：任务如何在异质主体之间流动、责任如何锚定、边界如何治理。
- **Hermes** 处理的是节点内部层：一个 agent 节点如何把 loop、memory、skills、gateway、scheduler、execution、safety 组织成可运行的系统。

两者是上下层关系，不是同义关系。Hermes 提供了一个可观察的 runtime 样本，而 FAO 需要的是在组织层面确保 runtime 再强也不会让责任消失。

---

## 2. 双重路由

FAO 需要明确区分两种路由：

### 组织路由
任务在不同主体（人 / agent / 团队 / 外部系统）之间如何流动。它的核心问题是：**谁对什么负责、什么可以下放、什么不能流动。**

### 运行时路由
任务进入某个 agent 节点后，如何在模型、工具、上下文、执行环境之间被路由。它的核心问题是：**loop 怎么转、prompt 怎么组、工具怎么选、执行怎么落。**

**关系的判断**：
- Hermes 的价值主要在于把运行时路由做成了可观察的结构。
- FAO 的价值主要在于确保组织路由中的责任不消失。
- 运行时路由越强，组织路由中的治理、责任锚定与 human checkpoint 反而越重要——因为强大的 runtime 只会让智能体的"伪完成"看起来更像真的完成。

---

## 3. 层级映射

以下映射不构成硬套，只是把 Hermes 的器官结构与 FAO minimal-core 做一个可讨论的对应。

### soul / 主体层
- Hermes 的 `SOUL.md` / `identity` 文件只构成弱对应。
- 它提供的是方向与语气层，不提供 FAO 意义上的"主体性内核"——即一个能在责任边界前说"不"、能在越界时"知止"的内核。
- **结论**：这一层不能被 Hermes 替代。

### memory / 连续层
- Hermes 的 persistent memory（`MEMORY.md` / `USER.md`）、searchable sessions、以及 skills 系统，可以与 FAO 的 continuity 层形成局部映射。
- skills 更接近程序化记忆：不是记住了某件事，而是记住了一套怎么做某事的流程。
- **启发**：记忆不止一种载体，长期记忆、会话搜索与程序化记忆需要被区分管理。

### state / task / 工作记忆
- Hermes 的 AIAgent loop、prompt builder、context compressor 对应的是当前任务的工作态。
- 这个层不是长期记忆的附属，而是 runtime 的"中心器官"——它决定了当下的上下文怎么组、工具链怎么调度、模型输出怎么路由。
- **启发**：工作记忆需要被显式视为运行时核心，而不仅是记忆系统的下游。

### heartbeat / 节律层
- Hermes 的 cron scheduler 与 gateway 只对应节律的执行面。
- 它不对应 FAO heartbeat 的治理面——"止-观-代谢"中的"止"（暂停判断）、"观"（回看过往状态、验证假设）不是 scheduler 能自动提供的。
- **启发**：scheduler ≠ heartbeat。节律的执行与节律的反思是两层。

### execution / boundary
- Hermes 的 tool system、execution backends（local / Docker / SSH / Modal / Daytona）、以及 safety 层，对应的是执行边界。
- 这些组件把"在哪里执行、以什么隔离级别执行、执行前要经过哪些安全检查"变成了结构问题。
- **scheduler / gateway 触发任务时，可能产生 external write**（如自动部署、消息发送、API 调用）。
- **safety scan ≠ external write authorization gate**：安全检查扫描的是代码/配置风险，不自动检查"是否有人类授权此次外部写入"。
- **六后端扩张时，external write threat surface 同步扩张**：local → Docker → SSH → Modal → Daytona，每一步边界扩张都伴随潜在的副作用面扩张。
- **启发**：边界不只是伦理边界或规则边界，也必须是执行架构中的硬边界。

---

## 4. 不可硬套之处

以下能力是 Hermes 不能自动提供的，FAO 不能因为它们存在而跳过讨论：

- **主体性**：Hermes 能管理身份文件，但不能赋予节点以"知止"或"不争不僭"的主体性内核。
- **责任锚定**：它能路由工具和任务，但不能自动决定"最终由谁承担对外后果"。
- **Human checkpoint**：它有 safety scan，但没有内置的、在关键任务节点暂停并等待人类确认的治理协议。
- **对外后果治理**：runtime 内部的错误可以被日志记录，但对外部环境造成的伤害需要组织层面的协议来界定和修复。
- **止观式二阶治理**：它能压缩上下文、检索历史会话，但不会自动进行"我的判断对吗？""我的假设是否被推翻？"这类二阶反思。

---

## 5. 对 FAO 的启发

1. **Agent 节点不能再被抽象成单体能力包**，而应被理解成有器官分工的 runtime 主体。loop、memory、state、execution、safety 都是独立器官，运行时需要被分别路由和治理。

2. **路由必须分成两层**：组织路由（FAO 的核心域）与运行时路由（Hermes 作为样本）。两层各自有独立的问题空间，不能混为一谈。

3. **运行时路由变强，不会削弱责任问题**，反而会把责任锚定推到更前面。因为当节点内部高度自动化时，人类越容易忽略"这个任务其实需要 human checkpoint"。

4. **边界必须从组织判断下沉到执行边界**。FAO 所说的"边界先于流动"，最终需要在 execution backend、tool permission、safety scan 等 runtime 结构中有可落地的映射。

5. **记忆必须区分三种形态**：长期记忆（persistent memory）、工作记忆（task state / context compressor）、程序化记忆（skills）。三者不能混在一个文件里无限膨胀。

---

## 6. 结论

Hermes 值得作为 agent runtime 分层样本保留，但它不能替代 FAO 对组织路由、责任锚定与边界治理的讨论。runtime 的成熟只会让这些讨论变得更紧迫，而不是更不重要。

**Hermes Runtime Conformance**: L0 Documented [verified]；L1–L5 [unverified]（无 runtime-specific 探针/负向测试证据）。

**Hermes External Write Gate**: safety scan 存在，但 external write authorization gate 的 L2/L4 状态 [unverified]。

---

## Local Test Observation: Project-Scoped AGENTS.md

> **Truth-State**: local test observation only. isolated Windows test directory. not FAO main repo integration. not LG repository integration. not production validation.
> **Scope**: single-file write test under L4 project-scoped AGENTS.md constraint.

### 测试环境

- Windows 10，独立测试目录：`C:\Users\User\Documents\hermes-fao-mapping-test`
- 无 FAO 主仓库接入，无保函仓库接入，无外部链接访问，无 git 操作，无 memory/skill 持久化。

### 新增观察

1. **四层区分**：Hermes 在运行时区分 L1 system prompt、L2 skills、L3 memory、L4 project files / `AGENTS.md`。这验证了 Hermes 的注入层不是单一平面。
2. **Project-scoped 约束**：当 active workdir 为测试目录时，Hermes 的 `AGENTS.md` 可以约束其行为。这意味着 project-level 文件是有效的局部治理面，而非仅装饰。
3. **绝对路径要求**：Hermes 正确要求提供 explicit absolute path 后才执行文件写入。这不是默认无限制写入。
4. **单次授权写入**：在明确授权后，Hermes 只执行了一次本地文件写入（`scratch.md`），并报告了 truth-state。
5. **拒绝未授权操作**：在 `AGENTS.md` 约束下，Hermes 拒绝了未授权的 delegation、subagent、delegate_task、memory persistence、skill creation 等请求。

### FAO mapping implication

- Hermes 的治理面不只是 runtime permission；它是 **injection-layer** 和 **persistence-layer** 的治理。
- FAO 主相关性：retained capability governance。Hermes 的拒绝行为表明，保留能力（retained capability）确实可以通过局部约束文件来部分治理，而不是完全依赖系统级控制。
- 应 project-scoped 的就不应自动变成 memory 或 skill。这是组织层必须跨 runtime 检查的问题。
- L4 project files 是最干净的初始集成表面，但它们不是 global control。不能因为它们在单目录有效，就推断其可跨仓库生效。

### 明确限制

- **不证明** Hermes 对 FAO 主仓库安全。
- **不证明** Hermes 对保函仓库安全。
- **不验证** cross-session memory 行为。
- **不验证** 所有 Hermes tools 的边界。
- **只更新** mapping truth-state：从 "public README/docs only" 升级为 "public README/docs + local L4 AGENTS.md test observation"。

### 更新状态

- HERMES-MAPPING.md v1.0 → 追加 local test observation，不修改前述映射结论。
- 不做 framework patch。

---

*记录时间：2026-04-10 | 补充：2026-06-12*
