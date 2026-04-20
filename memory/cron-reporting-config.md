# 周期任务汇报机制配置
# 生效日期: 2026-04-17
# 更新时间: 2026-04-20 - 分离内部巡检与外部观察任务

## 任务分类与边界

| 任务类别 | 任务名称 | 关注对象 | 输出模板 |
|---------|---------|---------|---------|
| **内部仓库巡检** | github-fao-patrol | 本仓库 PR/Issue/Branch | `templates/fao-repo-patrol-template.md` |
| **外部项目观察** | hermes-agent-observer | NousResearch/Hermes 动态 | `templates/external-observation-template.md` (预留) |
| **外部项目观察** | openclaw-external-observer | OpenClaw 社区动态 | `templates/external-observation-template.md` (预留) |

**关键区分**:
- 内部巡检关注：文件变更、框架一致性、合并决策
- 外部观察关注：社区讨论、思想邻近性、参与决策
- 两者输出格式、语言风格、决策目标完全不同

## 任务列表与推送策略

| 任务名称 | 执行时间 | 推送目标 | 决策模式 |
|---------|---------|---------|---------|
| **zhuangzi-daily** | 每日 23:00 | 飞书频道 **ThierryK** | 自动发送（庄子学习内容） |
| **github-fao-patrol** | 周一/三/五 08:25 | 原通道 (kimi-claw) | **需决策时推送** |
| **hermes-agent-observer** | 每日 15:30 | 静默记录 → `memory/hermes-observation.md` | 静默 |
| **openclaw-external-observer** | 每日 05:10 | 静默记录 → `memory/external-observation.md` | 静默 |
| **memory-tree-indexer** | 每12小时 | 静默记录 → 内部日志 | 静默 |
| **reality-check-review** | 每日 02:00 | 静默记录 → 内部日志 | 静默 |

## 内部巡检任务硬规则 (github-fao-patrol)

1. **没读 diff，不得给合并建议**
   - 仅看标题/body 时，唯一允许输出：`fail-closed：信息不足，待读 diff 后重评`

2. **信息不足时必须 fail-closed**
   - 禁止："信息不足，但建议暂缓"
   - 必须："信息不足，fail-closed，下一步动作：获取 X 信息后重评"

3. **不输出与决策无关的信息**
   - 禁止："活跃度平稳"、"总体健康度良好"、"值得关注"（无动作）

## 触发主动推送的例外情况

即使配置为静默的任务，以下情况仍会主动推送：

1. **发现需要决策的事项**
   - PR 合并建议
   - 架构变更讨论
   - 重大风险预警

2. **执行失败超过阈值**
   - 连续 3 次失败
   - 关键文件写入失败

3. **用户明确要求的观察项**
   - 特定 issue/PR 跟踪
   - 特定关键词命中

## 静默记录位置

| 任务 | 记录文件 |
|------|---------|
| hermes-agent-observer | `memory/hermes-observation.md` |
| openclaw-external-observer | `memory/external-observation.md` |
| memory-tree-indexer | 内部状态，不生成文件 |
| zhuangzi-daily | `memory/zhuangzi-daily.md` + 飞书推送 |
| github-fao-patrol | 同时推送 + 内部记录 |

## 查看静默记录的方式

1. 直接读取记忆文件：
   ```
   read memory/external-observation.md
   read memory/hermes-observation.md
   read memory/zhuangzi-daily.md
   ```

2. 询问我查看最近记录：
   - "看看最近的外部观察记录"
   - "查看记忆盘点结果"

---
*配置更新: 2026-04-20*
*变更: 分离内部巡检与外部观察任务，添加硬规则*
