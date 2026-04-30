# Archives

> 历史归档区。只保留对 FAO 公开项目有追溯价值的历史材料。
> 不是默认运行路径，不代表当前 FAO 最小骨架。
> 云端节点本地治理记录应保存在云端本地 memory/ 或 ~/.openclaw/quarantine/，不进入公共仓库。

---

## 当前保留

| 目录 | 内容 | 状态 |
|------|------|------|
| `whitepaper-old/` | 旧版白皮书草稿与历史版本 | 保留，供追溯 |

## 不应放入 archives/

- 云端节点本地运行日志（如 memory-history/）
- skill quarantine 记录（如 non-skill-projects/）
- 本地 memory 实验脚本（如 memory-experiments/）
- 第三方项目隔离记录（如 claude-mem/pua 的本地治理痕迹）
- 弱相关个人笔记（如 notes-misc/）
- 本地运行时工具脚本（如 tooling/）

上述内容属于云端节点本地治理，应保存在本地文件系统或 ~/.openclaw/quarantine/，不应进入公共仓库。

## 规则

- 禁止从 `archives/` 自动加载技能或任务
- 禁止将云端本地运行时痕迹归档后默认保留在公共仓库
- 归档动作不等于永久保留
- 轻量文本文件（README、.md、.py 源码）可入仓，保持可追溯
- PDF/大文件/二进制文件被 `.gitignore` 排除，留在本地
- 如需恢复实验，必须人工确认

---

*归档区不等于遗忘区。只是不再默认激活。*
