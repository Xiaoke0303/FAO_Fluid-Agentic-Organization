# 薄化修剪执行记录（P0）

2025-03-26

## 执行内容

本次薄化修剪直接修改了运行时 cron 配置，现补录到仓库：

| 任务 | 操作 | 原状态 | 新状态 |
|------|------|--------|--------|
| memory-tree-decayer | 冻结 | enabled | **disabled** |
| memory-tree-cleaner | 删除 | 存在 | **已移除** |
| memory-tree-indexer | 降频 | 每2小时 | **每天04:00** |
| tachikoma-sync | 降频→冻结 | 每天→每周→ | **disabled** |

## 修剪原则

- 不动 toolkit（minimal-core/governance）
- 不新增理论
- 只停/降频，不重命名改造
- 记录变更，不宏大总结

## 当前有效任务（修剪后）

- github-fao-patrol（每周一 09:00）
- memory-tree-indexer（每天 04:00）
- reality-check-review（每周三 10:00）

其余记忆维护任务已冻结或删除。
