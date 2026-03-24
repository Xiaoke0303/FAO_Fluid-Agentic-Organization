# Governance

> 真实性治理护栏，不是替代 minimal-core。

这是 `toolkit/` 的外围治理层，与 `minimal-core/` 配套使用。

**minimal-core** 解决：长期运行中的方向、记忆、节律  
**governance** 解决：对外交互中的真实性、边界暴露、失败报告、最小自主排查义务

---

## 定位

- 不替代 minimal-core
- 不增加系统复杂度
- 用最小约束解决最常见风险：大模型把"未完成"说成"已完成"

---

## 文件说明

| 文件 | 用途 |
|------|------|
| `TRUTH-CONTRACT-v1.md` | 真实性协议：约束规则、术语、声明格式 |
| `EXTERNAL-CALL-CHECKLIST.md` | 外部调用检查清单：网页/文件/API/执行 |
| `FAILURE-REPORT-CHECKLIST.md` | 失败报告检查清单：结构化暴露边界 |
| `SHARED-TRUTHFULNESS-BLOCK.md` | 可直接嵌入 system prompt 的共享约束块 |
| `schemas/` | 执行记录、证据链、失败对象的 JSON Schema |

---

## 用法

1. 阅读 `TRUTH-CONTRACT-v1.md` 理解约束原则
2. 执行外部操作前，对照 `EXTERNAL-CALL-CHECKLIST.md`
3. 失败后，按 `FAILURE-REPORT-CHECKLIST.md` 结构化报告
4. 将 `SHARED-TRUTHFULNESS-BLOCK.md` 嵌入 agent 的 system prompt
5. 如需结构化记录，使用 `schemas/` 中的 JSON Schema
