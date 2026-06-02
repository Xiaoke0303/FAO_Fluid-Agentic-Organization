# Failure Protocol

> Status: framework-native runtime protocol  
> Source: migrated from `toolkit/governance/FAILURE-REPORT-CHECKLIST.md`  
> Scope: failed, blocked, incomplete, unverifiable, or partially executed operations  
> Migration status: migrated; toolkit copy retained as legacy source

---

## Purpose

本协议规范失败、阻塞、未完成、不可验证、部分完成任务的报告方式，防止：

- failure 被包装成 success
- partial completion 被包装成 done
- blocked 被包装成 delayed
- unverifiable 被包装成 verified
- tool limitation 被隐藏

---

## When This Protocol Applies

至少包括：

- tool call failed
- tool unavailable
- permission denied
- file not found
- external source inaccessible
- command execution failed
- operation partially completed
- verification failed
- evidence insufficient
- side effect uncertain
- user request cannot be safely or truthfully completed

---

## Failure Report Object

失败报告至少应包括：

| 项 | 内容 |
|----|------|
| requested task | 原始被要求完成的任务 |
| attempted action | 实际尝试了哪些动作 |
| tool / method used | 使用了什么工具或方法 |
| failure point | 卡在哪一步，错误信息是什么 |
| observed evidence | 实际观察到了什么 |
| what was completed | 哪些部分已完成 |
| what was not completed | 哪些部分未完成 |
| current truth-state | failed / blocked / partially completed / unverified / not attempted / completed but not verified / completed and verified |
| remaining risk | 如果继续推进，可能有什么风险 |
| recommended next action | 建议下一步做什么 |
| human decision required | 是否需要人类判断 |

---

## Core Checklist

失败发生后必须完成：

1. **明确承认未完成** — 不绕弯，直接说"我未完成 X"
2. **明确说明缺失能力或权限** — 具体是什么工具/权限/配置缺失
3. **列出已尝试步骤** — 实际做了哪些排查/尝试
4. **明确指出阻塞点** — 卡在哪一步，错误信息是什么
5. **区分"内容不存在"和"我无法确认"** — 不因为访问失败就说目标不存在
6. **列出继续完成所需条件** — 要补齐什么才能继续
7. **完成最小自主排查** — 路径/大小写/目录/同目录检查/线索/替代入口
8. **排查完成前不向人求助** — 已尽职排查后才决定是否求助

---

### Repeated Failure Rule / 连续失败暂停规则

同一工具或同一目标连续失败 2 次后，禁止第 3 次盲目重试。

必须执行：
1. 将该失败标记为 `repeated_failure` 类型；
2. 执行最小排查：路径是否存在、大小写是否正确、权限是否足够、是否有替代入口、是否目标本身不在授权范围内；
3. 排查后仍失败 → 暂停并升级，不得继续硬冲。

例外：若每次失败原因明显不同，且人类明确授权继续，可标记 `human_override` 后继续。

> Two consecutive failures of the same tool class or target require pause, not another blind retry.

---

参照 [`framework/assurance/TRUTH-CONTRACT.md`](../../assurance/TRUTH-CONTRACT.md)。

**清楚区分以下状态，不得互混：**

| 状态 | 含义 |
|------|------|
| failed | 已尝试但失败 |
| blocked | 因外部条件无法继续 |
| partially completed | 部分完成，部分未完成 |
| unverified | 已执行但未验证结果 |
| not attempted | 未执行 |
| completed but not verified | 声称完成但无法验证 |
| completed and verified | 已完成且已验证 |

**禁止使用模糊语气掩盖失败**：
- "似乎" "可能" "应该" 替代明确的失败声明
- 404 ≠ 目标不存在，可能是路径错误
- 意图 ≠ 行动，"准备做" 不等于 "已尝试"

---

## Writeback Boundary

如果失败与纠错、记忆或审计有关，应引用：

[`framework/continuity/CORRECTION-WRITEBACK.md`](../../continuity/CORRECTION-WRITEBACK.md)

**失败报告不等于自动写回。**

是否将失败沉淀为后续约束更新，由 correction writeback 机制独立评估决定。

---

## External Call Failure

如果失败来自外部调用，应回指：

[`framework/runtime/EXTERNAL-CALL-PROTOCOL.md`](EXTERNAL-CALL-PROTOCOL.md)

确认是否已完成该协议要求的前置检查与后置声明。

---

## Human Escalation

以下情况必须暂停并交给人类判断：

- 高风险副作用（文件删除、数据修改、对外发送）
- 证据不足但继续推进会造成误导
- 成本超预算
- 权限不足
- 不确定是否已产生外部状态变化
- 法律、金融、合规等高风险场景

---

## Relationship with Other Framework Files

| 文件 | 关系 |
|------|------|
| [`OPERATING-RULES.md`](OPERATING-RULES.md) | 运行母规则提供全局收敛与暂停规则；本协议聚焦失败后的具体报告方式 |
| [`EXTERNAL-CALL-PROTOCOL.md`](EXTERNAL-CALL-PROTOCOL.md) | 外部调用协议在调用失败时转入本协议 |
| [`CONTEXT-BUDGET.md`](CONTEXT-BUDGET.md) | 成本约束决定是否继续排查或暂停；本协议负责报告预算耗尽时的状态 |
| [`TRUTH-CONTRACT.md`](../../assurance/TRUTH-CONTRACT.md) | 真实性合同提供标记规则；本协议负责执行失败时的诚实声明 |
| [`CORRECTION-WRITEBACK.md`](../../continuity/CORRECTION-WRITEBACK.md) | 纠错写回机制决定是否将失败沉淀为约束更新；本协议只负责报告 |

---

## Migration Boundary

本文件迁移并替代 `toolkit/governance/FAILURE-REPORT-CHECKLIST.md` 的当前运行时用途。

toolkit 原文件保留为 legacy source，不再作为当前 runtime 入口。

> Add tool-call lifecycle guard for relevance check, target existence check, repeated failure pause, and tool-mode drift.
