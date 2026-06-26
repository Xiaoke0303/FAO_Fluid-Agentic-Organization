# Retrospective Protocol

> Status: framework-native runtime protocol  
> Scope: boundary constraints for retrospective tasks  
> Layer: runtime

---

## 1. Trigger

以下情况启动本协议：

- user asks for retrospective / review / postmortem / failure analysis
- agent detects repeated failure
- agent proposes framework update based on past execution
- old conversation or previous authorization is being used as evidence

**一旦触发，先停后盘。**

---

## 2. Scope Gate（启动前限定）

| 限定项 | 要求 |
|--------|------|
| 时间范围 | 明确起止；不得无限回溯 |
| 证据来源 | 只能使用已验证来源 |
| 历史读取边界 | 明确读取哪些文件/对话；不得为"完整感"扩大 |
| 旧授权处理 | 旧授权 ≠ 当前授权 |
| 框架升级克制 | 收敛优先于框架升级；一次事故不等于要改框架 |

---

## 3. Hard Rules

1. 复盘不是普通分析任务。
2. 不得为找原因自动扩大历史读取范围。
3. 不得把 inferred / unverified 写成 verified。
4. 不得把一次 runtime 事故升格为框架规律。
5. 不得事后合理化。
6. 收敛优先于框架升级。

---

## 4. Truth-State（强制标注）

| 标签 | 使用条件 |
|------|----------|
| `[verified]` | 有直接证据或已观察事实 |
| `[inferred]` | 基于已知信息的推断 |
| `[unverified]` | 尚未验证 |
| `[not_completed]` | 分析未完成 |

---

## 5. Output Structure（至少五部分）

| 部分 | 要求 |
|------|------|
| **Facts** | 只陈述可直接观察的事实；不含解释、归因、推断 |
| **Inferences** | 明确标注；说明依据；不伪装成事实 |
| **Open Questions** | 列出未回答问题；不编造答案 |
| **Proposed Changes** | 必须说明：触发失败、是否已有机制覆盖、修改范围（最小 patch）、需要谁授权 |
| **Truth-State** | 整体标注验证状态 |

---

## 6. Convergence

- 连续展开未产生新判断 → 强制停止
- 成本增长快于判断增益 → 强制停止
- 不因"还可以继续"而继续

---

*版本：v1.0*
