# AI Agent 排行榜前5名分析

## 数据来源
本月 Global Ranking（基于 token 消耗/使用量）

| 排名 | 产品 | 使用量 | 类别 |
|-----|------|--------|------|
| 1 | OpenClaw | 20.5T | Personal Agents |
| 2 | Kilo Code | 6.3T | CLI Agents, IDE Extensions |
| 3 | Claude Code | 3.47T | CLI Agents |
| 4 | Cline | 1.63T | IDE Extensions, CLI Agents |
| 5 | Hermes Agent | 1.59T | CLI Agents, Personal Agents |

---

## 各产品核心定位

### 1. OpenClaw (20.5T)
- **定位**：通用型 Personal Agent 基础设施
- **特点**：
  - 开源框架，支持自托管
  - 多平台集成（Telegram, Discord, Slack, 飞书等）
  - Skills 系统，可扩展能力
  - 强调用户数据主权和隐私
- **优势**：生态开放，社区活跃，使用量遥遥领先
- **适用**：希望拥有自己 AI 助手的个人和团队

### 2. Kilo Code (6.3T)
- **定位**：开源 AI 编程助手（OpenClaw 驱动）
- **特点**：
  - 基于 OpenClaw 构建
  - 支持 VS Code, JetBrains, CLI
  - 6 种 Agent 模式（Code/Architect/Debug/Ask/Custom等）
  - 支持 500+ 模型
- **优势**：IDE 集成深度好，多模式适配不同场景
- **适用**：开发者日常编码辅助

### 3. Claude Code (3.47T)
- **定位**：Anthropic 官方终端编码工具
- **特点**：
  - 官方出品，与 Claude 模型深度集成
  - 终端原生体验
  - 代码库理解能力强
  - 支持 GitHub @claude 标签调用
- **优势**：官方支持，模型能力顶尖
- **适用**：重视代码质量和安全的企业开发者

### 4. Cline (1.63T)
- **定位**：VS Code 自主编码 Agent
- **特点**：
  - IDE 插件形态
  - Human-in-the-loop 设计（每步需确认）
  - 支持浏览器操作（截图、点击、调试）
  - MCP 协议支持，可扩展工具
- **优势**：IDE 内无缝体验，安全性高（人工确认）
  - 60k+ GitHub stars，社区活跃
- **适用**：VS Code 用户，重视安全控制

### 5. Hermes Agent (1.59T)
- **定位**：自改进型 AI Agent（Nous Research）
- **特点**：
  - 内置学习循环（Learning Loop）
  - 自动创建和改进 skills
  - 跨平台（Telegram, Discord, Slack, WhatsApp, Signal）
  - 支持从 OpenClaw 迁移
- **优势**：真正的"自改进"能力，程序性记忆
- **适用**：研究者、高级用户，希望 Agent 能持续进化

---

## 关键对比维度

### 产品形态
| 产品 | 形态 | 部署方式 |
|-----|------|---------|
| OpenClaw | 框架/平台 | 自托管 |
| Kilo Code | IDE 插件 + CLI | 本地/云端 |
| Claude Code | CLI | 本地 |
| Cline | IDE 插件 | 本地 |
| Hermes Agent | CLI + Gateway | 本地/云端/VPS |

### 核心差异

**OpenClaw vs 其他**
- OpenClaw 是基础设施，其他多基于类似理念构建
- Kilo Code 明确基于 OpenClaw
- Hermes Agent 提供 OpenClaw 迁移工具

**IDE 集成度**
- Cline: ★★★★★（VS Code 深度集成）
- Kilo Code: ★★★★☆（VS Code + JetBrains）
- Claude Code: ★★☆☆☆（CLI 为主）
- Hermes: ★★☆☆☆（CLI + 消息平台）

**自主性**
- Hermes: ★★★★★（自改进学习循环）
- Cline: ★★★☆☆（需人工确认每步）
- Claude Code: ★★★☆☆（高能力但需指导）
- Kilo Code: ★★★☆☆（多模式可选）

**开放性**
- OpenClaw: ★★★★★（完全开源，自托管）
- Hermes: ★★★★★（MIT 开源）
- Cline: ★★★★★（Apache-2.0）
- Kilo Code: ★★★★☆（开源但依赖 OpenClaw 生态）
- Claude Code: ★★☆☆☆（闭源，Anthropic 官方）

---

## 对 FAO 的启发

### 1. 分层架构是趋势
- **基础设施层**：OpenClaw 提供通用能力
- **垂直应用层**：Kilo Code、Cline 在特定场景（编码）深度优化
- **用户选择**：根据需求选择不同层级的产品

### 2. 学习循环是差异化关键
- Hermes Agent 的"自改进"定位让它在拥挤的 Agent 市场有独特价值
- FAO 框架可考虑如何支持"持续学习"和"程序性记忆"

### 3. 人机协作模式多样
- Cline 的 Human-in-the-loop 适合高风险场景
- Claude Code 的自主执行适合高效率需求
- FAO 的 Role-Contract 可定义不同协作模式

### 4. 迁移能力降低切换成本
- Hermes 提供 OpenClaw 迁移工具，平滑用户过渡
- FAO 框架设计时应考虑与其他系统的互操作性

---

## 结论

**市场格局**：
- OpenClaw 作为基础设施领先（20.5T）
- 编码场景是 Agent 最成熟的应用（Kilo、Claude、Cline 合计 11.4T）
- 自改进 Agent（Hermes）代表下一个演进方向

**FAO 启示**：
1. 明确分层：基础设施 vs 垂直应用
2. 支持学习循环：程序性记忆、技能进化
3. 定义协作模式：从 fully autonomous 到 human-in-the-loop
4. 保持开放：支持迁移、互操作、多平台

---

*分析时间：2026-04-14*
*数据来源：Global Ranking This Month*
