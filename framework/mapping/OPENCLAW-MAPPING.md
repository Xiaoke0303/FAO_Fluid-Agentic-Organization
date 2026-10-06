# OpenClaw 映射文档

> **Truth-State**: mapping document only. no framework patch. no external re-check.  
> **Scope**: 单体映射 → 参见横向比较：`CROSS-RUNTIME-ADAPTER-MAP.md` / `RUNTIME-BACK-PRESSURE-REVIEW.md`

> 通用工作节点框架 → OpenClaw 当前公开结构的映射参考。

---

## 文档定位

本文用于把通用工作节点框架映射到 OpenClaw 当前公开可确认的文件与注入规则上。

本文是"映射文档"，不是再次定义通用框架。映射允许出现一对多、多对一、以及"当前缺口"。

默认 bootstrap 规则与 hook 扩展能力分开写，不混淆。

---

## OpenClaw 当前可确认规则

### 1. 当前公开确认的 workspace bootstrap 注入文件

| 文件 | 说明 |
|------|------|
| `AGENTS.md` | 代理配置 |
| `SOUL.md` | 方向层定义 |
| `TOOLS.md` | 环境专用备忘 |
| `IDENTITY.md` | 节点本体身份 |
| `USER.md` | 协作者信息 |
| `HEARTBEAT.md` | 节律任务清单 |
| `BOOTSTRAP.md` | 首次引导（仅 brand-new workspace） |
| `MEMORY.md` / `memory.md` | 记忆主索引（大写优先，回退小写） |

### 2. 默认注入语义

以上 bootstrap 文件默认每轮注入。这是默认规则，不等于任意文件都会自动注入。

### 3. `BOOTSTRAP.md` 的一次性语义

- 首次引导时存在
- 完成 bootstrap 后会被移除
- 成熟 workspace 缺失是正常稳态

### 4. `MEMORY.md` / `memory.md` 的回退关系

- 大写优先
- 大写不存在时回退到小写
- 只能确认此回退关系，不做延伸猜测

### 5. bootstrap 预算限制

当前公开确认的默认预算：
- 单文件：`bootstrapMaxChars=20000`
- 总量：`bootstrapTotalMaxChars=150000`

### 6. `lightContext`

轻量 bootstrap 模式，非默认模式。按对象分列（本节点 v2026.4.14 的适用性未复核，三种对象不得互相推广）：

- **heartbeat 运行**：2026-10-06 查阅的官方活文档（https://docs.openclaw.ai/gateway/heartbeat）载：轻量模式跳过工作区 bootstrap 文件，heartbeat runner 仍注入 monitor scratch。
- **cron 轻量运行**：既有镜像转引的发布记录及计划材料描述了跳过 bootstrap 文件注入的轻量运行方案（https://docs.openclaw.ai/experiments/plans/cron-add-hardening 为计划路径）；本轮未据对应版本实现或运行证据确认其落地行为 [待核]。
- **子代理 spawn**：已有资料将其描述为轻量 bootstrap 上下文；具体省略或保留清单 [待核]。context-engine 对预启动钩子的说明（https://docs.openclaw.ai/concepts/context-engine），不足以单独证明全部工作区文件、技能、工具定义或系统提示均被省略。

不实测、不估算降本幅度，不宣称预算可控性已解决。

### 7. `agent:bootstrap` hook 的地位

- 这是 internal hook 扩展点
- 可以在 bootstrap system prompt finalized 前 add/remove bootstrap context files
- 但它不等于"任意文件天然自动注入"

---

## 核心对照表

