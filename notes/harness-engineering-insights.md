# Harness Engineering 对 FAO 的启发

## 现在吸收什么，后续工程化什么

---

## 一、文档定位

本文是两篇外部文章对 FAO 的综合启发笔记。

它不是 framework 正文，不是白皮书正式章节，也不是某个平台的部署手册。

目标是区分：哪些启发现在就该吸收，哪些应留到后续工程化阶段。

---

## 二、两篇文章分别提供了什么

### A. Agent Harness Survey 提供了什么

- **harness 是绑定约束**：不是可选装饰，而是运行时的治理基础设施
- **外部坐标系**：survey 的六部件（Persona/Runtime/Session/MCP/Eval/Tracing）可作为理解 OpenClaw 等平台的参考框架
- **但不应直接替代 FAO 骨架**：survey 描述的是平台能力清单，FAO 需要保持自己的组织分析语言

### B. 8Lee《From Makefiles to Agentic Skills》提供了什么

- **Thin Harness, Fat Skills**：18 个 AI 编排 skills、12 个共享 bash 库、7 个 pre-tool hooks，全部从本地一条命令触发
- **Repo 作为唯一真相源**：AGENTS.md（600+ 行规则）、version.json、privileged-action-surface-baseline.txt 全部入仓
- **Enforcement beats instruction**：用 pre-tool hooks 让危险操作物理上无法执行，而非仅文档提醒
- **运行时约束比纯文档约束更进一步**：这是 8Lee 比 FAO 当前状态多走的那半步

---

## 三、现在就该吸收的 5 点

### 1. 保持 framework 薄，厚内容留给 skills / domain packs / judgment material

当前 framework/ 下的 UNIVERSAL-WORK-NODE-FRAMEWORK.md、META-ACTIONS.md、ROLE-CONTRACT.md 已经够薄。

后续新增内容优先往 skills/、domains/、judgment-cards/ 放，不要膨化 framework 主骨架。

### 2. Repo 继续作为唯一真相源，agent 看不到的等于不存在

AGENTS.md、MEMORY.md、USER.md 等注入文件已在仓库内。

新增约束或背景信息继续以文件形式入仓，不走外部 wiki 或 Notion。

### 3. Mapping 只做翻译层，不再加新骨架

OPENCLAW-MAPPING.md、HERMES-MAPPING.md 已完成最小翻译。

不再基于 survey 六部件创建 FAO 新分类法，mapping 保持现状即可。

### 4. 前置检查优先，避免把 2 秒能发现的问题拖进 10 分钟执行

Task admission check（任务准入检查）已在 AGENTS.md 落地。

后续新增复杂任务时，继续保持"先轻量验证、再进入执行"的习惯。

### 5. 文档约束已经有价值，但当前阶段先不急着代码化

8Lee 的 pre-tool hooks 是运行时工程化样本。

FAO 当前以文档约束为主，代码化约束（如拦截危险命令）留到后续阶段。

---

## 四、后续工程化再处理的 5 点

以下方向已识别，但当前不落地，留作后续工程化参考：

### 1. Pre-tool hooks / hard guards / fail-closed

8Lee 用 5 行 bash 拦截 `codesign --deep`、`rm -rf` 等危险操作。

FAO 后续可考虑为关键工具调用增加类似硬拦截，但当前阶段以文档约束为主。

### 2. Fragility-calibrated constraint（不同任务不同治理深度）

8Lee 的 Skill Taxonomy：Hard-Gated Pipeline（签名发布）vs Simple Automation（lint）。

FAO 后续可考虑为任务增加"脆弱性标签"，让调用方声明治理深度，而非一刀切。

### 3. Progressive disclosure / 分层加载

8Lee 的 SKILL.md 分 L1/L2/L3，智能体只加载当前阶段需要的 reference。

FAO 后续可考虑将长文档（如 META-ACTIONS.md）拆成按需加载的片段，减少常驻上下文。

### 4. Triple verification

8Lee 的三层验证：Script verification（产物）+ Agent verification（决策）+ Eval verification（JSONL）。

FAO 当前有文档约束，后续可补全 script verification 和机器可读的 eval verification。

### 5. Append-only telemetry / JSONL

8Lee 用 JSONL 记录 phase_start、phase_end、gate、retry，崩溃时文件不损坏。

FAO 当前工作笔记用 markdown，后续对于机器消费的数据（如 cron 执行结果）可考虑 JSONL。

---

## 五、当前不做什么

- **当前不把 harness 六部件改写成 FAO 新骨架**：survey 是外部坐标系，不是 FAO 本体
- **当前不把 8Lee 的工程细节直接写进 framework**：pre-tool hooks、JSONL telemetry 是工程样本，不是当前阶段的必需结构
- **当前不把运行时 engineering 细节与白皮书组织主线混成一层**：白皮书保持组织分析语言，engineering 细节走 notes/ 或后续 toolkit/
- **当前不因为外部文章启发而打断迁移收尾**：framework v1、mapping 文档、最小嫁接已完成，不再新增结构性改动

---

## 六、最小收口

两篇文章都支持 FAO 继续走"薄骨架、厚技能、强约束"的方向。

- Survey 更像外部坐标系，帮助理解 runtime 基础设施
- 8Lee 更像工程样本，展示了"约束即代码"的下一步

当前先吸收原则（保持薄、前置检查、repo 为真相源），后续再吸收机制（hooks、分层加载、triple verification）。

本文作为 notes/ 保留即可，不直接改 framework。

---

*记录时间：2026-04-14*
