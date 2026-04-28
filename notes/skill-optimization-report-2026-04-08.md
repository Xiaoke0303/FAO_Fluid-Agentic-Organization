# 技能生态优化报告

**日期**: 2026-04-08  
**执行**: 配置清理 + 冲突解决 + 策略文档化

---

## 一、已执行优化

### 0. Cron 任务超时根因修复 ⭐

**问题**: `memory-tree-indexer` 等 cron 任务频繁超时

**根因**: 
- Cron payload 设置了 `timeoutSeconds: 300` (5分钟)
- 但 `agents.defaults.timeoutSeconds` **未设置** (默认60秒)
- Isolated session 继承默认值，任务64秒就被截断

**修复**: 添加 `"timeoutSeconds": 300` 到 `agents.defaults`

**验证**: 
```
lastDurationMs: 64122  ← 超时前实际运行64秒
cron limit: 300000ms    ← 从未达到
agent limit: 60000ms    ← 实际限制 ← 已修复为300s
```

### 1. plugins.allow 清理

**移除的假条目**:
- `version` ❌
- `doctor` ❌
- `gateway` ❌
- `plugins` ❌
- `skills` ❌

**清理后**: 25 个有效插件条目

### 2. 冲突插件处理

| 插件 | 状态 | 原因 |
|------|------|------|
| `openclaw-lark` | ⛔ 禁用 | 与内置 `feishu` 冲突 |
| `openclaw-weixin` | ⛔ 禁用 | SDK 版本不兼容 |

### 3. 搜索工具分层策略

新增 `searchStrategy` 配置，明确三层分工:

```
┌─────────────────┬─────────────────────┬──────────┐
│ 工具            │ 使用场景            │ 优先级   │
├─────────────────┼─────────────────────┼──────────┤
│ kimi_search     │ 中文搜索、日常信息  │ 1        │
│ web_search      │ 英文实时            │ 2        │
│ exa             │ 深度研究、学术内容  │ 3        │
└─────────────────┴─────────────────────┴──────────┘
```

---

## 二、剩余建议

### 中期优化
1. **IM 通道精简**: 当前启用 20+ 通道，建议只保留实际使用的
2. **技能懒加载**: 视频生成等低频技能改为按需触发
3. **Token 优化**: 参考 SoulClaw 的分层 bootstrap 策略

### 待观察
- `exa` API Key 已配置，但实际调用需测试
- 如 `web_search` 不常用，可移除 Brave 依赖

---

## 三、配置变更摘要

```diff
plugins.allow:
- "version", "doctor", "gateway", "plugins", "skills"
- "openclaw-lark" (moved to disabled)
- "openclaw-weixin" (moved to disabled)
+ "exa" (added to allow list)

plugins.entries:
+ openclaw-lark.enabled: false
+ openclaw-weixin.enabled: false
+ _note: 禁用原因说明

全局新增:
+ searchStrategy: 分层策略文档
```

---

*配置已生效，无需重启。*
