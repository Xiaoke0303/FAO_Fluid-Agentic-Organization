# FAO Cross-Runtime Adapter Map

> **Truth-State**: analysis only. based on OpenClaw, Hermes, Codex / Claude Code public documentation. no external re-check performed unless explicitly stated. no framework patch implied.

---

## Purpose

本文把 OpenClaw、Hermes、Codex / Claude Code 三类运行体作为 FAO 框架的外部 runtime 样本，做横向对比，提炼共享治理压力点。

不是 runtime 选购指南。不是产品评测。不是 governance 规则。

---

## Three Runtime Families

### OpenClaw: open local runtime / 本地开放运行体

- 开源网关架构，本地 VM 运行
- 文件系统直接注入 bootstrap context（AGENTS.md, SOUL.md, MEMORY.md 等）
- 支持多通道（Telegram, Discord, Signal, Slack 等）
- 工具由插件系统提供，技能由 skills 目录管理
- 无人值守执行通过 cron 任务触发

### Hermes: skill-memory loop runtime / 技能记忆闭环运行体

- 六部件架构：Execution loop, Tool registry, Context manager, State store, Lifecycle hooks, Evaluation interface
- 程序化记忆（skills）与持久化记忆（MEMORY.md / USER.md）分离
- 支持技能自创建、持久化、版本化
- 内置 scheduler 与 gateway 支持无人值守
- 支持 local / Docker / SSH / Modal / Daytona 六种执行后端

### Codex / Claude Code: professional coding agent / 专业编程智能体

- 本地 workspace 直接操作，diff-first 工作流
- 区分 staged / unstaged / untracked，commit 前强制人工确认
- 不执行未经 diff 审查的写入
- 单智能体模式，无原生多智能体编排
- 能力通过 workspace 配置保留，但责任边界由 IDE 插件隐式管理

---

## Comparison Table

| runtime family | primary capability | state / memory model | execution surface | automation model | FAO mapping target | governance risk |
|---|---|---|---|---|---|---|
| OpenClaw | 多通道消息网关 + 本地工具链 | 文件注入 bootstrap + 会话上下文 | 本地 VM + 插件系统 | cron + 事件触发 | 多通道 agent runtime | 无人值守执行缺乏分级；外部承诺无显式检查 |
| Hermes | 技能自创建 + 记忆持久化 | 长期记忆 / 会话搜索 / 程序化记忆（三层） | 六后端（本地到远程） | 内置 scheduler + 安全扫描 | 技能-记忆闭环 runtime | 能力自动保留，责任不自动保留；远程执行后端扩大边界 |
| Codex / Claude Code | 代码生成 + 本地 workspace 操作 | workspace 配置 + 会话上下文 + 文件系统状态 | 本地 IDE / 终端 | 交互式，无原生无人值守 | 专业编程智能体 | 本地 diff 纪律强，但对外 push / PR 无显式责任边界 |

---

## Shared Governance Pressure Points

| 压力点 | 表现 | FAO 翻译 |
|---|---|---|
| **retained capability / skill retention** | 技能或配置在会话间保留，但责任边界不保留 | 能力可以保留，责任不能自动保留 |
| **unattended execution / cron** | 调度器自动触发任务，人类不在场 | 无人值守执行必须分级，高风险动作必须有 human checkpoint |
| **external commitment surface** | 消息发送、git commit / push、PR 创建、外部 API 写入 | 每一次外部输出都是潜在承诺，runtime 不区分草稿与发布 |
| **memory injection vs recall** | 系统注入的上下文被当作记忆，而非重新上下文化 | 注入是 re-contextualization，不是 retrieval；必须标注 truth-state |
| **local body / remote host / workspace boundary** | 执行环境从本地扩展到远程 Docker / SSH / Modal / Daytona | 身体边界决定威胁面；边界扩张必须伴随 governance 扩张 |
| **subagent delegation and verification** | 子代理或并行工作流执行后，父节点负责验证 | 父节点始终承担验证责任；verification 机制往往 underspecified |

---

## Mapping Layer Position

- **framework** 定义 governance grammar：边界、责任、路由、验证。
- **mapping** 把 heterogeneous runtimes 翻译成该 grammar。
- **mapping 不应回流 framework 主干**。runtime 的产品细节不是 governance 概念。
- 只有经过至少 3 个独立 runtime 验证 + 1 个 case line 吸收后，mapping 结论才考虑进入 framework 主干。

---

## End State Declaration

本文不修改 framework。不修改 whitepaper。不新增理论。

如需更新，应在 framework/mapping/ 内完成，不合并回 framework/core/ 或 framework/runtime/。

---

*版本：v1.0 | 基于 2026-06-08 映射草稿归拢*
