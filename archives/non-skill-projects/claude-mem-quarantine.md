# claude-mem Quarantine Record

## 原路径

`skills/claude-mem/`

## 新路径

`~/.openclaw/quarantine/claude-mem-2026-04-29/claude-mem/`

## 隔离日期

2026-04-29

## 隔离原因

- 非 OpenClaw skill：无 SKILL.md
- 大型第三方项目：101M，含 .git、完整 Node.js 项目结构
- installer（`openclaw/install.sh`）可能修改 OpenClaw gateway 配置
- installer 可能从远程（`install.cmem.ai`）下载脚本
- 可能需要 AI provider API key
- 与当前 FAO 薄记忆原则存在冲突

## 当前状态

- `quarantined`
- `not loaded`
- `not registered`
- `not executed`
- `not installed`

## 恢复条件

- 需要人工安全审查
- 需要确认来源（github.com/thedotmack/claude-mem）
- 需要确认不会修改 gateway 配置
- 需要确认不会读取/使用现有凭据
- 需要确认与 FAO memory-line 不冲突

## 执行记录

- 操作人：FAO skills governance (P1-4c)
- 操作方式：mv 移出 skills/ 目录，不运行任何脚本
- 不提交 claude-mem 内容到仓库（101M 第三方项目）

---

*此文件仅记录隔离事实，不包含 claude-mem 的任何代码或凭据。*
