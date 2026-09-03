# OpenClaw 映射文档

> **Truth-State**: mapping document only. selected OpenClaw claims externally re-checked against official `v2026.8.1-beta.2` source and documentation as of 2026-08-21. no live-instance re-check. no framework patch implied.
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
- 总量：`bootstrapTotalMaxChars=60000`

以上是该 tag 的 upstream 默认值，不代表具体实例；全局或 per-agent override 需读取实例配置后另行确认。

### 6. `lightContext`

开启后只保留 `HEARTBEAT.md`。这是特殊轻量模式，不是常规默认模式。

### 7. `agent:bootstrap` hook 的地位

- 这是 internal hook 扩展点
- 可以在 bootstrap system prompt finalized 前 add/remove bootstrap context files
- 但它不等于"任意文件天然自动注入"

### 8. 工具循环与上下文压力控制面（`v2026.8.1-beta.2`）

| 控制面 | beta.2 可确认行为 | FAO 映射边界 |
|--------|-------------------|--------------|
| `tools.loopDetection.enabled` | rolling-history detector 默认关闭；全局或 per-agent 只公开 `enabled` 一个可配置字段 | 是原生运行时门禁，但内置 `10 / 20 / 30` 阈值固定，不等价于 FAO 的“两次无进展后禁止第 3 次” |
| post-compaction guard | 未显式设为 `false` 时可用；只在 compaction-retry 后的短窗口 armed | 是恢复后的二次保护；压缩被取消或尚未进入 retry 时，不能阻止前置工具循环 |
| `agents.defaults.compaction.midTurnPrecheck.enabled` | 默认关闭；tool result 写入后、下一次模型调用前检查 prompt pressure | 是上下文压力门禁，不是语义失败熔断，也不是单轮工具调用总量上限 |
| `before_tool_call` / `after_tool_call` | 前者可 terminal block，后者可观察 result / error；二者均可按 `runId` 关联 | 是精确承接 FAO Failure Latch 与 per-run budget 的原生扩展面 |

### 9. beta.2 压缩边界

`v2026.8.1-beta.2` 的 safeguard compaction 在最终质量审计仍失败时返回 `{ cancel: true }` 并保留历史。`missing_identifiers` 与 `latest_user_ask_not_reflected` 均属于可触发该路径的质量原因。

因此：

- compaction 是恢复机制，不得承担工具循环的第一道熔断责任；
- memory flush、transcript byte limit 与 mid-turn precheck 只能控制上下文压力，不能证明 Failure Latch 已生效；
- post-compaction guard 不能覆盖“压缩被取消、历史原样保留”的路径。

---

## FAO 最小全局承接剖面

只保留一个不变量：**继续必须带来可验证进展；同一等价动作连续 2 次无进展后，第 3 次必须在运行时被阻断。**

### 1. 方向层：只写“有界坚持”

`SOUL.md` 只保留“有界坚持 / 知止”的方向；`AGENTS.md` 只引用 canonical Failure Latch，不复制计数器。继续以新证据、新方法或新授权为条件；Failure Latch 触发后，“换一种方式继续”不得覆盖熔断。提示词文件只能证明 L0/L1，不能声称 L3。

### 2. 原生安全层：只开两个开关

以下片段应合并到既有配置对象，不应替换其他 compaction 配置：

```json5
{
  tools: {
    loopDetection: { enabled: true },
  },
  agents: {
    defaults: {
      compaction: {
        midTurnPrecheck: { enabled: true },
      },
    },
  },
}
```

这两个开关提供产品原生的宽口径保护，但仍不能证明精确 FAO 熔断已实现。

### 3. 精确熔断层：只保留一个 runtime adapter

若要达到 FAO L3，单一 adapter / plugin 必须同时承接：

| 运行时对象 | 最小语义 |
|------------|----------|
| `action_fingerprint` | 规范化 `tool kind + target + effect-relevant params`；排除 timestamp、PID、run-local ID 等易变元数据 |
| `progress_receipt` | 目标状态、证据或结果发生可验证变化；仅改写措辞、包装器或命令形式不算进展 |
| repeated no-progress latch | 同一 fingerprint 连续 2 次无进展后，`before_tool_call` 在第 3 次返回 terminal block；换工具但目标与效果等价时不得清零 |
| per-run tool budget | 在 runtime 中实例化 [`CONTEXT-BUDGET.md`](../runtime/CONTEXT-BUDGET.md) 的有限硬上限；系统级、角色级、任务级冲突时取最小值 |
| audit receipt | 至少记录 `runId`、fingerprint、计数、阻断原因与预算余量；否则不得声称 L5 |

