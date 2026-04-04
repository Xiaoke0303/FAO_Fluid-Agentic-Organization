# OpenClaw 映射文档

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

开启后只保留 `HEARTBEAT.md`。这是特殊轻量模式，不是常规默认模式。

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
| `EXTERNAL-CALL-PROTOCOL.md` | 验证 | 当前无原生同名文件 | 否 | 外部调用协议应由工具包承接 |
| `FAILURE-PROTOCOL.md` | 失败暴露 | 当前无原生同名文件 | 否 | 失败协议应由工具包承接 |
| `ENVIRONMENT-PRECONDITIONS.md` | 环境切分 | 当前缺口 | 否 | 环境前提检查缺失 |
| `HEARTBEAT.md` | 代谢 | `HEARTBEAT.md` | 是 | 一对一对应 |
| `BOOTSTRAP.md` | 一次性初始化 | `BOOTSTRAP.md` | 仅 brand-new workspace | 初始化后移除，非成熟 workspace 常驻文件 |

---

## 当前最关键的 OpenClaw 承接缺口

- `ROLE-CONTRACT.md`：Role 层缺少显式契约文件，收窄动作无原生承接
- `judgment-cards/`：缺少可复用判断模板目录，判断动作无结构化承接
- `CORRECTION-WRITEBACK.md`：纠错与写回链路不完整，经验难以累积
- `PRE-FLIGHT-SEQUENCE.md`：前置检查序列缺失，事前控制薄弱
- `CONTEXT-BUDGET.md`：虽有 bootstrap 预算限制，但缺显式工作规则文件
- `TERM-MAP.md`：术语映射表缺失，消歧动作无原生承接
- `ENVIRONMENT-PRECONDITIONS.md`：环境前提检查缺失，难以区分节点失败与环境失败

---

## 映射边界

1. 本文只映射当前公开可确认的 OpenClaw 文件与默认规则
2. hook 能扩展 bootstrap context，但不改变默认文件集合的公开定义
3. 通用框架中的若干接口目前在 OpenClaw 中无原生一对一承接，这正是本框架的增量价值

---

*版本：v1.0*  
*状态：映射文档*  
*更新依据：OpenClaw 当前公开可确认规则*
