# 迁移计划

> 新 `framework/` 上位骨架接管旧分类法的逐步迁移方案。

---

## 文档定位

- `framework/` 已形成新的上位骨架候选
- 本文用于说明新骨架如何逐步接管旧的 `minimal-core / governance` 分类法
- 旧目录在迁移期内先保留，不自动作废
- 本文同时为"成本主线"留正式占位

---

## 一、为什么需要 migration plan

**为什么当前阶段不应一边继续补新文件、一边直接改旧目录正文**：
- 新骨架尚未经验证稳定，直接修改旧内容风险过高
- 需要保持旧结构可读，作为对照和回退基准
- 同时改动两端会导致无法判定问题来源

**为什么需要先有迁移计划，再做 README/目录替换**：
- 迁移是结构性变更，需先明确映射关系
- 直接替换 README 会造成读者困惑
- 需给旧内容找到明确归宿后再调整说明文案

**为什么旧结构应先退位为 legacy grouping，而不是立即删除**：
- 旧分类法仍有参考价值，可映射到新骨架
- 部分内容尚未完全迁移，需要过渡期
- 删除会造成历史记录断裂

---

## 二、迁移目标

| 目标 | 说明 |
|------|------|
| **1. 新 `framework/` 成为上位骨架** | 新框架成为仓库结构的主导说明，旧目录退位为从属 |
| **2. 旧 `minimal-core / governance` 退位为 legacy grouping 或实现来源** | 旧分类法保留但明确标记为 legacy，其内容可映射到新文件 |
| **3. 以"映射、替换、冻结"顺序渐进迁移** | 不做一次性推翻，分阶段逐步完成，确保每一步可验证 |

---

## 三、当前框架完成度判断

| 文件/目录 | 模块 | 状态 | 作用 |
|-----------|------|------|------|
| `UNIVERSAL-WORK-NODE-FRAMEWORK.md` | Constitution | ✅ v1.1 | 框架总定义 |
| `META-ACTIONS.md` | Constitution | ✅ v1.0 | 元动作表 |
| `ROLE-CONTRACT.md` | Role | ✅ v1.0 | 角色契约 |
| `TRUTH-CONTRACT.md` | Assurance | ✅ v1.0 | 真实性合同 |
| `PRE-FLIGHT-SEQUENCE.md` | Runtime | ✅ v1.0 | 前置检查序列 |
| `OPERATING-RULES.md` | Runtime | ✅ v1.0 | 运行母规则 |
| `MEMORY-INDEX.md` | Continuity | ✅ v1.0 | 长期连续性薄索引 |
| `CORRECTION-WRITEBACK.md` | Continuity | ✅ v1.0 | 纠错写回协议 |
| `judgment-cards/README.md` | Continuity | ✅ v1.0 | 判断卡片接口 |
| `judgment-cards/GUARANTEE-STRUCTURE-DISAMBIGUATION.md` | Continuity | ✅ v1.0 | 第一张具体判断卡片 |
| `schemas/correction_record.schema.json` | Continuity | ✅ v1.0 | 纠错记录 Schema |
| `OPENCLAW-MAPPING.md` | Mapping | ✅ v1.0 | OpenClaw 映射文档 |

**结论**：`framework/` v1 骨架已形成，具备接管条件。

---

## 四、旧结构到新骨架的迁移映射

| 旧分组 / 旧文件 | 在新框架中的位置 | 迁移方式 | 当前状态 |
|-----------------|------------------|----------|----------|
| `toolkit/minimal-core/soul.md` | `IDENTITY.md` / `SOUL.md`（bootstrap 层） | 映射承接 | 保留待迁 |
| `toolkit/minimal-core/memory.md` | `framework/MEMORY-INDEX.md` + `memory/` 目录 | 映射承接 | 已部分承接 |
| `toolkit/minimal-core/heartbeat.md` | `HEARTBEAT.md`（bootstrap 层） | 映射承接 | 保留待迁 |
| `toolkit/governance/TRUTH-CONTRACT-v1.md` | `framework/TRUTH-CONTRACT.md` | 映射承接 | 新版本已替代 |
| `toolkit/governance/EXTERNAL-CALL-CHECKLIST.md` | `framework/OPERATING-RULES.md`（外部调用部分） | 后续拆分 | 保留待迁 |
| `toolkit/governance/FAILURE-REPORT-CHECKLIST.md` | `framework/CORRECTION-WRITEBACK.md` + `FAILURE-PROTOCOL.md`（占位） | 后续拆分 | 保留待迁 |
| `toolkit/governance/templates/identity-cloud-node.md` | `framework/ROLE-CONTRACT.md` + `IDENTITY.md` | 后续拆分 | legacy 保留 |
| `toolkit/governance/templates/user.md` | `USER.md`（bootstrap 层） | 映射承接 | 保留待迁 |
| `toolkit/governance/schemas/` | `framework/schemas/` | 映射承接 | 已部分承接 |

---

## 五、迁移阶段建议

### 阶段 1：冻结新骨架
- 不再横向扩大量新文件
- 先确认 framework v1 可工作
- 完成至少一轮整体验证

### 阶段 2：README 级退位
- 修改旧 README / 说明文案
- 明确 `framework/` 为上位骨架
- 明确旧分组为 legacy grouping
- 添加迁移说明和映射指引

### 阶段 3：内容级映射
- 将旧内容逐步对应到新文件
- 不做一次性大迁移
- 逐文件确认映射关系
- 更新旧文件头部说明，指向新位置

### 阶段 4：条件满足后再决定目录级替换
- 只有当新骨架经验证稳定
- 旧 README 已完成退位说明
- 主要旧文件已有明确归宿
- 才决定是否正式重构 `toolkit/` 目录结构

---

## 六、迁移完成的判定条件

- [ ] 新 `framework/` 已形成自洽骨架（已完成）
- [ ] 至少完成一轮整体验证（已完成保函节点测试）
- [ ] 旧 README 已改为从属表述（待阶段 2）
- [ ] 主要旧文件已有对应归宿（待阶段 3）
- [ ] 迁移后不会让读者无法理解仓库结构（待阶段 4）

---

## 七、成本主线占位

**成本是白皮书中的重要主线，不能丢。**

当前 `framework/` v1 已含最弱形式的成本纪律：
- `OPERATING-RULES.md`：避免无谓扩张、及时收敛
- `PRE-FLIGHT-SEQUENCE.md`：前置检查，避免错误任务展开

但尚未把成本作为独立主线全面展开。

成本将在后续版本中单独整合：
- 可能形式：`COST-PLANE.md` 或融入各文件的控本规则
- 不在本轮迁移中强行并入所有文件
- 避免为成本而成本，保持框架精简

---

## 八、当前不做的事

- ❌ 暂不补完整 cost control plane
- ❌ 暂不补完整 orchestration / eval / tracing 平台
- ❌ 暂不直接删除旧目录
- ❌ 暂不把所有旧内容一次性改写进新框架
- ❌ 暂不修改旧 README 和说明文案（待阶段 2）
- ❌ 暂不改动 `toolkit/minimal-core/`、`toolkit/governance/` 正文

---

## 九、边界声明

- **本文是迁移计划，不是迁移执行日志**：本文定义"如何接管"，不记录已完成的迁移
- **本文不直接修改旧内容**：旧目录正文保持现状，修改待后续阶段执行
- **本文只定义"如何接管"，不直接完成接管**：具体接管动作按阶段逐步进行

---

*版本：v1.0*  
*性质：迁移计划*  
*生效状态：待阶段 1 完成后正式启动*
