# 纠错写回协议

> 错误在被纠正后，正式转成未来判断约束的协议。承接"纠错"与"写回"元动作。

---

## 文档定位

- 本文是**纠错写回协议**
- 不是 failure report
- 不是 memory index
- 不是 judgment card

回答的是：一次错误在被纠正后，如何正式转成未来判断约束。

---

## 一、为什么需要 correction writeback

**failure protocol 只能暴露错误，不能自动形成未来约束的原因**：
- Failure Protocol 是事后报告格式，回答"发生了什么"
- 它不回答"下次如何避免"
- 暴露不等于修正，修正不等于写回

**memory index 不应直接吸收未经分型的错误的原因**：
- Memory Index 是信息索引主干，需要保持结构清晰
- 未经分型的错误直接写入会造成噪音
- 需要协议层先处理、先分型、再决定写入位置

**需要一个位于 failure 与 memory/judgment 之间的协议接口**：
- Failure 暴露错误
- Correction Writeback 处理错误（分型、修正、决定写回位置）
- Memory / Judgment 承接错误后果（长期存储或判断接口更新）

---

## 二、correction writeback 解决什么问题

| 问题 | 说明 |
|------|------|
| **错误如何分类** | 对错误进行分型，便于后续处理 |
| **修正后的稳定表达如何形成** | 把纠正转化为可复用的正确表述 |
| **纠错结果写到哪里** | 决定进入 memory-index、judgment-cards、term-map 还是 incubation |
| **下次遇到类似问题时如何优先检索** | 设定检索优先级，确保纠错结果被优先参考 |
| **哪些纠错只能进入孵化区** | 高风险或未充分确认的纠错，先进入待验证区 |

---

## 三、correction writeback 不解决什么问题

- **不替代 failure protocol**：Failure 是暴露，Correction 是处理，两者分工不同
- **不替代 memory index**：Memory Index 是存储，Correction Writeback 是决定"存到哪里、怎么存"
- **不替代 judgment card**：Judgment Card 是判断接口，Correction Writeback 可以修改它，但不等于它
- **不替代 truth contract**：Truth Contract 约束真实性，Correction Writeback 服从它
- **不替代人工复核本身**：Correction Writeback 记录纠错结果，但高风险纠错仍需人工确认

---

## 四、纠错写回的最小流程

1. **错误识别**  
   明确识别出错误的存在，与 Failure Protocol 对接，获取错误基本信息。

2. **错误分型**  
   按既定类型对错误分类（事实、判断、术语、边界等），分型决定后续处理路径。

3. **修正表达形成**  
   将纠正转化为稳定、可复用的正确表述，形成写回内容的正文。

4. **写入位置判定**  
   根据错误类型和风险等级，决定写入 memory-index、judgment-cards、term-map 或 incubation。

5. **检索优先级设定**  
   设定该纠错结果在未来检索中的优先级，影响是否优先展示。

6. **后续复核状态**  
   标记该纠错结果是否已验证、待复核或已废弃，支持后续追踪。

---

## 五、错误分型建议

| 错误类型 | 说明 |
|----------|------|
| **事实错误** | 对客观事实的陈述错误，如数据、日期、名称错误 |
| **判断错误** | 基于事实的推理或判断错误，如分类错误、优先级误判 |
| **术语混淆** | 术语使用不当或概念混淆，需要澄清或统一 |
| **边界错误** | 越界或缩界，承担了不该承担的判断或回避了应承担的责任 |
| **顺序错误** | 执行步骤顺序不当，导致结果偏差 |
| **过度确认 / 伪完成** | 把未完成、未验证的状态表述为已完成、已确认 |
| **环境误归因** | 将节点能力不足错误归因于环境前提不满足，或反之 |

---

## 六、写入位置判定

| 写入位置 | 进入条件 |
|----------|----------|
| **`MEMORY-INDEX.md`** | 错误涉及长期信息更新，且已充分验证，可进入记忆主干 |
| **`judgment-cards/`** | 错误涉及判断模式修正，形成新的或更新已有判断卡片 |
| **`TERM-MAP.md`** | 错误属于术语混淆，需要添加术语映射或澄清 |
| **changelog / correction log** | 所有纠错都应记录日志，作为审计轨迹 |
| **incubation / 待验证区** | 高风险或未充分确认的纠错，先进入孵化区，验证后再决定去向 |

**分流逻辑**：
- 判断接口（judgment-cards）和长期记忆主干（memory-index）需要充分验证后才能写入
- 不确定的纠错结果必须先进入 incubation，不得直接进入主干
- changelog 是所有纠错的必经记录点

---

## 七、检索优先级规则

**应当提高未来检索优先级**：
- 事实错误（直接影响正确性）
- 过度确认 / 伪完成（高风险）
- 边界错误（影响责任界定）

**只能保留低优先级记录**：
- 风格偏好类纠错
- 已验证为偶发的孤立错误
- 环境误归因（已纠正归因逻辑后）

**可以降级、废弃或被覆盖**：
- 已被新纠错覆盖的旧纠错
- 经过长期验证不再适用的纠错
- 标记为 deprecated 的判断卡片

---

## 八、与其他文件的关系

| 文件 | 关系 |
|------|------|
| `FAILURE-PROTOCOL.md` | Failure Protocol 是暴露错误的格式，Correction Writeback 是处理错误的协议。前者是输入源，后者是处理层。 |
| `MEMORY-INDEX.md` | Memory Index 是纠错可能写入的位置之一。Correction Writeback 决定什么可以进入记忆主干。 |
| `judgment-cards/README.md` | Judgment Cards 是纠错可能写入的位置之一。Correction Writeback 可以创建、修改或废弃判断卡片。 |
| `ROLE-CONTRACT.md` | Role Contract 中的"可写回内容"字段决定本角色产生的纠错可以写回哪里。 |
| `TRUTH-CONTRACT.md` | Truth Contract 约束纠错声明的真实性。Correction Writeback 必须服从真实性协议。 |
| `TERM-MAP.md` | Term Map 是术语纠错的可能写入位置。Correction Writeback 可以决定添加或修改术语映射。 |

---

## 九、建议模板

```markdown
# Correction Record

## 错误类型
- [ ] 事实错误
- [ ] 判断错误
- [ ] 术语混淆
- [ ] 边界错误
- [ ] 顺序错误
- [ ] 过度确认 / 伪完成
- [ ] 环境误归因

## 原错误表达
[错误时的原始表述]

## 修正表达
[纠正后的稳定表述]

## 来源
- 纠正者：
- 纠正时间：
- 相关任务/会话：

## 写回位置
- [ ] MEMORY-INDEX.md
- [ ] judgment-cards/
- [ ] TERM-MAP.md
- [ ] incubation/（待验证）
- [x] changelog only（仅记录）

## 检索优先级
- [ ] high（优先展示）
- [x] normal（正常展示）
- [ ] low（仅日志保留）

## 状态
- [ ] pending（待复核）
- [x] verified（已验证）
- [ ] deprecated（已废弃）
```

---

## 十、边界声明

- **correction writeback 是协议，不是真理仓库**：它规定如何处理纠错，不保证纠错内容永远正确
- **它只处理"已被纠正"的错误**：未纠正的错误由 Failure Protocol 处理，不进入本协议
- **它可以被后续新的纠错再次修订**：纠错结果不是终局，可以被新的纠错覆盖或废弃

---

*版本：v1.0*  
*所属模块：Continuity / Correction*  
*承接元动作：纠错、写回*
