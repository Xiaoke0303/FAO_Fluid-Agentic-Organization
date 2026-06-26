# Judgment Cards Registry

> Status: registry / trigger index  
> Scope: which judgment card to trigger under which condition  
> Layer: continuity / judgment  
> Not a replacement for README.md; not a card file itself

---

## 1. Purpose

判断卡存在不等于会被使用。

本文件是**触发索引**（trigger index），用于：

- 给定一个 runtime 条件，明确应触发哪张判断卡
- 标注卡片的必需性、关联协议、失败模式和输出要求
- 区分已实例化卡片与占位符卡片

本文件不定义 judgment card 的字段结构（见 [README.md](README.md)），只回答：**什么情况下触发哪张卡**。

---

## 2. Registry Table

| Card Name | Trigger Condition | Required | Linked Protocol | Failure Mode | Output Requirement | Status |
|-----------|-------------------|----------|-----------------|--------------|-------------------|--------|
| tool-call-failure | tool call failed | 否 | [FAILURE-PROTOCOL.md](../../runtime/FAILURE-PROTOCOL.md) | 未报告失败 | 失败报告对象（12 字段） | placeholder; card file not yet instantiated |
| silent-check | silent / no response | 否 | [TRUTH-CONTRACT.md](../../assurance/TRUTH-CONTRACT.md) | 未标记原因 | 状态声明 + 原因 | placeholder; card file not yet instantiated |
| retrospective-scope-check | retrospective task detected | 是 | [RETROSPECTIVE-PROTOCOL.md](../../runtime/RETROSPECTIVE-PROTOCOL.md) | 范围未限定即展开 | 范围确认声明 | placeholder; card file not yet instantiated |
| context-expansion-check | wants broader history access | 是 | [OPERATING-RULES.md](../../runtime/OPERATING-RULES.md) | 未经批准扩大上下文 | 收敛声明 + 授权请求 | placeholder; card file not yet instantiated |
| runtime-injection-check | file exists but rule not applied | 是 | [RUNTIME-CONFORMANCE-PROTOCOL.md](../../runtime/RUNTIME-CONFORMANCE-PROTOCOL.md) | 未验证加载 | 加载声明 + truth-state | placeholder; card file not yet instantiated |
| effect-verification-check | agent claims a rule / protocol / runtime constraint / file change is implemented / loaded / completed | 是 | [RUNTIME-CONFORMANCE-PROTOCOL.md](../../runtime/RUNTIME-CONFORMANCE-PROTOCOL.md) | file-written state mistaken for runtime-effective state | 标注验证等级 L0–L5 或 `[not_completed]` | placeholder; card file not yet instantiated |
| tool-schema-gate-check | schema unclear before tool call | 是 | [EXTERNAL-CALL-PROTOCOL.md](../../runtime/EXTERNAL-CALL-PROTOCOL.md) | 盲试调用 | schema 验证声明 | placeholder; card file not yet instantiated |
| failure-latch-check | repeated failure detected | 是 | [FAILURE-PROTOCOL.md](../../runtime/FAILURE-PROTOCOL.md) | 失败后未收敛继续盲冲 | 熔断声明 + 下一步 | placeholder; card file not yet instantiated |

---

## 3. Status Definitions

| Status | Meaning |
|--------|---------|
| `instantiated` | 卡片文件已存在，可直接调用 |
| `placeholder` | 已注册触发条件，但卡片文件尚未创建 |

---

## 4. When to Instantiate a New Card

满足以下任一条件时，可将 placeholder 升级为 instantiated：

- 同类判断已出现 3 次以上
- 已有稳定判断原则和可复用表达
- 翻车模式已清晰

不满足条件时，保留为 placeholder，不强行创建文件。

---

## 5. Relationship to Other Files

| 文件 | 关系 |
|------|------|
| [README.md](README.md) | README 定义 judgment card 的字段结构和边界；本文件定义触发索引 |
| [RUNTIME-CONFORMANCE-PROTOCOL.md](../../runtime/RUNTIME-CONFORMANCE-PROTOCOL.md) | 符合性协议要求 runtime 证明 judgment card 可被触发（L1/L2） |
| [OPERATING-RULES.md](../../runtime/OPERATING-RULES.md) | 运行母规则决定何时调用 judgment card；本文件提供调用映射 |

---

*版本：v1.0*  
*所属模块：Continuity / Judgment / Registry*  
*承接元动作：判断*
