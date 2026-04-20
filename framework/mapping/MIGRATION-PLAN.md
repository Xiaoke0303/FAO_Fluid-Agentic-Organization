# 迁移计划

> 新 `framework/` 上位骨架接管旧分类法的逐步迁移方案。

---

## 文档定位

- `framework/` 已形成新的上位骨架候选
- 本文用于说明新骨架如何逐步接管旧的 `minimal-core / governance` 分类法
- 旧目录在迁移期内先保留，不自动作废
- 本文同时为"成本主线"和 Hermes 运行时样本留正式占位

**2026-04-10 更新**：阶段 1 已完成；AGENTS.md 已本地重写为 framework v1 格式；新增 Hermes 样本映射；补充元动作完整映射与可执行检查清单。

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
| **3. Hermes 运行时样本映射就位** | 把 Hermes Agent 作为外部 runtime 参考纳入 mapping 文档 |
| **4. 以"映射、替换、冻结"顺序渐进迁移** | 不做一次性推翻，分阶段逐步完成，确保每一步可验证 |

---

## 三、当前框架完成度判断（2026-04-10）

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
| `OPENCLAW-MAPPING.md` | Mapping | ✅ v1.1 | OpenClaw 映射文档（含 Hermes 样本） |
| `HERMES-MAPPING.md` | Mapping | ✅ v1.0 | Hermes 运行时样本映射 |
| `AGENTS.md` (workspace) | Runtime+Assurance+Role | ✅ 已本地重写 | 按 framework v1 四线重编 |

**本地新增强项（历史记录，部分已推送至 feature 分支）**：
- `AGENTS.md`：已按 Identity/Memory/Judgment/Failure 四线 + Truth Contract + Operating Rules + Pre-flight 重编为中文运行入口（当前在 add-top5-agent-mappings 分支，PR #25 已关闭，待独立处理）
- `scripts/github_fao_patrol_stage1.py` + `scripts/openclaw_observer_stage1.py`：两段式数据获取脚本（当前在 add-top5-agent-mappings 分支）
- `cron/jobs.json`：周期任务改为每日，外部交互任务采用两段式模式（当前在 add-top5-agent-mappings 分支）
- `memory/zhuangzi-daily.md`：新增（已在 main 通过其他路径落实）

**结论**：`framework/` v1 骨架已形成，本地嫁接测试已完毕，具备接管条件。

---

## 四、元动作 ↔ 旧工具集 fully qualified 映射

| 元动作 | Framework v1 文件 | 旧工具集来源 | 映射方式 | 迁移说明 |
|--------|-------------------|--------------|----------|----------|
| 定向 | `CONSTITUTION.md` | `toolkit/minimal-core/soul.md` | 概念迁移 | `soul.md` 的价值观内容迁移为 `SOUL.md`（bootstrap 层），`AGENTS.md` 负责定向约束 |
| 收窄 | `ROLE-CONTRACT.md` | `toolkit/governance/templates/identity-cloud-node.md` | 拆分迁移 | 模板的身份部分映射到 `IDENTITY.md`，任务角色部分映射到 `ROLE-CONTRACT.md` |
| 择记 | `MEMORY-INDEX.md` | `toolkit/minimal-core/memory.md` | 扩展迁移 | `memory.md` 的薄存储原则迁移为 `MEMORY-INDEX.md` + `memory/` 目录 |
| 判断 | `judgment-cards/` | `toolkit/governance/templates/`（部分） | 新建映射 | 旧模板只有零散判断提示，无显式 judgment-cards 目录；需新建 |
| 纠错 / 写回 | `CORRECTION-WRITEBACK.md` | `toolkit/governance/FAILURE-REPORT-CHECKLIST.md` | 拆分迁移 | 失败报告行为保留，但纠错后的"写回"机制需要 `CORRECTION-WRITEBACK.md` 新建承接 |
| 状态锚定 | `STATE.md` | 无直接旧文件 | 新建 | 旧结构缺少显式状态锚定文件，由各 prompt 片段隐式承担 |
| 统筹 | `OPERATING-RULES.md` | `toolkit/governance/EXTERNAL-CALL-CHECKLIST.md`（外部调用统筹部分） | 扩展迁移 | 旧 checklist 只覆盖外部调用，新文件扩展为全局运行母规则 |
| 控本 | `CONTEXT-BUDGET.md` + `OPERATING-RULES.md` | 无直接旧文件 | 新建 | 旧结构缺少显式成本控制文件，仅依赖 provider 额度限制 |
| 求真 | `TRUTH-CONTRACT.md` | `toolkit/governance/TRUTH-CONTRACT-v1.md` | 直接替代 | 旧 truth contract 被新版本直接替代；真实性约束同时写入 `AGENTS.md` |
| 验证 | `EXTERNAL-CALL-PROTOCOL.md` | `toolkit/governance/EXTERNAL-CALL-CHECKLIST.md` | 拆分迁移 | 外部调用 checklist 的行为映射到验证协议，但需扩展为完整协议 |
| 代谢 | `HEARTBEAT.md` | `toolkit/minimal-core/heartbeat.md` | 直接映射 | 一对一对应，功能一致 |
| 消歧 | `TERM-MAP.md` | `toolkit/governance/SHARED-TRUTHFULNESS-BLOCK.md`（局部） | 扩展迁移 | 旧 shared block 只有极小术语约束，不足以承担消歧元动作 |
| 环境切分 | `ENVIRONMENT-PRECONDITIONS.md` | 无直接旧文件 | 新建 | 旧结构完全缺失环境切分层 |

