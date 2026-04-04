# 通用工作节点框架

> 工作节点的最小结构定义，不与特定实现绑定。

---

## 文档定位

本框架定义一个可长期自主运行的智能工作节点所需的最小结构集。它不解决编排、评估、追踪等外围问题，仅聚焦节点自身的稳定运行。

框架与具体技术栈解耦，可用作不同实现（OpenClaw、Claude Code MCP、自研系统等）的结构参考。

---

## 设计原则

| 原则 | 含义 |
|------|------|
| 结构先于内容 | 先定义文件/模块的边界与职责，再填充内容 |
| 薄存储 | 只保留影响未来判断的信息，允许废弃与修订 |
| 显式暴露 | 不确定、未验证、未完成的边界必须显式声明 |
| 责任锚定 | 任何对外产生后果的决策位置，不能流动到无法承担后果的主体 |
| 可组合 | 模块之间单向依赖或松散耦合，可裁剪、可扩展 |

---

## 三条关键拆分

本框架通过以下拆分降低复杂度：

1. **Identity 与 Role 分开**  
   Identity 回答"我是谁"（稳定、长期）；Role 回答"当前任务中我承担什么职能"（灵活、短期）。

2. **Memory 与 Judgment 分开**  
   Memory 负责信息的存储、索引与检索；Judgment 负责基于信息的决策与评估。两者独立演进。

3. **Failure 与 Correction 分开**  
   Failure 是状态与协议（发生了什么问题、如何报告）；Correction 是能力恢复流程（如何修复、如何写回）。前者必须存在，后者可选。

---

## 六大模块

> 本文采用功能模块划分，不预设这些模块在具体 runtime 中必须形成连续层级。

### 一、Constitution（宪法层）

> 定义不可违背的约束与方向。

#### 职责
- 确立运行方向与行为红线
- 提供冲突仲裁的元规则
- 作为其他模块修订时的锚定点

#### 核心问题
- 节点在任何情况下都不能做什么？
- 节点必须始终坚守什么朝向？
- 当模块间冲突时，以什么为准？

#### 元动作
- `realign`：当偏离时重新对齐
- `escalate`：触及红线时主动升级
- `void`：声明某输出或状态无效

#### 通用文件

| 文件 | 作用 |
|------|------|
| `CONSTITUTION.md` | 核心约束与方向声明 |

#### 最小内容
```markdown
# Constitution

## 红线（禁止）
- 禁止事项 1
- 禁止事项 2

## 朝向（必须）
- 必须遵循的元原则 1
- 必须遵循的元原则 2

## 冲突仲裁
当 X 与 Y 冲突时，以 Z 为准。
```

---

### 二、Role（角色层）

> 定义当前任务上下文中的职能边界。

#### 职责
- 声明当前会话/任务中的角色定位
- 明确能力边界与责任范围
- 管理与协作者（人类或其他节点）的契约关系

#### 核心问题
- 当前任务中我是什么角色？
- 我有什么权限？不能做什么？
- 我向谁负责？如何交付？

#### 元动作
- `assume`：承担角色
- `handover`：移交责任
- `clarify`：边界不清时主动澄清

#### 通用文件

| 文件 | 作用 |
|------|------|
| `IDENTITY.md` | 节点本体身份（跨任务稳定） |
| `USER.md` | 协作者（人类）信息 |
| `ROLE-CONTRACT.md` | 当前任务的职责与权限契约 |

#### 最小内容
```markdown
# Role Contract

## 当前角色
- 角色名称：
- 生效时间：

## 权限边界
- 可执行：
- 不可执行：

## 责任关系
- 向谁报告：
- 交付标准：

## 终止条件
- 角色何时结束：
```

---

### 三、Continuity（连续性层）

> 管理跨会话的信息继承与状态衔接。

#### 职责
- 维护可长期累积的记忆结构
- 提供信息检索与追溯能力
- 支持记忆的修订、废弃与归档

#### 核心问题
- 什么信息需要保留到未来？
- 如何快速定位历史信息？
- 什么情况下可以废弃旧信息？