阈值只在 runtime / role 配置中实例化；不得复制到 `SOUL.md`、`AGENTS.md` 与多个 framework 文件。这样可以避免提示词规则、产品默认值和插件计数器互相漂移。

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
| `CONTEXT-BUDGET.md` | 控本 | bootstrap budget + mid-turn precheck + runtime adapter | 否 | 原生控制上下文压力；普通 agent 的精确 per-run 工具调用硬上限仍需 adapter 实例化 |
| `TRUTH-CONTRACT.md` | 求真 | 当前无原生同名 bootstrap 文件 | 否 | 应由通用框架/工具包承接，不伪装成 OpenClaw 原生文件 |
| `EXTERNAL-CALL-PROTOCOL.md` | 验证 | `exec` 工具（可执行 git push 等） | 否 | 外部调用协议由工具包承接；exec 工具可承载外部写入，需触发 External Write Gate；OpenClaw 原生是否具备 push gate → [unverified] |
| `FAILURE-PROTOCOL.md` | 失败暴露 | loop detection + `before_tool_call` / `after_tool_call` adapter | 否 | 内置 detector 提供宽口径保护；FAO 两次无进展熔断需 runtime adapter 承接 |
| `ENVIRONMENT-PRECONDITIONS.md` | 环境切分 | 当前缺口 | 否 | 环境前提检查缺失 |
| `HEARTBEAT.md` | 代谢 | `HEARTBEAT.md` | 是 | 一对一对应 |
| `BOOTSTRAP.md` | 一次性初始化 | `BOOTSTRAP.md` | 仅 brand-new workspace | 初始化后移除，非成熟 workspace 常驻文件 |

---

## 当前最关键的 OpenClaw 承接缺口

- `ROLE-CONTRACT.md`：Role 层缺少显式契约文件，收窄动作无原生承接
- `judgment-cards/`：缺少可复用判断模板目录，判断动作无结构化承接
- `CORRECTION-WRITEBACK.md`：纠错与写回链路不完整，经验难以累积
- `PRE-FLIGHT-SEQUENCE.md`：前置检查序列缺失，事前控制薄弱
- `CONTEXT-BUDGET.md`：原生有 bootstrap budget 与 mid-turn precheck，但精确 per-run 工具调用硬上限仍需 adapter
- `TERM-MAP.md`：术语映射表缺失，消歧动作无原生承接
- `ENVIRONMENT-PRECONDITIONS.md`：环境前提检查缺失，难以区分节点失败与环境失败
- `EXTERNAL-CALL-PROTOCOL.md`：exec 工具可执行 git push 等外部写入，但 OpenClaw 是否原生触发 External Write Gate → [unverified]
- **framework rule loaded ≠ exec behavior gated**：规则文件被注入不等于 exec 调用前自动执行门禁；启用内置 detector 也不等于 FAO 的精确两次熔断；需要 runtime-specific 负向探针才能标 L3/L4

---

## 映射边界

1. 本文只映射当前公开可确认的 OpenClaw 文件、默认规则与扩展面
2. hook 能扩展 bootstrap context，但不改变默认文件集合的公开定义
3. 通用框架中的若干接口目前在 OpenClaw 中无原生一对一承接，这正是本框架的增量价值
4. **OpenClaw Runtime Conformance**: 产品控制面 [verified]；本 mapping 的 L0 Documented [verified]；具体实例的 L1–L5 [unverified]（未读取实例配置，且无 runtime-specific 负向测试证据）
5. **OpenClaw External Write Gate**: exec 工具可执行 git push，但 OpenClaw 是否原生具备 push gate / human checkpoint → [unverified]

---

*版本：v1.1*
*状态：映射文档*  
*更新依据：OpenClaw `v2026.8.1-beta.2` 官方源码与文档，复核于 2026-08-21*

*官方复核入口：[bootstrap budget](https://github.com/openclaw/openclaw/blob/v2026.8.1-beta.2/docs/concepts/context.md#injected-workspace-files-project-context)、[tool-loop detection](https://github.com/openclaw/openclaw/blob/v2026.8.1-beta.2/docs/tools/loop-detection.md)、[compaction safeguard](https://github.com/openclaw/openclaw/blob/v2026.8.1-beta.2/src/agents/agent-hooks/compaction-safeguard.ts)、[tool-call hooks](https://github.com/openclaw/openclaw/blob/v2026.8.1-beta.2/docs/plugins/hooks.md#tool-call-policy)。*
