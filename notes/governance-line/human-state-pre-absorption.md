# Human-State Governance Pre-Absorption Note

## Status

- This is a governance-line sidecar.
- This is not framework content.
- This is not whitepaper content.
- This note records conditions before future absorption.
- No framework or whitepaper modification is implied.

---

## 1. Core Distinction

### Human-state governance

治理对象：
human node 的注意力、认知负荷、疲劳、责任压力、多方牵引下的状态漂移。

主要风险：
人类判断在 dashboard、agent 输出、KPI、FOMO、客户、监管、权威压力等影响下失真。

不是：
心理诊断；不是否定人；不是取消人类责任锚点。

### Agent governance

治理对象：
agent 的越界、伪完成、工具误用、责任漂移、能力幻觉。

主要接口：
TRUTH-CONTRACT、EXTERNAL-CALL-PROTOCOL、FAILURE-PROTOCOL、CORRECTION-WRITEBACK。

### General organization governance

治理对象：
组织制度、流程、岗位、合规体系。

说明：
FAO 不替代一般组织管理理论；FAO 处理的是 routing、boundary、responsibility anchoring 与 heterogeneous subject coordination。

---

## 2. Working Thesis

> FAO cannot treat humans as perfectly stable supervisors of agents.
> Human nodes are also finite organizational subjects.
> Their attention, fatigue, incentives, responsibility pressure, and state drift affect the quality of judgment.
> Governance should not remove human responsibility, but make the conditions of responsibility-bearing judgment visible before it is relied upon.

中文：

> FAO 不能把人类预设为天然稳定、无限理性的智能体监督者。人类同样是有限的组织主体，其注意力、疲劳、激励、责任压力与状态漂移会影响判断质量。治理的目的不是取消人的责任，而是在依赖责任性判断之前，让判断条件变得可见。

---

## 3. Why Not Absorb Now

暂不进入 framework / whitepaper 的原因：

1. human-state governance 与 agent governance / general organization governance 的边界刚刚澄清，尚未经过多轮验证。
2. 当前 note 中仍有 open questions。
3. framework 目前处于冻结/收敛状态，不宜新增模块。
4. 直接进入 ROLE-CONTRACT 会冲击 static qualification 设计。
5. 直接新增 HUMAN-NODE-IDENTITY.md 会过早 formalize。
6. 保函 maker-checker 等 domain example 应隔离为 domain material，不应混成 general framework。

---

## 4. Future Framework Candidate

### First candidate: PRE-FLIGHT human-state check

理由：

- 最轻量；
- 与准入检查天然相关；
- 不需要新增文件；
- 不颠覆 ROLE-CONTRACT；
- 可表达"qualified in general"与"qualified right now"的区别。

候选检查问题包括：

- 当前人类节点是否处于可判断状态？
- 注意力是否被多方争夺？
- 是否存在疲劳、权威压力、FOMO 或责任恐惧？
- 是否需要暂停、升级、第二人复核或降级处理？
- 是否可以继续？

### Second candidate: Human Node Identity

Human Node Identity defines the assumptions about human nodes before role contracts are assigned.

中文：
人类节点身份假设，用于定义人类节点在被赋予角色契约之前的主体条件。

当前判断：

- conceptually important
- not ready as a new framework file
- should remain a future explanatory layer

### Not preferred now

- ROLE-CONTRACT direct modification: too disruptive
- TRUTH-CONTRACT extension: wrong layer, because truth contract governs expression honesty, while human-state governance concerns judgment quality conditions
- HUMAN-STATE-ASSURANCE.md: too early and may misplace the issue under assurance only

---

## 5. Impact on Existing Framework Interfaces

| Interface | Possible future impact | Current action |
|---|---|---|
| ROLE-CONTRACT | distinguish general qualification from right-now qualification | no change |
| PRE-FLIGHT-SEQUENCE | add human-state readiness check | future candidate |
| OPERATING-RULES | add human drift signals for pause/converge/escalate | later |
| HEARTBEAT | periodic reflection/metabolism of human-state drift | later |
| TRUTH-CONTRACT | remains expression truth layer, not judgment-state layer | no change |
| CONTEXT-BUDGET | human attention already appears as budget object, but not as governance object | later |

---

## 6. Whitepaper Candidate

未来候选段落（not for immediate insertion）：

> FAO 不只治理智能体的越界与伪完成，也治理协作中人类节点的有限状态——注意力、疲劳与责任压力不是缺陷，而是决定判断质量的真实条件。人不是无限理性的监督者，而是需要被保护其判断力不被过度消耗的主体。治理的目的不是消除人的有限性，而是在有限性中守住责任锚点。

---

## 7. Open Conditions Before Absorption

未来吸收前必须满足的条件：

1. 至少回答原 human-state-governance note 中 3 个以上 open questions。
2. 明确 human-state governance 与 agent governance 的边界。
3. 明确 human-state governance 与 general organization governance 的边界。
4. 明确 PRE-FLIGHT human-state check 的最小字段。
5. 明确何种 human-state signal 触发 pause / escalate / second review / continue。
6. 将 maker-checker / guarantee examples 隔离到 domain case。
7. 获得明确授权后再修改 framework 或 whitepaper。

---

## 8. Relation to Five Roots / Five Actions

只作为 explanatory note，不作为 framework 正文：

- **仁 / 和界**：承认人的有限性，但不取消人的责任锚点。
- **空 / 释形**：不执着"人类监督者天然可靠"这一形。
- **玄 / 观深**：看见人类节点被激励、疲劳、压力、工具输出塑形的复杂性。
- **舞 / 调律**：通过暂停、复核、升级、节奏调整，防止人类节点抢拍乱位。
- **致 / 成事**：责任性判断必须落到可验证、可承担、可收口的结果。

---

## 9. Non-Goals

This note does not:

- diagnose individuals psychologically;
- treat human weakness as moral failure;
- remove human responsibility;
- replace role contracts;
- modify framework;
- modify whitepaper;
- convert domain examples into general theory.

---

## 10. Next Step

Next step: keep this as a sidecar until PRE-FLIGHT human-state check can be specified minimally.

---

*Generated: 2026-05-19*
*Status: sidecar / pre-absorption*
*Not framework. Not whitepaper.*