**迁移复杂度评估**：
- 🟢 **直接映射**（3 项）：定向/择记/代谢 → `SOUL.md` / `MEMORY.md` / `HEARTBEAT.md`
- 🟡 **拆分/扩展迁移**（6 项**：收窄、纠错、统筹、控本、验证、消歧 → 需要旧内容分段迁移
- 🔴 **新建无旧来源**（4 项）：判断、状态锚定、环境切分、部分控本 → 需要从头编写

---

## 五、旧结构到新骨架的迁移映射

| 旧分组 / 旧文件 | 在新框架中的位置 | 迁移方式 | 当前状态 |
|-----------------|------------------|----------|----------|
| `toolkit/minimal-core/soul.md` | `IDENTITY.md` / `SOUL.md`（bootstrap 层） | 映射承接 | 保留待迁 |
| `toolkit/minimal-core/memory.md` | `framework/MEMORY-INDEX.md` + `memory/` 目录 | 映射承接 | 已部分承接 |
| `toolkit/minimal-core/heartbeat.md` | `HEARTBEAT.md`（bootstrap 层） | 映射承接 | 保留待迁 |
| `toolkit/governance/TRUTH-CONTRACT-v1.md` | `framework/TRUTH-CONTRACT.md` | 映射承接 | 新版本已替代 |
| `toolkit/governance/EXTERNAL-CALL-CHECKLIST.md` | `framework/OPERATING-RULES.md`（外部调用部分） + `framework/EXTERNAL-CALL-PROTOCOL.md`（占位） | 后续拆分 | 保留待迁 |
| `toolkit/governance/FAILURE-REPORT-CHECKLIST.md` | `framework/CORRECTION-WRITEBACK.md` + `FAILURE-PROTOCOL.md`（占位） | 后续拆分 | 保留待迁 |
| `toolkit/governance/templates/identity-cloud-node.md` | `framework/ROLE-CONTRACT.md` + `IDENTITY.md` | 后续拆分 | legacy 保留 |
| `toolkit/governance/templates/user.md` | `USER.md`（bootstrap 层） | 映射承接 | 保留待迁 |
| `toolkit/governance/schemas/` | `framework/schemas/` | 映射承接 | 已部分承接 |
| `notes/cost-line.md` | 待定（`CONTEXT-BUDGET.md` 或独立 `COST-PLANE.md`） | 后续整合 | 已记录，待融入框架 |

---

## 六、迁移阶段建议

### 阶段 1：冻结新骨架 ✅ 已完成
- `framework/` v1 文件集合已落成
- `OPENCLAW-MAPPING.md` / `HERMES-MAPPING.md` 已补全
- `AGENTS.md` 已按 framework v1 本地重写并通过运行测试
- 两段式脚本与 cron 调整已本地完成
- **判定**：新骨架冻结完成

### 阶段 2：README 级退位 🔄 待启动
- 修改旧 README / 说明文案
- 明确 `framework/` 为上位骨架
- 明确旧分组为 legacy grouping
- 添加迁移说明和映射指引
- **阻塞条件**：需人工确认退位文案

### 阶段 3：内容级映射 🔄 待启动
- 将旧内容逐步对应到新文件
- 不做一次性大迁移
- 逐文件确认映射关系
- 更新旧文件头部说明，指向新位置
- **阻塞条件**：阶段 2 完成后启动

### 阶段 4：目录级替换 🔄 待满足条件后启动
- 只有当新骨架经验证稳定
- 旧 README 已完成退位说明
- 主要旧文件已有明确归宿
- 才决定是否正式重构 `toolkit/` 目录结构

---

## 当前迁移状态（阶段进展登记）

当前已完成对 `toolkit/minimal-core/` 与 `toolkit/governance/` 的 README 级迁移状态标注。

本轮迁移以旧结构归宿确认与状态标注为主，尚未进入旧正文删除阶段。

- `memory.md` — 已有明确新归宿（`framework/continuity/MEMORY-INDEX.md`）
- `TRUTH-CONTRACT-v1.md` — 已有明确新归宿（`framework/assurance/TRUTH-CONTRACT.md`）
- `soul.md`、`heartbeat.md`、`schemas/`、`templates/` — 当前仍保留为 legacy 来源，尚未完成一对一正式承接

因此，当前只能视为"第一阶段迁移对账完成"，而不能视为整体迁移完成。

---

## 七、迁移完成的判定条件

- [x] 新 `framework/` 已形成自洽骨架
- [x] 至少完成一轮整体验证（本地节点测试 + cron 调整 + 两段式脚本）
- [x] Hermes Agent 映射已纳入文档
- [ ] 旧 README 已改为从属表述
- [ ] 主要旧文件已有对应归宿
- [ ] 迁移后不会让读者无法理解仓库结构

