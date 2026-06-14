# Governance Line Notes

This directory stores governance-line sidecars.

These notes are not framework content and not whitepaper content.

Human-state governance is currently a mainline candidate in pre-absorption status.

Existing files may record candidate interfaces, but do not by themselves modify framework or whitepaper.

Any absorption into framework or whitepaper requires explicit review and authorization.

Current known candidate direction: PRE-FLIGHT human-state readiness check remains draft-only unless promoted later.

---

*本目录存放治理线 sidecar 笔记。*
*不是框架内容，不是白皮书内容。*
*入主线需经明确审核与授权。*

---

### Capability Commodity and Responsibility Interface

> 来源：歸藏《万字长文：做了些爆款 Skills 以后，我对 Skills 的看法》（2026-06-14），外部观察材料，未验证为框架依据。

歸藏的核心观察：Skill commoditizes capability。专家的经验、工作流、品味、工具调用、模板、脚本、边界和失败经验被封装成可分发、可复用、可迭代的能力单元。这是 Agent 时代「能力商品化」的底层逻辑。

但 FAO 的治理视角是：能力可以被商品化，责任接口不能被商品化。

Skill 封装的是「怎么做」，不是「谁负责」。触发条件、维护责任、失败回滚、人工判断保留点和对外承诺边界不能随能力流动而消失。当 Skill 被分发到多个 harness 时，以下问题不能默认由 Skill 自身回答：

- 当 Skill 的 eval 漏过一个边缘 case，谁来承担后果？
- 当 Skill 的 gotchas 失效，谁来更新？
- 当 Skill 被用于对外承诺场景（如合同、保函、医疗、法律），谁保留最终判断权？

**最小口径**：Skill 让能力商品化，但 FAO 要治理的是能力商品背后的责任接口。能力可以被封装、分发和调用，但触发条件、维护责任、失败回滚、人工判断保留点和对外承诺边界不能随能力流动而消失。

**与 governance-line 已有案例的关系**：DingTalk ONE 事件（`dingtalk-one-workplace-governance-incident-note.md`）中，AI 工作信息流工具被封装为「能力」，但责任接口（谁对信息聚合结果负责、谁对错误推送负责）并未同步明确。这与 Skill 商品化的 governance 张力存在相邻治理结构：能力入口扩张后，触发条件、使用边界、维护责任和失败回滚都需要重新显化。

**当前状态**：作为 governance-line sidecar 观察，不入 framework 主干，不进入 whitepaper。
