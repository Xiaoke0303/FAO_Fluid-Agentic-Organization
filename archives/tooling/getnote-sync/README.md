# GetNote Sync — 历史工具

> 已归档，当前不是默认运行路径。

---

## 文件说明

| 文件 | 用途 |
|------|------|
| `GETNOTE_SYNC.md` | 使用文档 |
| `getnote_sync.py` | 同步脚本主体 |
| `sync_getnote.sh` | 启动包装脚本 |

---

## 当前状态

- **失效**：`getnote_sync.py` 第 17 行 `from memory_system import MemorySystem`
- `memory_system.py` 已归档至 `archives/memory-experiments/`
- 当前运行会触发 ImportError

---

## 如需恢复

1. 人工确认是否需要 GetNote 同步功能
2. 评估是否重构为不依赖 `memory_system.py` 的实现
3. 如需恢复 `memory_system.py`，必须先评估与薄记忆原则的兼容性
4. 禁止自动加载、禁止作为默认技能

---

*历史工具痕迹。不代表当前立场。*
