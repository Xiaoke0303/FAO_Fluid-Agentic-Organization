# External Call Protocol

> Status: framework-native runtime protocol  
> Source: migrated from `toolkit/governance/EXTERNAL-CALL-CHECKLIST.md`  
> Scope: web, file, API, exec, and other external operations  
> Migration status: migrated; toolkit copy retained as legacy source

---

## Purpose

本协议约束 FAO runtime 中所有外部调用行为，防止：

- 未调用却声称已调用
- 未验证却声称已验证
- 工具失败后伪完成
- 外部证据链缺失
- 结果来源不清

---

## When This Protocol Applies

至少包括：

- web search / web fetch
- file search / file read / file write
- API call
- shell / exec
- GitHub / repo operation
- calendar / email / connector operation
- 任何与外部系统的交互

---

## Pre-Call Checklist

外部调用前必须完成以下检查：

1. **已声明能力边界** — 明确说明本次操作的范围和限制
2. **已确认工具/权限** — 确认自己真的有该工具，权限足够
3. **已记录目标对象** — URL / 文件路径 / API 端点 / 环境变量名
4. **已记录实际动作** — 具体调用了什么，输入是什么
5. **已记录时间戳** — 何时执行
6. **已评估副作用** — 是否会产生写入、删除、提交、推送等不可逆操作
7. **已确认需要外部调用** — 不是为"完整感"而调用；内部信息已不足时才调用外部
8. **已声明不确定性** — 调用前已知存在缺口时，先声明，不隐藏

---

### Tool Call Relevance Check / 单次工具调用回查

任何工具调用前，必须回查：

1. **Target existence / 目标存在性** — 对 read / edit / move / delete 等文件操作，必须确认目标路径真实存在、来源可靠、权限足够。若不确定，先 list / verify，不得猜路径继续 edit。
2. **Task relevance / 任务相关性** — 本次调用必须直接服务当前任务目标。不得因"能调用""顺手推进"或"为完整感"而调用无关工具。
3. **Write-action confirmation / 写入动作确认** — 对 write / delete / commit / push / send 等有副作用动作，必须确认：在用户授权范围内；已声明副作用；如可能，已说明可回滚性或不可回滚性。

> Before each tool call, the agent must be able to state why this tool, this target, and this action are necessary for the current task.

---

## Tool Schema Gate / 工具模式门禁

工具存在不等于可调用。调用前必须通过 schema 验证门禁。

### 调用前必须验证

1. **Exact function name** — 工具名称与当前 schema 中定义的名称完全一致；不得基于记忆或旧经验推断名称。
2. **Required fields** — 所有必填参数已确认存在且已赋值；不得遗漏 required 字段。
3. **Parameter nesting** — 参数结构（嵌套层级、对象/数组类型）与 schema 一致；不得假设参数扁平化或可自动转换。
4. **Action or subcommand support** — 对于支持多 action 的工具（如 `feishu_im_user_message` 的 `action: "send"`），确认当前 action 被 schema 支持。
5. **Schema recency** — 当前激活的 schema 是否与历史记忆或过往示例一致；如不一致，以当前激活 schema 为准，不得盲试。

### 门禁规则

- 若 schema 无法验证，**调用必须停止**，不得盲试。
- 若 required field 缺失，**调用必须停止**，不得用默认值或空值填充后盲试。
- 若参数嵌套结构不明，**调用必须停止**，不得假设结构后盲试。
- 若 action 不被当前 schema 支持，**调用必须停止**。

> Schema 不明时停止，不是建议，是门禁。

---

## Post-Call Declaration

外部调用后必须声明：

| 项 | 内容 |
|----|------|
| tool used | 使用了什么工具 |
| target | 访问了什么 URL / 资源 / API |
| result | 实际得到了什么结果 |
| evidence obtained | 保留了什么证据 |
| failure point | 哪一步失败（若无失败则标注"无"） |
| remaining uncertainty | 当前还缺什么能力或条件 |
| task status | completed / partially completed / blocked / unverified |

---

