# Codex / Claude Code 映射文档

> **Truth-State**: mapping note only. no framework patch. no external re-check.  
> **Scope**: 单体映射 → 参见横向比较：`CROSS-RUNTIME-ADAPTER-MAP.md` / `RUNTIME-BACK-PRESSURE-REVIEW.md`

> 不是 Codex 产品手册。不是 FAO 主干概念。不是 governance 规则。

---

## Runtime Identity

**Codex** (OpenAI Codex) 是 professional coding agent：在本地 workspace 中执行代码编辑、终端命令、git 操作、issue/PR 协作的 execution collaborator。

**Claude Code** (Anthropic) 是同类 professional coding agent：同样基于本地 workspace，diff-first 工作流，commit 前强制人工确认，但无原生无人值守执行能力。

两者是**不同产品**，但共享同一 runtime 类别：professional workspace execution agent。本文以 Codex 为主映射对象，Claude Code 作为比较参考。

---

## Why It Matters to FAO

Codex 暴露的核心 governance 问题不是"代码写得好不好"，而是：

- **professional workspace responsibility**：workspace 中的每一次文件修改、git 提交、终端命令执行，都是对外部环境产生副作用的动作
- **diff / commit / PR 作为责任边界**：diff 是审查面，commit 是承诺面，push 是发布面，三者治理级别不同
- **execution collaborator 与 governance grammar 的互补**：Codex 强在本地执行纪律，弱在组织层面责任锚定；FAO 需要把后者的缺口补上

---

## FAO Mapping Table

| Codex capability | FAO concept | governance question | risk / open question |
|---|---|---|---|
| repo workspace | 本地工作空间 / local body | 谁对 workspace 中的修改承担最终责任？ | 修改已落盘，但责任未显式锚定 |
| file edit | 运行时动作 / runtime action | 文件编辑是否等于"已批准"？ | diff 审查不等于治理批准 |
| terminal / command execution | 副作用动作 / side-effect action | 命令执行是否有事前检查？ | 终端命令可能绕过 diff 纪律 |
| git diff / staged changes | 审查面 / review surface | 谁审查、审查什么标准？ | 只审代码差异，不审治理意图 |
| commit | 本地承诺动作 / local commitment | commit 是否构成对外承诺？ | 本地 commit 已改变仓库状态，是潜在承诺；但 commit 授权 ≠ push 授权 |
| push / PR | 发布动作 / external commitment | push 是否等于组织发布？ | 无显式 human checkpoint 前，push 是自动发布；push 应触发 External Write Gate |
| issue / external collaboration | 外部协作面 / external surface | 对外评论、issue 创建是否代表组织发言？ | 无签名责任机制 |
| instructions / AGENTS.md | 本地治理面 / local governance surface | 规则由谁写入、谁更新？ | 规则可保留，但责任不自动保留 |
| memory / project context | 工作上下文 / working context | 项目记忆如何被注入、如何被标注 truth-state？ | 注入 vs recall 未区分 |

---

## Responsibility Boundary Findings

| 动作 | 治理含义 | FAO 翻译 |
|---|---|---|
| **git diff** | 审查本地修改差异 | review surface；尚未构成承诺或发布 |
| **git commit** | 将修改写入本地仓库历史 | local commitment；每一次 commit 都是潜在的外部承诺，即使未 push；commit 授权 ≠ push 授权 |
| **git push** | 将修改发布到远程仓库 | external commitment / publication surface；push 是发布动作，不是草稿；应触发 External Write Gate；conditional push requires all stated conditions to be checked immediately before execution |
| **code edit** | 修改 workspace 文件 | 编辑已改变本地状态，是 retained capability 的实例 |
| **terminal command** | 执行 shell 命令 | 命令可能绕过 diff 审查，是 side-effect 高风险动作 |
| **instructions (AGENTS.md)** | 定义行为规则 | 规则是本地治理面，但规则本身不能替代责任锚定 |

> **Side-Effect Gradient**: diff / commit / push 是有助于理解副作用边界的动作梯度，但不是 conformance level 本身。不要把 diff=commit=push 直接映射成 L1/L2/L3。

> **Codex push gate status**: Codex 是否强制 gate push → [unverified]，除非 repo 中已有证据。

---

## Comparison Hooks

| 维度 | Codex | OpenClaw | Hermes | FAO framework |
|---|---|---|---|---|
| 执行面 | 本地 workspace 强 | 多通道消息 + 本地工具 | 六后端（本地到远程） | 不定义执行面 |
| 治理面 | 无显式组织层 | 无显式责任锚定 | 无显式 human checkpoint | 定义边界、责任、路由 |
| 自动化 | 交互式，无原生无人值守 | cron + 事件触发 | 内置 scheduler + 安全扫描 | 无人值守必须分级 |
| 记忆模型 | workspace 配置 + 会话上下文 | 文件注入 bootstrap | 三层记忆（持久/会话/程序） | 区分 recall 与 injection |
| 责任缺口 | push 无 human checkpoint | 外部承诺无显式检查 | 能力保留但责任不保留 | 需要补全 |

---

## Framework Back-Pressure

以下 Codex 暴露的问题属于 **candidate gap**，不提出 patch：

| candidate | 来源 | 为什么暂不补 |
|---|---|---|
| **professional workspace responsibility** | commit/push 无显式责任锚定 | 需 case line 验证（如保函 maker-checker） |
| **runtime action vs retained capability** | 文件编辑保留，但责任不保留 | 需多 runtime 交叉验证 |
| **external commitment surface** | push 等于发布，但无发布检查 | 需 case line 验证 |
| **local workspace / body boundary** | workspace 是本地身体，但边界未治理化 | 需远程/本地对比验证 |

---

## End State Declaration

- Codex 单体映射已补齐。
- Cross-runtime 比较仍由 `CROSS-RUNTIME-ADAPTER-MAP.md` 承担。
- 不修改 framework 主干。
- 不修改 whitepaper。
- 不新增 governance 模块。

**Codex Runtime Conformance**: L0 Documented [verified]；L1–L5 [unverified]（无 runtime-specific 探针/负向测试证据）。

**Codex External Write Gate**: diff/commit/push 副作用梯度已映射，但 Codex 是否强制 gate push → [unverified]。

---

*版本：v1.0 | 基于 2026-06-09 CROSS-RUNTIME-ADAPTER-MAP.md 反向压力*