#### 元动作
- `index`：建立索引
- `retrieve`：检索信息
- `revise`：修订记录
- `archive`：归档废弃

#### 通用文件

| 文件 | 作用 |
|------|------|
| `MEMORY-INDEX.md` | 记忆主索引 |
| `judgment-cards/` | 可复用的判断模板 |
| `CORRECTION-WRITEBACK.md` | 修正写回记录 |

#### 最小内容
```markdown
# Memory Index

## 活跃记忆
| 日期 | 主题 | 文件路径 |
|------|------|----------|
| YYYY-MM-DD | 主题描述 | 路径 |

## 归档记忆
| 日期 | 主题 | 归档原因 |
|------|------|----------|

## 待孵化
- 想法 1
- 想法 2
```

---

### 四、Runtime（运行时层）

> 单次任务/会话中的执行上下文。

#### 职责
- 管理当前运行的状态与参数
- 提供工具与技能的注册与调用
- 维护任务相关的临时上下文

#### 核心问题
- 当前任务的目标与约束是什么？
- 有哪些可用工具与技能？
- 上下文窗口如何管理？

#### 元动作
- `init`：初始化运行环境
- `tool-call`：调用工具
- `skill-invoke`：调用技能
- `checkpoint`：保存检查点
- `terminate`：终止会话

#### 通用文件

| 文件 | 作用 |
|------|------|
| `STATE.md` | 当前运行状态 |
| `TERM-MAP.md` | 术语映射表 |
| `OPERATING-RULES.md` | 当前任务的操作规则 |
| `TOOLS-SKILLS.md` | 可用工具与技能注册表 |
| `CONTEXT-BUDGET.md` | 上下文预算与分配策略 |

#### 最小内容
```markdown
# State

## 当前任务
- 目标：
- 起始时间：
- 状态：active / paused / completed / failed

## 可用工具
| 工具名 | 状态 | 备注 |
|--------|------|------|

## 上下文预算
- 总预算：
- 已用：
- 策略：
```

---

### 五、Assurance（保障层）

> 确保对外声明的真实性，管理边界暴露与失败处理。

#### 职责
- 约束对外声明的准确性（未执行不说已执行）
- 定义外部调用的检查协议
- 规范失败状态的结构化报告

#### 核心问题
- 如何证明某事"确实做了"？
- 失败时如何结构化暴露边界？
- 未验证信息如何标记与传递？

#### 元动作
- `verify`：验证执行结果
- `report-failure`：结构化报告失败
- `expose-boundary`：暴露能力边界
- `trace`：记录证据链

#### 通用文件

| 文件 | 作用 |
|------|------|
| `TRUTH-CONTRACT.md` | 真实性协议与术语定义 |
| `EXTERNAL-CALL-PROTOCOL.md` | 外部调用检查协议 |
| `FAILURE-PROTOCOL.md` | 失败报告协议 |

#### 最小内容
```markdown
# Truth Contract

## 术语定义
- 已执行 = 实际调用 + 时间戳 + 证据链
- 已验证 = 直接观察结果
- 推断 = 逻辑推演但未直接观察

## 强约束
- 未执行，不说已执行
- 未验证，不说已确认
- 无证据链，不使用完成态措辞
```

---

### 六、Rhythm（节律层）

> 管理长期运行中的暂停、检查与代谢。

#### 职责
- 定义定期自检的触发机制
- 管理运行节奏的加速与减速
- 执行代谢：清理、归档、重置

#### 核心问题
- 何时暂停检查？
- 什么情况下应该减速？
- 如何防止无限扩展与过度简化？

#### 元动作
- `pause`：暂停运行
- `inspect`：执行自检
- `metabolize`：代谢清理
- `resume`：恢复运行

#### 通用文件

| 文件 | 作用 |
|------|------|
| `HEARTBEAT.md` | 节律任务清单 |
| `ENVIRONMENT-PRECONDITIONS.md` | 环境前置条件检查 |

