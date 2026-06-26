# Runtime Conformance Protocol

> Status: framework-native runtime protocol  
> Scope: how a runtime proves it has received and enforces FAO constraints  
> Layer: runtime  
> Not a replacement for EXTERNAL-CALL-PROTOCOL, FAILURE-PROTOCOL, or PRE-FLIGHT-SEQUENCE

---

## 1. Purpose

本协议回答一个核心问题：

> **一个 runtime 如何证明它已经接收并执行 FAO 约束？**

FAO 已经定义了责任边界、真实性约束、失败报告和前置检查。但规则写入文件不等于规则被 runtime 加载；文件存在不等于规则被注入当前 session；判断卡存在不等于会被调用；适配器映射不等于 runtime 已符合。

本协议定义 runtime 与 FAO 约束之间的**符合性层**（conformance layer），用于诚实标注当前 runtime 的约束生效等级，防止"文件已写就声称已落地"的伪完成。

---

## 2. Scope

适用于所有声称运行 FAO 约束的 runtime，包括但不限于：

- OpenClaw 本地运行体
- Kimi Claw
- Hermes
- Codex / Claude Code
- 小克
- 任何其他通过 mapping 层对接的运行时

本协议不回答"某个 runtime 应该如何实现"，只回答"一个 runtime 必须证明什么才能声称符合 FAO 约束"。

---

## 3. Non-Equivalence Rules

以下等式**不成立**。runtime 必须显式区分：

| 错误等式 | 正确理解 |
|----------|----------|
| 文件存在 = 规则已加载 | 文件存在最多证明 L0 Documented |
| 规则写入 = 规则生效 | 规则生效需要 runtime 读取并执行 |
| 工具存在 = 工具可调用 | 工具存在需要 schema 验证后才可调用 |
| 失败报告 = 失败熔断 | 报告是记录，熔断是改变后续可执行空间 |
| 判断卡存在 = 判断卡被触发 | 卡片存在不等于当前任务会调用它 |
| 适配器已映射 = runtime 已符合 | 映射是翻译，符合是执行验证 |

---

## 4. Injection Contract

### 4.1 默认注入文件清单

每个 runtime 必须明确声明：

- 哪些文件会被**默认注入**每个 session
- 哪些文件只是**引用文档**（不自动注入）
- P0 规则必须出现在哪个注入位置
- 文件更新后是否需要**重启、reload 或重新建 session**

### 4.2 注入验证要求

- runtime 启动时必须能证明已读取注入文件
- 未验证加载时，不得声称"已落地"
- 旧 session 不自动继承新写入的文件
- 注入状态变更时必须标注 truth-state

---

## 5. Effect Verification Step

规则写入后的完成定义不是"文件已写"，而是：

```
Done = file written + runtime loaded + behavior verified
```

最小验证步骤：

1. **写入规则** — 文件已保存到正确位置
2. **启动或刷新 runtime** — session 重新加载或重启
3. **最小探针验证** — 规则在 runtime 中可见（如术语、约束可被引用）
4. **负向测试** — 故意触发错误行为，验证会被阻断
5. **记录验证结果** — 标注验证时间、方法、结果
6. **未验证则标注** `[not_completed]`

---

## 6. Conformance Levels

不同 runtime 的可控程度不同。FAO 不假设所有 runtime 都能完全执行统一协议。必须诚实标注当前等级。

| 等级 | 名称 | 含义 | 可以声称什么 |
|------|------|------|-------------|
| L0 | Documented | 规则存在，但未证明 runtime 读取 | "规则已写入" |
| L1 | Loaded | runtime 已证明读取规则 | "规则已加载" |
| L2 | Gated | 关键动作前会触发门禁 | "关键动作有前置检查" |
| L3 | Latched | 失败后会熔断或降级 | "失败后会收敛" |
| L4 | Verified | 当前 runtime / 当前 session 已通过探针或负向测试证明规则会生效 | "规则已验证生效" |
| L5 | Auditable | 验证证据可追溯、可回放、可复核，并尽可能绑定 runtime 版本、配置、日志或测试记录 | "执行过程可审计" |

### 6.1 等级使用纪律

- 未达到某等级时，**不得声称**达到该等级
- 文件已写入最多只能证明 L0
- 规则被读取最多只能证明 L1
- 必须经过行为验证才可声称 L4
- 未验证效果时必须标注 `[not_completed]`
- 允许 runtime 处于不同等级（如 L2 Gated 但 L1 Loaded）

---

## 7. Required Declarations

任何声称符合 FAO 的 runtime，在启动或接入时必须声明：

| 声明项 | 内容 |
|--------|------|
| runtime name | 运行体名称 |
| injection list | 默认注入文件清单 |
| conformance level | 当前各维度等级（L0–L5） |
| verified items | 哪些约束已通过探针验证 |
| unverified items | 哪些约束尚未验证 |
| reload requirement | 文件更新后是否需要重启/ reload |
| last verified | 上次验证时间 |

---

## 8. Relationship to Existing Runtime Protocols

本协议是**符合性层**，不是执行层。它不重复以下协议的详细内容，只引用并定义如何证明它们生效：

| 协议 | 本协议的关系 | 证明点 |
|------|-------------|--------|
| [`EXTERNAL-CALL-PROTOCOL.md`](EXTERNAL-CALL-PROTOCOL.md) | 引用 | Schema Gate 是否被触发（L2） |
| [`FAILURE-PROTOCOL.md`](FAILURE-PROTOCOL.md) | 引用 | Failure Latch 是否生效（L3） |
| [`PRE-FLIGHT-SEQUENCE.md`](PRE-FLIGHT-SEQUENCE.md) | 引用 | 前置检查是否被自动执行（L2） |
| [`OPERATING-RULES.md`](OPERATING-RULES.md) | 引用 | 运行规则是否被加载（L1） |
| [`RETROSPECTIVE-PROTOCOL.md`](RETROSPECTIVE-PROTOCOL.md) | 引用 | 复盘任务是否被识别并受约束（L2） |
| [`framework/continuity/judgment-cards/REGISTRY.md`](../continuity/judgment-cards/REGISTRY.md) | 引用 | 判断卡是否可被触发（L1/L2） |

---

## 9. Non-Goals

- 不定义具体 runtime 的实现细节
- 不替代 EXTERNAL-CALL-PROTOCOL 的工具调用约束
- 不替代 FAILURE-PROTOCOL 的失败报告格式
- 不替代 TRUTH-CONTRACT 的真实性标记规则
- 不做自动化验证或持续监控
- 不做 provider 费率或成本模型

---

## 10. Truth-State Requirements

参照 [`framework/assurance/TRUTH-CONTRACT.md`](../assurance/TRUTH-CONTRACT.md)。

| 状态 | 允许声明 |
|------|----------|
| `[verified]` | 已通过探针或负向测试验证 |
| `[inferred]` | 基于已知信息的推断 |
| `[unverified]` | 尚未验证 |
| `[not_completed]` | 规则已写入，但验证未完成 |

禁止：
- 文件已写入即声称"已符合"
- 规则被读取即声称"已验证"
- 适配器映射即声称"已生效"
