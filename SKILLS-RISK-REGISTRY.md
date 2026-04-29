# Skills Risk Registry

> Generated: 2026-04-29
> Purpose: P1-4b skills governance — risk marking, not capability deletion

---

## 1. High-Risk Skills — Explicit-Approval-Only

以下 skills 具备高权限能力，触发前必须人工确认。

| Skill | Source | Risk Category | Required Approval |
|-------|--------|---------------|-------------------|
| web-access | workspace | Browser CDP control, login-state access, DOM manipulation, screenshot | 明确指令 + 目标 URL 确认 |
| browser-relay | workspace | HTTP relay to local Chromium, JS eval, cookie/localStorage access, Telegram screenshot | 明确指令 + 目标站点确认 |
| xiaohongshu | workspace | Social automation: post, comment, like, collect | 明确指令 + 内容审核 |
| tmux | bundled | Shell execution via terminal multiplexer | 明确指令 + 命令范围确认 |
| wecom-msg | extra | Enterprise WeChat message send | 明确指令 + 接收人确认 |
| kimiim-cli | workspace | Kimi group chat ops, @mentions, message send | 明确指令 + 群/人确认 |
| feishu-doc | extra | Feishu doc create/modify | 明确指令 + 文档范围确认 |
| feishu-update-doc | extra | Feishu doc edit/overwrite | 明确指令 + 文档范围确认 |
| feishu-create-doc | extra | Feishu doc creation | 明确指令 + 位置确认 |
| feishu-bitable | extra | Feishu bitable record CRUD | 明确指令 + 表/记录确认 |

### Risk Detail by Category

**浏览器控制（Browser Control）**
- web-access: CDP 直连用户 Chrome，可访问所有已登录站点，提取任意数据
- browser-relay: HTTP relay 到本地 Chromium，绕过反爬，可 eval JS

**登录态访问（Login-State Access）**
- web-access: 复用用户 Chrome 的 cookies、localStorage、sessionStorage
- browser-relay: 可读取 document.cookie、localStorage

**Shell 执行（Shell Execution）**
- tmux: 终端复用器，可 spawn 任意 shell 进程

**社交平台发布/评论/点赞（Social Automation）**
- xiaohongshu: 发帖、评论、回复、点赞、收藏

**文档创建/修改（Document Write）**
- feishu-doc, feishu-update-doc, feishu-create-doc: 飞书文档增删改
- feishu-bitable: 多维表格记录增删改查

**消息发送（Message Send）**
- wecom-msg: 企业微信消息主动发送
- kimiim-cli: Kimi 群聊消息发送与 @mentions

**凭据/Token 风险（Credential Risk）**
- web-access: 可读取浏览器中存储的凭据
- browser-relay: 读取 /tmp/browser-relay-token
- xiaohongshu: 需小红书登录态
- feishu-*, wecom-*: 需对应平台 OAuth/App 凭据

---

## 2. High-Risk Skills Not Yet Resolved

以下 skills 本轮客观存在 high-risk，但未显式标记为 explicit-approval-only，也未 freeze。等待后续人工审查。

| Skill | Source | Status | Risk | Action | Note |
|-------|--------|--------|------|--------|------|
| node-connect | bundled | active | 节点连接 / 外部连通性 | pending review | 本轮未修改 |
| wecom-preflight | extra | active | 企业微信连接验证 / 凭据邻近操作 | pending review | 本轮未修改 |

---

## 3. Frozen Skills (P1-4b)

| Skill | Source | Freeze Reason | Recovery Path |
|-------|--------|---------------|---------------|
| ad-creative | managed | Marketing skill, not FAO core | `mv ~/.openclaw/skills/frozen/ad-creative ~/.openclaw/skills/` |
| campaign-plan | managed | Marketing skill, not FAO core | same |
| channels-setup | managed | Marketing skill, not FAO core | same |
| churn-prevention | managed | Marketing skill, not FAO core | same |
| content-research-writer | managed | Marketing skill, not FAO core | same |
| copy-editing | managed | Marketing skill, not FAO core | same |
| copywriting | managed | Marketing skill, not FAO core | same |
| daily-report | managed | Marketing skill, not FAO core | same |
| humanizer-zh | managed | Marketing skill, not FAO core | same |
| legal-risk-assessment | managed | Marketing skill, not FAO core | same |
| md-to-pdf | managed | Marketing skill, not FAO core | same |
| pricing-strategy | managed | Marketing skill, not FAO core | same |
| process-doc | managed | Marketing skill, not FAO core | same |
| saas-metrics-coach | managed | Marketing skill, not FAO core | same |
| scientific-problem-selection | managed | Marketing skill, not FAO core | same |
| seo-audit | managed | Marketing skill, not FAO core | same |
| stock-assistant | managed | Marketing skill, not FAO core | same |
| theme-factory | managed | Marketing skill, not FAO core | same |
| searxng-bangs | workspace | Duplicate search with tavily-search-pro | `mv /root/.openclaw/workspace/skills/frozen/searxng-bangs /root/.openclaw/workspace/skills/` |

---

## 4. Present but Unregistered Skills

| Skill | Location | Status | Note |
|-------|----------|--------|------|
| time-awareness | `skills/time-awareness/` | Present, unregistered | Low-risk, useful — needs registration review |
| worker-safety | `skills/worker-safety/` | Present, unregistered | Safety reference skill — needs registration review |

---

## 5. Quarantined — claude-mem/

**Status**: `quarantined`
**Location**: `~/.openclaw/quarantine/claude-mem-2026-04-29/claude-mem/`
**Date**: 2026-04-29

### 隔离原因

- 非 OpenClaw skill：无 SKILL.md
- 大型第三方项目：101M，含 .git、完整 Node.js 项目结构
- installer (`openclaw/install.sh`) 可能修改 OpenClaw gateway 配置
- installer 可能从远程 (`install.cmem.ai`) 下载脚本
- 可能需要 AI provider API key
- 与当前 FAO 薄记忆原则存在冲突

### 当前状态

- `quarantined`
- `not loaded`
- `not registered`
- `not executed`
- `not installed`

### 恢复条件

- 需要人工安全审查
- 需要确认来源（github.com/thedotmack/claude-mem）
- 需要确认不会修改 gateway 配置
- 需要确认不会读取/使用现有凭据
- 需要确认与 FAO memory-line 不冲突

### 原路径记录

原路径：`skills/claude-mem/`

---

---

## 6. Moved Non-Skill Directory — pua/

| Item | Detail |
|------|--------|
| Original path | `skills/pua/` |
| New path | `archives/non-skill-projects/pua/` |
| Reason | Not an OpenClaw skill; contains landing.html, plugin.json, .git — appears to be a standalone project |
| Status | Archived, not loaded, not registered, not executed |

---

## 7. Active Skills Count Change

| Metric | Before | After |
|--------|--------|-------|
| Total registered | 116 | 97 |
| Active skills | 72 | 53 |
| High-risk active | 11 | 11 |
| Medium-risk active | 33 | 32 |
| Low-risk active | 28 | 10 |

*(Note: 18 managed low-risk skills frozen. searxng-bangs (medium-risk) frozen. High-risk count unchanged.)*

---

*Registry maintained by FAO skills governance process. Update on each P1-4b iteration.*
