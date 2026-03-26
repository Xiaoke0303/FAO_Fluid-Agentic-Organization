# 记忆变更日志

记录 memory 文件的重要变更。

## 2025-03-26

- 薄化修剪 P0 执行：
  - 冻结 memory-tree-decayer（enabled: false）
  - 删除 memory-tree-cleaner（合并入 indexer）
  - indexer 降频：每2小时 → 每天1次（凌晨4点）
  - sync 降频：每天 → 每周一 23:00（与 patrol 同一天）
- 记忆维护任务从 4 个减至 2 个（indexer + sync），decayer 冻结

## 2025-03-26

- 薄化修剪 P0 执行：
  - 冻结 memory-tree-decayer（enabled: false）
  - 删除 memory-tree-cleaner（合并入 indexer）
  - indexer 降频：每2小时 → 每天1次（凌晨4点）
  - sync 降频：每天 → 每周一 23:00（与 patrol 同一天）
- 记忆维护任务从 4 个减至 2 个（indexer + sync），decayer 冻结
- 冻结 tachikoma-sync（enabled: false）
  - 原因：当前定义与实际作用错位（单线自我描述 vs 声称跨线同步）
  - 状态：待重定义旧任务，不设计替代方案

## 2025-03-25

- 创建 MEMORY.md 主入口
- 创建本变更日志
- 创建 incubation.md
- 添加 2026-03-25-consensus.md

## 2025-03-24

- 初始化 memory 目录
- 添加 2026-03-24.md 开发日志
- 添加 external-observation.md