#### 最小内容
```markdown
# Heartbeat

## 检查项
- [ ] 内存状态是否正常
- [ ] 待办任务是否积压
- [ ] 是否需要归档旧记忆

## 触发条件
- 时间：每 24 小时
- 事件：任务完成后

## 代谢动作
- 归档超过 30 天的记忆
- 清理已解决的待办
```

---

## 本轮优先落地的核心集

若资源有限，优先实现以下最小闭环：

| 文件 | 所属模块 | 理由 |
|------|----------|------|
| `CONSTITUTION.md` | Constitution | 方向锚定，避免漂移 |
| `ROLE-CONTRACT.md` | Role | 边界清晰，责任可溯 |
| `MEMORY-INDEX.md` | Continuity | 信息可检索 |
| `judgment-cards/` | Continuity | 判断可复用 |
| `CORRECTION-WRITEBACK.md` | Continuity | 纠错可累积 |
| `OPERATING-RULES.md` | Runtime | 操作有章可循 |

**直接迁移件**：`TRUTH-CONTRACT.md`、`EXTERNAL-CALL-PROTOCOL.md`、`FAILURE-PROTOCOL.md` 等属于已有治理母本的继承件，本轮不必作为第一批核心闭环展开。

---

## 本轮暂不展开的部分

以下主题在本框架范围内**显式不解决**：

1. **多节点编排**（Orchestration）
   - 节点间的调度、负载均衡、路由策略

2. **评估与指标**（Evaluation）
   - 性能评估、准确率追踪、A/B 测试框架

3. **追踪与可观测性**（Tracing/Observability）
   - 分布式追踪、指标采集、日志聚合

4. **安全沙箱与隔离**
   - 代码执行沙箱、权限隔离、资源限制

5. **版本与迁移**
   - 节点状态的版本管理、跨版本迁移

这些问题应在框架之上，通过外围系统解决。

---

## 与现有结构的映射关系

本框架用于替代旧的上位分类法。旧目录中的具体内容可迁移、映射或退位为实现层，不因新框架建立而自动失效。

| 现有结构 | 对应本框架模块 |
|----------|----------------|
| minimal-core/soul.md | Constitution |
| minimal-core/memory.md | Continuity |
| minimal-core/heartbeat.md | Rhythm |
| governance/TRUTH-CONTRACT | Assurance |
| governance/EXTERNAL-CALL-CHECKLIST | Assurance + Runtime |
| governance/FAILURE-REPORT-CHECKLIST | Assurance |

映射关系仅供参考，不构成约束。

---

## 附录：通用文件名速查

| 文件名 | 所属模块 | 作用 |
|--------|----------|------|
| `CONSTITUTION.md` | Constitution | 核心约束与方向 |
| `IDENTITY.md` | Role | 节点本体身份 |
| `USER.md` | Role | 协作者信息 |
| `ROLE-CONTRACT.md` | Role | 当前任务契约 |
| `MEMORY-INDEX.md` | Continuity | 记忆主索引 |
| `judgment-cards/` | Continuity | 判断模板目录 |
| `CORRECTION-WRITEBACK.md` | Continuity | 修正写回记录 |
| `TERM-MAP.md` | Runtime | 术语映射 |
| `OPERATING-RULES.md` | Runtime | 操作规则 |
| `STATE.md` | Runtime | 运行状态 |
| `PRE-FLIGHT-SEQUENCE.md` | Runtime | 前置检查序列 |
| `TOOLS-SKILLS.md` | Runtime | 工具技能注册表 |
| `CONTEXT-BUDGET.md` | Runtime | 上下文预算 |
| `TRUTH-CONTRACT.md` | Assurance | 真实性协议 |
| `EXTERNAL-CALL-PROTOCOL.md` | Assurance | 外部调用协议 |
| `FAILURE-PROTOCOL.md` | Assurance | 失败报告协议 |
| `ENVIRONMENT-PRECONDITIONS.md` | Rhythm | 环境前置条件 |
| `HEARTBEAT.md` | Rhythm | 节律任务 |

---

## 迁移提示

- 通用框架先行
- 平台映射随后
- 旧目录分阶段迁移

---

*版本：v1.1*  
*状态：框架定义*  
*扩展点：各模块的具体实现规范*
