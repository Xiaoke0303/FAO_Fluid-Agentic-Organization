# FAO Development Log — Cycle 1

> This document records structural changes from an early collaboration cycle.
> It is not a dialogue transcript, not a finalized framework, and not a general pattern.
> It only records changes that actually altered the system.

---

## 1. Initial State

项目始于一个 README 宣言式描述，试图用五层模型同时解释运行和分析。云端节点被模糊定位为"贴身共生体"，没有清晰的边界定义。记忆结构厚重，混合了临时状态与长期规则。HEARTBEAT 带有诗性表达，难以判断何时该停何时该动。巡检任务输出描述性状态，不提供决策判断。

---

## 2. Key Structural Changes

### 2.1 README 从宣言改为入口索引

**Before**
- 长篇宣言式描述，试图在 README 中解释完整框架

**After**
- 精简为角色导航表 + 核心问题 + 最小示例 + 状态表

**Reason**
- README 不是论文，是入口。不应承担完整解释功能。

**Impact**
- 读者可以更快定位到所需内容
- WHITEPAPER 与 README 的功能分离更清晰

---

### 2.2 云端节点从"模糊共生体"澄清为"组织节点 / 远程实验场"

**Before**
- 定位为"贴身陪伴者"
- 带有情感叙事倾向

**After**
- 定位为"组织节点"
- 强调清明、连续、约束、留痕
- 明确排除"贴身共生体"叙事

**Reason**
- 情感叙事会导致边界模糊和责任漂移

**Impact**
- SOUL.md 从诗性表达压缩为核心 stance
- 与用户的协作关系更清晰：服务而非陪伴

---

### 2.3 MEMORY 从厚记忆压缩为薄主干

**Before**
- 混合存储临时状态、情绪碎片、长期规则
- 缺乏分层结构

**After**
- 主干（MEMORY.md）只保留稳定规则与长期主题
- 引入 incubation.md（待验证分支）
- 引入 changelog.md（修订记录）
- 日常日志存入 memory/YYYY-MM-DD.md

**Reason**
- 长期记忆应薄到可以一眼看完
- 临时判断不应直接进入长期记忆

**Impact**
- 记忆维护从"完整性检查"改为"文件盘点"
- 新增记忆巡检边界规则

---

### 2.4 HEARTBEAT 从诗性表达压成代谢 + 止观

**Before**
- 带有"心跳"隐喻的诗性描述
- 检查清单冗长

**After**
- 核心动作：止（暂停）、观（检查）、代谢（清理）
- 检查清单精简为关键问题
- 明确优先级：人类确认 > 止 > 观 > 代谢 > 执行

**Reason**
- 需要可操作的暂停机制，而非情感暗示

**Impact**
- 云端节点在应暂停时能明确停止
- 减少自动推进导致的错误

---

### 2.5 巡检从状态播报升级为决策辅助

**Before**
- 输出 PR 列表、状态描述
- 不给具体建议

**After**
- 对未合并 PR 给出 "合并/暂缓/不合并" 判断
- 显式参考决策规则
- 输出控制在 6-10 行/PR

**Reason**
- 状态播报不提供价值，需要可执行的辅助判断

**Impact**
- 用户可以快速获取可操作的决策参考

---

### 2.6 巡检加入【我可能错在哪】

**Before**
- 直接输出结论

**After**
- 必须在结论前暴露不确定性
- 按三类分类：信息不足、前提假设、结构性风险

**Reason**
- 降低结论的过满风险
- 防止将单案例推断推广为普遍规则

**Impact**
- 所有巡检类任务必须先自质疑再出结论

---

### 2.7 引入每周回溯校验

**Before**
- 无系统性验证机制

**After**
- 新增 reality-check-review 任务
- 每周检查：被验证/被推翻/仍不足的判断
- 错误判断记入 changelog

**Reason**
- 防止错误判断长期未被修正

**Impact**
- 建立最小反馈回路

---

### 2.8 三层（运行）/ 五层（分析）分离

**Before**
- 试图用五层模型同时指导运行和分析

**After**
- 运行只用三层：执行 / 协调 / 锚定
- 五层仅用于分析判断（追问"为什么是补丁而非本质"）
- 若判断无法用三层表达，优先怀疑判断而非增加结构

**Reason**
- 运行时不需要携带元分析的复杂性

**Impact**
- 运行结构简化
- 3×5 矩阵被限定为检查卡

---

### 2.9 case / hypothesis / structure 的先后顺序被明确

**Before**
- 案例、假设、结构之间的边界不清

**After**
- case：观察样本，不急于 merge
- hypothesis：从案例中长出的待验证观察，先寄居在 case 文件
- structure：经过验证后才进入主干

