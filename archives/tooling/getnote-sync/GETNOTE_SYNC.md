# Get笔记 → 记忆外挂 同步工具

## 功能说明

双模式同步 Get笔记内容到本地记忆外挂系统：
- **API 模式**: 直接从 Get笔记云端拉取
- **文件模式**: 导入导出的 JSON/Markdown/TXT

## 使用方法

### 1. 从文件导入（无需配置，立即可用）

```bash
# 导入 JSON 文件
bash sync_getnote.sh --file notes.json

# 导入 Markdown 文件（按标题自动分割）
bash sync_getnote.sh --file notes.md

# 指定存储目录
bash sync_getnote.sh --file notes.json --memory-dir ~/.my_memory
```

**支持的文件格式：**
- `.json` - Get笔记导出格式 或 标准 JSON 数组
- `.md/.markdown` - 按 `## ` 标题分割为多条笔记
- `.txt` - 整体作为单条笔记

### 2. 从 API 同步（需配置密钥）

**第一步：配置 API**

```bash
# 临时配置
export GETNOTE_API_KEY='gk_live_xxx'
export GETNOTE_CLIENT_ID='cli_xxx'

# 永久配置（推荐）
echo 'export GETNOTE_API_KEY="gk_live_xxx"' >> ~/.bashrc
echo 'export GETNOTE_CLIENT_ID="cli_xxx"' >> ~/.bashrc
source ~/.bashrc
```

**获取 API Key:**
1. 访问 https://www.biji.com/openapi
2. 登录后创建应用
3. 复制 `API Key` 和 `Client ID`

**第二步：执行同步**

```bash
# 同步最近 100 条
bash sync_getnote.sh --api

# 同步更多
bash sync_getnote.sh --api --limit 500

# 试运行（不实际写入）
bash sync_getnote.sh --api --dry-run
```

### 3. Python API 调用

```python
from getnote_sync import GetNoteSync

# 初始化
syncer = GetNoteSync(memory_dir="~/.memory_system")

# 从文件导入
notes = syncer.import_from_file("my_notes.json")
syncer.sync(notes)

# 从 API 获取（需配置环境变量）
notes = syncer.fetch_from_api(limit=100)
syncer.sync(notes)
```

## 数据映射

| Get笔记字段 | 记忆系统字段 | 说明 |
|------------|-------------|------|
| `content` | `content` | 笔记内容 |
| `title` | - | 附加到 content |
| `id` | `source` | 记录来源ID |
| `tags` | `tags` | 标签列表 |
| `knowledge_base.name` | `tags` | 添加 `kb:名称` 标签 |

## 示例数据格式

**JSON 格式 (notes.json):**
```json
[
  {
    "id": "note_001",
    "content": "笔记内容...",
    "title": "标题",
    "tags": ["标签1", "标签2"],
    "source": "getnote"
  }
]
```

**Markdown 格式 (notes.md):**
```markdown
# 笔记集

## 第一条笔记标题
内容...

## 第二条笔记标题  
内容...
```

## 完整命令参考

```bash
# 查看帮助
python3 getnote_sync.py --help

# 文件导入
bash sync_getnote.sh --file notes.json

# API 同步（需配置）
bash sync_getnote.sh --api --limit 200

# 试运行
bash sync_getnote.sh --file notes.json --dry-run

# 自定义存储路径
bash sync_getnote.sh --api --memory-dir ~/.custom_memory
```

## 与主记忆系统的关系

```
Get笔记（云端）
    ↓ 同步
记忆外挂系统（本地）
    ├── LanceDB (向量存储 - 语义检索)
    └── Kuzu (图谱存储 - 关系推理)
```

**建议用法：**
1. 定期同步 Get笔记 到本地（如每周一次）
2. 日常用本地记忆系统做深度检索
3. 新增内容可以先存 Get笔记，再批量同步

## 故障排查

| 问题 | 解决 |
|------|------|
| API 未配置 | 设置 `GETNOTE_API_KEY` 和 `GETNOTE_CLIENT_ID` 环境变量 |
| 导入失败 | 检查 JSON 格式，确保是数组或包含 `items` 的对象 |
| 编码错误 | 确保文件是 UTF-8 编码 |
| 内存不足 | 减少 `--limit` 数量，分批同步 |

---
**文件:** `getnote_sync.py`, `sync_getnote.sh`  
**依赖:** 与记忆系统共用同一套环境