## Truth-State Requirements

参照 [`framework/assurance/TRUTH-CONTRACT.md`](../../assurance/TRUTH-CONTRACT.md)。

**不得把以下状态互混：**

| 真实状态 | 禁止使用的措辞 |
|----------|---------------|
| attempted | "completed" / "done" |
| inferred | "verified" / "confirmed" |
| inaccessible | "checked" / "reviewed" |
| draft | "final" / "done" |
| local success | "remote success" |

**只有满足以下条件，才允许使用"已查询 / 已确认 / 已验证"：**

- 实际执行了工具调用
- 实际获取到了结果
- 可以提供完整的证据链（工具、目标、输入、输出、时间）
- 结果经过检查，不是错误页面 / 超时 / 空响应

**若不满足以上条件，必须使用：**
- "尝试访问，但..."（说明失败点）
- "无法确认，因为..."（说明缺失的能力或条件）
- "基于...推断"（明确标注这是推断，不是验证）

---

## Side-Effect Boundary

如果外部调用涉及以下操作，必须显式声明：

- file write / file delete
- repo modification / git commit / git push
- API write / POST / PUT / DELETE
- deleting / archiving / modifying external state
- 发送消息 / 创建日程 / 修改配置

声明内容：
- 该操作是否已执行
- 是否已验证执行结果
- 是否可回滚
- 是否已请求人类确认

---

## External Write Gate / 外部写入门禁

外部写入不是内部状态的延伸。以下等式不成立：

- commit 授权 ≠ push 授权
- 本地文件修改 ≠ 远端更新授权
- 条件性 push 授权 ≠ 无条件 push 执行

### 门禁规则

执行任何外部写入前必须声明：

| 声明项 | 内容 |
|--------|------|
| action | 具体要执行什么（push / deploy / POST / send） |
| target | 目标 remote / URL / 接收方 |
| expected side effect | 远端状态将被如何改变 |
| human authorization source | 哪一条用户指令明确授权了此次外部写入 |
| blocking condition | 哪些条件必须满足才能执行；任一条件不满足则 [blocked] |

### 必须 [blocked] 的情况

- commit 授权已给出，但 push 授权未单独给出
- 条件性授权的条件未满足或无法验证
- 本地修改已完成，但远端发布未获明确授权
- 同一类外部写入已连续失败 2 次
- schema 未验证时尝试外部写入

> 外部写入前必须声明授权来源和阻断条件。条件不满足时，执行 [blocked]，不得继续。

---

## Failure Handling

如果外部调用失败、超时、权限不足、结果为空、证据不足，应转入：

[`framework/runtime/FAILURE-PROTOCOL.md`](FAILURE-PROTOCOL.md)

---

## Relationship with Other Framework Files

| 文件 | 关系 |
|------|------|
| [`OPERATING-RULES.md`](OPERATING-RULES.md) | 运行母规则提供全局推进、展开、收敛与暂停规则；本协议聚焦外部调用具体约束 |
| [`PRE-FLIGHT-SEQUENCE.md`](PRE-FLIGHT-SEQUENCE.md) | 前置检查序列决定"是否应进入任务"；本协议约束"进入后如何执行外部调用" |
| [`CONTEXT-BUDGET.md`](CONTEXT-BUDGET.md) | 成本约束决定验证深度与广度；本协议决定验证标准与证据格式 |
| [`TRUTH-CONTRACT.md`](../../assurance/TRUTH-CONTRACT.md) | 真实性合同提供标记规则与证据标准；本协议负责执行外部调用时的具体检查与声明 |
| [`FAILURE-PROTOCOL.md`](FAILURE-PROTOCOL.md) | 本协议在调用失败时转入失败协议 |

---

## Migration Boundary

本文件迁移并替代 `toolkit/governance/EXTERNAL-CALL-CHECKLIST.md` 的当前运行时用途。

toolkit 原文件保留为 legacy source，不再作为当前 runtime 入口。

> Add tool-call lifecycle guard for relevance check, target existence check, repeated failure pause, and tool-mode drift.