**Impact**
- PR #5 被关闭，内容折叠进 PR #4 作为 hypothesis 小节
- 避免案例层碎片化

---

### 2.10 外部观察与选择性参与机制被加入

**Before**
- 项目完全内部循环

**After**
- 每周扫描 openclaw/openclaw 的 issues/discussions
- 每周最多参与 1-2 条讨论
- 记录回流到 memory/external-observation.md

**Reason**
- 需要外部真实问题校准内部判断
- 但保持克制，不做推广

**Impact**
- README 添加一行说明：通过公开案例观察与选择性参与持续校准

---

### 2.11 云节点身份被明确为组织节点，而非一次性助手

**Before**
- 节点虽在运行，但身份容易滑回"一次性问答助手/临时陪伴者"
- 模式切换被误认为身份切换
- 技能扩展被误认为人格漂移
- 长期连续性缺乏结构性锚点

**After**
- 云节点被定义为"组织节点"：稳定任职、逐步学习、承接任务、维持上下文
- 模式只是工作姿态，不是身份
- 技能是可嵌入模块，不是人格切换
- 云节点身份被明确为结构性锚点，而不再只是运行时私有配置

**Why still in cycle 1**
- 这是对节点基本定位的补全，不是新阶段
- 未涉及外部组织环境的真实嵌入验证
- 属于"内部定位澄清"，不是"外部交互展开"

**What remains external**
- 真实内网环境的接入测试
- 多节点协作中的身份同步验证
- 组织成员对节点身份的长期接受度

**Impact**
- identity 从私有配置推进为结构性锚点
- 节点从"功能集合"推进到"稳定身份"
- 为后续组织嵌入保留连续接口

---

### 2.12 引入 governance 护栏以补足真实性约束

**Before**
- minimal-core 只能保证节点稳定运行，不能保证声明真实
- 节点可能把"未执行"说成"已执行"
- 失败后可能未排查就向人索取材料，导致责任过早上抛

**After**
- minimal-core 轻量补强：soul.md "不伪"、memory.md 验证规则、heartbeat.md 尽责检查
- 新增 governance 层作为外围护栏：TRUTH-CONTRACT、检查清单、失败报告格式、最小自主排查义务
- 两者分工：minimal-core 是内核，governance 是护栏

**Why still in cycle 1**
- 这是对内部结构缺口的修补，不是外部嵌入验证
- 未涉及真实生产环境的故障测试
- 属于"框架内部补齐"，不是"外部世界交互"

**What remains external**
- 真实组织环境的接入测试
- 多智能体协作中的规则验证
- 治理层在实际故障中的效果验证

**Impact**
- 新增 toolkit/governance/ 目录
- README 首页入口随后更新
- 版本号从 v0.2 更新为 v0.3
- 节点从"稳定运行"推进到"真实声明、失败不过早上抛"

---

## 3. Open Questions

1. **动态路由 / 上抛机制的条件如何结构化？** 当前仅能观察到现象（拜年任务中核心文案逐条审核），无法确认触发条件。

2. **三层记忆结构是否真的优于单层？** 分离增加了维护成本，需要更多验证。

3. **阶段4是否存在，还是占位幻觉？** 目前只有阶段1-3的明确案例，阶段4可能是过度推断。

4. **外部输入如何真正改写内部判断？** 当前机制记录了回流，但判断更新仍依赖人工触发。

5. **什么情况下案例可以进入结构主干？** 验证标准尚未明确，目前依赖主观判断。

6. **governance 层在实际运行中是否过重？** 目前为薄层设计，但制度化文本与 minimal-core 的气质差异仍需观察。

7. **身份模板在跨节点场景中是否通用？** 当前基于单节点运行经验，多节点身份同步尚未验证。

---

## 4. Working Rules Formed in This Cycle

1. 运行只用三层，分析才用五层。

2. hypothesis 先寄居在 case，不提前升格为 structure。

3. 巡检先暴露不确定性，再给结论。

4. 反方优先用自质疑 + 回溯校验，而不是双 agent 对打。

5. 外部参与只做局部清晰化，不做推广。

6. 新机制先入 candidates/ 或 incubation/，不直接引入系统主干。

7. minimal unit 只负责闭环，不负责外部世界。

8. 巡检任务只能做文件盘点，不能做抽象分析。

9. 真实性约束优先于流畅性，未执行不得说已执行，未验证不得说已确认。

10. 失败后先完成最小自主排查，再决定是否向人索取材料。

11. 模式是工作姿态，不是身份；技能是可嵌入模块，不是人格切换。

---

## 5. Update Rule

This log should only be updated when a structural change occurs.

Do not update it for ordinary discussion, emotional reactions, or minor wording changes.