---

## 八、成本主线与 Hermes 样本占位

### 成本主线
当前 `framework/` v1 已含最弱形式的成本纪律：
- `OPERATING-RULES.md`：避免无谓扩张、及时收敛
- `PRE-FLIGHT-SEQUENCE.md`：前置检查，避免错误任务展开
- 本地 cron 调整：两段式脚本把模型 input tokens 压缩 90% 以上

但尚未把成本作为独立框架文件全面展开。

**后续整合方案**（二选一，待决策）：
- **方案 A**：在 `OPERATING-RULES.md` 中增设「控本」专章，把 token / 时间 / 调用限额规则写进去
- **方案 B**：新建 `framework/runtime/CONTEXT-BUDGET.md`（或 `COST-PLANE.md`），作为框架的独立控本文件
- `notes/cost-line.md` 作为输入素材，不直接升为主框架文件

### Hermes 运行时样本
- 已纳入 `framework/mapping/HERMES-MAPPING.md`
- 已补充到 `framework/mapping/OPENCLAW-MAPPING.md` 的「运行时样本层映射」与「智能体自配置参考」中
- 作用：为 OpenClaw runtime 器官建设提供可观察的外部参照，但 **不替代 FAO 的组织层讨论**

---

## 九、当前不做的事

- ❌ 暂不补完整 cost control plane（待方案 A/B 决策）
- ❌ 暂不补完整 orchestration / eval / tracing 平台
- ❌ 暂不直接删除旧目录
- ❌ 暂不把所有旧内容一次性改写进新框架
- ❌ 暂不修改旧 README 和说明文案（阶段 2 已部分启动，本轮继续推进）
- ❌ 暂不改动 `toolkit/minimal-core/`、`toolkit/governance/` 正文（阶段 3 待启动）
- ❌ **AGENTS.md / cron 调整 / scripts 的推送已另开分支处理**（PR #25 已关闭，待独立决策是否合并）

---

## 十、智能体可执行检查清单（本地阶段）

若未来由 agent 执行阶段 2/3，可按此清单推进：

```markdown
# Framework v1 迁移执行清单

## 阶段 2：README 级退位
- [ ] 修改 `README.md`，在显著位置声明 `framework/` 为上位骨架
- [ ] 修改 `toolkit/README.md`，声明 `minimal-core/` 和 `governance/` 为 legacy grouping
- [ ] 更新 `whitepaper/README.md` 中的框架入口说明
- [ ] 核对所有 README 中的链接是否可点击

## 阶段 3：内容级映射
- [ ] 在 `toolkit/minimal-core/soul.md` 头部添加legacy说明和指向 `SOUL.md`/`IDENTITY.md` 的链接
- [ ] 在 `toolkit/minimal-core/memory.md` 头部添加legacy说明和指向 `framework/continuity/MEMORY-INDEX.md` 的链接
- [ ] 在 `toolkit/minimal-core/heartbeat.md` 头部添加legacy说明和指向 `HEARTBEAT.md` 的链接
- [ ] 在 `toolkit/governance/TRUTH-CONTRACT-v1.md` 头部添加deprecated说明和指向 `framework/assurance/TRUTH-CONTRACT.md` 的链接
- [ ] 评估 `EXTERNAL-CALL-CHECKLIST.md` 内容，决定是否拆分到 `EXTERNAL-CALL-PROTOCOL.md` 或保留为 legacy
- [ ] 评估 `FAILURE-REPORT-CHECKLIST.md` 内容，决定是否拆分到 `FAILURE-PROTOCOL.md` 或保留为 legacy
- [ ] 更新 `toolkit/governance/templates/` 的 README，说明模板与新 `ROLE-CONTRACT.md` 的关系

## 阶段 4：成本主线决策
- [ ] 决策：控本规则进入 `OPERATING-RULES.md` 还是新建 `CONTEXT-BUDGET.md`
- [ ] 执行写入
- [ ] 更新映射文档中的相关引用

## 阶段 5：目录级替换（高风险，最后执行）
- [ ] 确认新骨架已稳定运行至少 2 周无结构回退
- [ ] 确认旧 README 退位说明已生效
- [ ] 确认旧文件头部 legacy 说明已覆盖 80% 以上内容
- [ ] 才考虑是否正式重命名/合并 `toolkit/` 子目录
```

---

## 十一、边界声明

- **本文是迁移计划，不是迁移执行日志**：本文定义"如何接管"，不记录已完成的迁移
- **本文不直接修改旧内容**：旧目录正文保持现状，修改待后续阶段执行
- **本文只定义"如何接管"，不直接完成接管**：具体接管动作按阶段逐步进行
- **本地变更（AGENTS.md / cron / scripts）已单独记录**：它们不属于 GitHub 上的 framework 迁移，而是云端节点的最小嫁接测试

---

*版本：v1.1*  
*性质：迁移计划*  
*生效状态：阶段 1 已完成，阶段 2 待启动（2026-04-10）*
