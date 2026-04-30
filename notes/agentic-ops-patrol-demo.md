# Agentic Ops Patrol Demo

> 这是 FAO 项目中的一个运行示范。
> 展示人类如何为智能体设定边界，智能体如何按边界执行巡检，并通过 truth-state / source audit 进行降级和收口。
> 它不是云端节点完整运行配置，也不是所有本地 skills / memory / quarantine 的公开副本。

---

## 一、这是什么

FAO 主张：能力可以下放，但边界和责任不能消失。

这个巡逻示范体现了这一原则在具体运行中的落地方式：

- **人类设定边界**（什么能做、什么不能做、什么时候必须停下来报告）
- **智能体在边界内执行**（按模板巡检、按格式输出、不越线）
- **发现越线时降级收口**（truth-state 标注、source audit、等待人工确认）

这不是自动化自治。这是**边界约束下的受控协作**。

---

## 二、一内一外两个巡检

### 2.1 fao-internal-patrol（内部巡检）

**目的**：检查根目录、memory、notes、archives、scripts、skills、cron/task 是否出现增殖、漂移或伪完成。

**输出原则**：
- 只写薄摘要，不写完整长表格
- 标注 truth-state（已验证 / 推断 / 未确认 / 失败）
- 发现异常时立即报告，不自动修复

**红线**：
- 禁止自动修改 `whitepaper/`
- 禁止自动修改 `framework/`
- 禁止自动发起 PR
- 禁止自动 merge
- 禁止自动修复任何文件
- 禁止修改 `memory/`（本地运行时目录，不在 git 跟踪中）

### 2.2 fao-external-variable-patrol（外部变量巡检）

**目的**：观察外部 agent runtime / memory / governance 变量是否冲击 FAO 假设。

**输出位置**：`notes/external-variable-patrol.md`

**限制**：
- max 3 hits（最多记录 3 条外部变量）
- 每条必须标注来源、可信度、对 FAO 的影响程度
- 必须 source audit / truth-state 降级

**红线**：
- 禁止把新闻当结论
- 禁止把模型记忆当事实
- 禁止把框架推断当事实
- 禁止未经 source audit 就把外部发现写入 `whitepaper/`

---

## 三、协作分工

### Human

- **defines boundaries**：设定什么能做、什么不能做、什么时候停下来
- **approves activation**：决定是否启动某个周期任务或巡检
- **decides whether findings enter whitepaper/framework**：外部发现是否进入主文，由人类判断
- **stops or freezes tasks when they drift**：当任务出现漂移、增殖、伪完成时，人类负责叫停

### Agent

- **executes patrol**：按模板执行巡检
- **labels truth-state**：所有输出必须标注验证状态
- **writes bounded summaries**：只写薄摘要，不写完整长报告
- **stops when red lines are reached**：碰到红线立即停止，报告人类，不擅自继续

---

## 四、为什么不公开完整云端配置

云端节点包含大量本地运行时内容：

- **skills registry**：本地技能清单，含敏感能力描述（浏览器控制、消息发送等）
- **quarantine notes**：隔离记录，含本地路径和第三方项目信息
- **runtime memory**：运行时的记忆日志、中间状态
- **local tool experiments**：实验脚本、测试代码、个人笔记

这些内容：
- 对公共项目读者无必要
- 可能包含环境路径、运行痕迹或误导性上下文
- 暴露攻击面或制造误解

**公共仓库只保留可说明 FAO 方法的最小示范。**

云端节点本地治理记录应保存在 `~/.openclaw/` 本地文件系统中，不进入公共仓库。

---

## 五、结论

这个示范体现 FAO 的核心原则：

> **能力可以下放，但边界和责任不能消失。**

周期任务不是自动自治，而是边界约束下的受控协作。

- 智能体可以执行巡检，但不能决定巡检结果是否进入主文
- 智能体可以发现问题，但不能自行修复 whitepaper 或 framework
- 智能体可以提出建议，但不能在没有 source audit 的情况下把外部变量当成事实写入项目资产

这就是 "agentic ops patrol" 的含义：**不是自动运行，而是有边界的协作运行。**

---

*本文件属于 FAO 公开项目资产，展示方法而非配置。*