| 通用文件/接口 | 元动作 | OpenClaw 当前对应 | 是否默认注入 | 映射说明 / 缺口 |
|---------------|--------|-------------------|--------------|-----------------|
| `CONSTITUTION.md` | 定向 | `SOUL.md` | 是 | 方向层映射 |
| `IDENTITY.md` | 身份锚定 | `IDENTITY.md` | 是 | 一对一对应 |
| `USER.md` / `USER-RELATION.md` | 关系锚定 | `USER.md` | 是 | 一对一对应 |
| `ROLE-CONTRACT.md` | 收窄、升级、接受纠正 | 当前无原生一对一文件 | 否 | **当前缺口**：Role 层缺少显式契约文件 |
| `MEMORY-INDEX.md` | 择记 | `MEMORY.md` / `memory.md` | 是 | 大写优先，回退小写 |
| `judgment-cards/` | 判断 | 当前无原生一对一文件 | 否 | **当前缺口**：缺少可复用判断模板目录 |
| `CORRECTION-WRITEBACK.md` | 纠错、写回 | 当前无原生一对一文件 | 否 | **当前缺口**：纠错与写回链路不完整 |
| `TERM-MAP.md` | 消歧 | 当前无原生一对一文件 | 否 | **当前缺口**：术语映射表缺失 |
| `OPERATING-RULES.md` | 统筹、推进、部分控本 | `AGENTS.md` + 部分 `TOOLS.md` | 是 | 多对一映射 |
| `STATE.md` | 状态锚定 | 当前无默认 bootstrap 对位 | 否 | 通用框架显式文件，非 OpenClaw 默认 bootstrap 文件 |
| `PRE-FLIGHT-SEQUENCE.md` | 事前顺序 | 当前缺口 | 否 | 前置检查序列缺失 |
| `TOOLS-SKILLS.md` | 工具入口 | `TOOLS.md` | 是 | 一对一对应 |
| `CONTEXT-BUDGET.md` | 控本 | 当前无原生一对一文件 | 否 | OpenClaw 有 bootstrap 预算限制，但缺显式工作规则文件 |
| `TRUTH-CONTRACT.md` | 求真 | 当前无原生同名 bootstrap 文件 | 否 | 应由通用框架/工具包承接，不伪装成 OpenClaw 原生文件 |
| `EXTERNAL-CALL-PROTOCOL.md` | 验证 | `exec` 工具（可执行 git push 等） | 否 | 外部调用协议由工具包承接；exec 工具可承载外部写入，需触发 External Write Gate。执行策略分版本：2026-10-03 查阅的官方活文档（https://docs.openclaw.ai/tools/exec）载 `tools.exec.mode` 五级策略（deny/allowlist/ask/auto/full，含 allowlist、人类审批、模型自动审查），本轮所查资料未确认 Git push 专用授权机制 [官方活文档，2026-10-03]；本节点（v2026.4.14）`tools.exec` 无显式配置，该安装版本的默认行为 [待核]。fao-gate 为针对 Git push 的本地补充护栏；通用执行审批能否覆盖同场景，取决于版本、配置与入口。 |
| `FAILURE-PROTOCOL.md` | 失败暴露 | 当前无原生同名文件 | 否 | 失败协议应由工具包承接 |
| `ENVIRONMENT-PRECONDITIONS.md` | 环境切分 | 当前缺口 | 否 | 环境前提检查缺失 |
| `HEARTBEAT.md` | 代谢 | `HEARTBEAT.md` | 是 | 一对一对应 |
| `BOOTSTRAP.md` | 一次性初始化 | `BOOTSTRAP.md` | 仅 brand-new workspace | 初始化后移除，非成熟 workspace 常驻文件 |

---

## 当前最关键的 OpenClaw 承接缺口

> 口径说明：以下"缺口"均指 **OpenClaw 原生侧**的承接缺口——即 OpenClaw 默认环境中没有与该 FAO 接口一一对应的原生文件或机制；**不表示 FAO framework 缺少对应文件**（framework 侧各接口文件均已存在）。文档成文也不等于规则已在运行时加载或生效，各接口的加载与生效等级以 RUNTIME-CONFORMANCE-PROTOCOL.md 及相应 mapping 的符合性声明为准。

- `ROLE-CONTRACT.md`：Role 层缺少显式契约文件，收窄动作无原生承接
- `judgment-cards/`：缺少可复用判断模板目录，判断动作无结构化承接
- `CORRECTION-WRITEBACK.md`：纠错与写回链路不完整，经验难以累积
- `PRE-FLIGHT-SEQUENCE.md`：前置检查序列缺失，事前控制薄弱
- `CONTEXT-BUDGET.md`：虽有 bootstrap 预算限制，但缺显式工作规则文件
- `TERM-MAP.md`：术语映射表缺失，消歧动作无原生承接
- `ENVIRONMENT-PRECONDITIONS.md`：环境前提检查缺失，难以区分节点失败与环境失败
- `EXTERNAL-CALL-PROTOCOL.md`：exec 工具可执行 git push 等外部写入，但 OpenClaw 是否原生触发 External Write Gate → [unverified]
- **framework rule loaded ≠ exec behavior gated**：规则文件被注入不等于 exec 调用前自动执行门禁；需要 runtime-specific probe 才能标 L2/L4

---

## 映射边界

1. 本文只映射当前公开可确认的 OpenClaw 文件与默认规则
2. hook 能扩展 bootstrap context，但不改变默认文件集合的公开定义
3. 通用框架中的若干接口目前在 OpenClaw 中无原生一对一承接，这正是本框架的增量价值
4. **OpenClaw Runtime Conformance**: L0 Documented [verified]；L1–L5 [unverified]（无 runtime-specific 探针/负向测试证据）
5. **OpenClaw External Write Gate**: 2026-10-03 查阅的官方活文档（https://docs.openclaw.ai/tools/exec）显示 OpenClaw 存在通用执行策略机制（`tools.exec.mode` 五级），但本轮所查资料未确认 Git push 专用授权机制。本节点（v2026.4.14）未显式配置执行策略，该版本默认行为 [待核]。仓库 scripts/external-write-gate.sh 为针对 Git push 的本地补充护栏（协作护栏，非独立强制边界）；通用执行审批能否覆盖同场景，取决于版本、配置与入口。
6. **Sub-agent 上下文**：2026-10-06 查阅的官方活文档（https://docs.openclaw.ai/concepts/session-tool）描述：非线程 spawn 默认使用隔离上下文；可通过 `context: "fork"` 显式请求继承，文档列明的条件包括 `runtime: "subagent"` 且与请求者为同一 agent。线程绑定场景另受其默认上下文策略影响（`threadBindings.defaultSpawnContext`，默认 `fork`）。此为官方设计说明，不证明本节点旧版本或既往调用的实际行为。"隔离上下文"指会话上下文隔离，不指文件系统隔离、权限隔离或跨组读取已被阻止；具体一次调用是否继承父历史，取决于实际调用参数与记录。

---

*版本：v1.0*  
*状态：映射文档*  
*更新依据：OpenClaw 当前公开可确认规则*
