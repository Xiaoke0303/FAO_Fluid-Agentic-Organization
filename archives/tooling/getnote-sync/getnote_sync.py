#!/usr/bin/env python3
"""
Get笔记 → 记忆外挂 同步脚本
支持 API 同步 或 文件导入
"""

import os
import sys
import json
import argparse
from pathlib import Path
from datetime import datetime
from typing import List, Dict, Optional

# 添加记忆系统路径
sys.path.insert(0, '/root/.openclaw/workspace')
from memory_system import MemorySystem

class GetNoteSync:
    """Get笔记同步器"""
    
    def __init__(self, memory_dir: str = "~/.memory_system"):
        self.memory = MemorySystem(data_dir=memory_dir)
        self.api_key = os.getenv('GETNOTE_API_KEY')
        self.client_id = os.getenv('GETNOTE_CLIENT_ID')
    
    def check_api_config(self) -> bool:
        """检查 API 配置"""
        if not self.api_key or not self.client_id:
            print("⚠️ Get笔记 API 未配置")
            print("  请设置环境变量：")
            print("    export GETNOTE_API_KEY='gk_live_xxx'")
            print("    export GETNOTE_CLIENT_ID='cli_xxx'")
            print("\n  或在 ~/.bashrc 中添加")
            return False
        return True
    
    def fetch_from_api(self, limit: int = 100) -> List[Dict]:
        """从 Get笔记 API 获取笔记"""
        if not self.check_api_config():
            return []
        
        try:
            import requests
            
            headers = {
                'Authorization': self.api_key,
                'X-Client-ID': self.client_id,
                'Content-Type': 'application/json'
            }
            
            url = 'https://openapi.biji.com/api/note/search'
            
            print(f"📡 正在从 Get笔记 获取 {limit} 条笔记...")
            
            notes = []
            cursor = None
            
            while len(notes) < limit:
                payload = {
                    'query': '*',
                    'limit': min(20, limit - len(notes)),
                    'cursor': cursor
                }
                
                resp = requests.post(url, headers=headers, json=payload, timeout=30)
                data = resp.json()
                
                if not data.get('success'):
                    print(f"  API 错误: {data.get('error', {}).get('message', '未知错误')}")
                    break
                
                items = data.get('data', {}).get('items', [])
                if not items:
                    break
                
                notes.extend(items)
                print(f"  已获取 {len(notes)} 条...")
                
                cursor = data.get('data', {}).get('next_cursor')
                if not cursor:
                    break
            
            print(f"✓ 共获取 {len(notes)} 条笔记")
            return notes
            
        except Exception as e:
            print(f"❌ API 请求失败: {e}")
            return []
    
    def import_from_file(self, filepath: str) -> List[Dict]:
        """从文件导入笔记"""
        path = Path(filepath)
        if not path.exists():
            print(f"❌ 文件不存在: {filepath}")
            return []
        
        print(f"📁 正在读取 {path.name}...")
        
        # 支持多种格式
        notes = []
        
        if path.suffix == '.json':
            with open(path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                if isinstance(data, list):
                    notes = data
                elif isinstance(data, dict) and 'items' in data:
                    notes = data['items']
                else:
                    notes = [data]
        
        elif path.suffix in ('.md', '.markdown'):
            # Markdown 文件，按标题分割
            content = path.read_text(encoding='utf-8')
            sections = content.split('\n## ')
            for i, section in enumerate(sections):
                if section.strip():
                    title = section.split('\n')[0].strip('# ')
                    notes.append({
                        'id': f'file_{i}',
                        'content': section,
                        'title': title,
                        'source': f'file:{path.name}'
                    })
        
        else:
            # 纯文本，整体作为一条笔记
            content = path.read_text(encoding='utf-8')
            notes.append({
                'id': 'file_0',
                'content': content,
                'title': path.stem,
                'source': f'file:{path.name}'
            })
        
        print(f"✓ 读取 {len(notes)} 条笔记")
        return notes
    
    def sync(self, notes: List[Dict], dry_run: bool = False) -> int:
        """同步笔记到记忆系统"""
        if not notes:
            print("⚠️ 没有笔记需要同步")
            return 0
        
        print(f"\n🔄 开始同步 {len(notes)} 条笔记...")
        if dry_run:
            print("  [试运行模式，不实际写入]")
        
        success = 0
        for note in notes:
            try:
                # 提取内容
                content = note.get('content', '')
                if not content:
                    content = note.get('title', '') + '\n' + note.get('abstract', '')
                
                # 提取来源和标签
                source = note.get('source', 'getnote')
                if not source or source == 'getnote':
                    source = f"getnote:{note.get('id', 'unknown')}"
                
                tags = note.get('tags', [])
                if isinstance(tags, str):
                    tags = [t.strip() for t in tags.split(',')]
                
                # 添加知识库信息
                kb = note.get('knowledge_base', {})
                if kb and kb.get('name'):
                    tags.append(f"kb:{kb['name']}")
                
                if dry_run:
                    print(f"  [dry-run] #{note.get('id')}: {content[:40]}...")
                    success += 1
                    continue
                
                # 写入记忆系统
                mid = self.memory.add(
                    content=content,
                    source=source,
                    tags=tags
                )
                success += 1
                print(f"  ✓ #{mid} <- Get笔记 #{note.get('id', '?')}")
                
            except Exception as e:
                print(f"  ✗ 同步失败: {e}")
        
        print(f"\n✅ 同步完成: {success}/{len(notes)} 条成功")
        
        # 显示统计
        stats = self.memory.stats()
        print(f"\n📊 记忆系统统计:")
        for k, v in stats.items():
            print(f"    {k}: {v}")
        
        return success


def main():
    parser = argparse.ArgumentParser(description='Get笔记 → 记忆外挂 同步工具')
    parser.add_argument('--api', action='store_true', help='从 Get笔记 API 同步')
    parser.add_argument('--file', type=str, help='从文件导入 (JSON/Markdown/TXT)')
    parser.add_argument('--limit', type=int, default=100, help='API 获取数量限制')
    parser.add_argument('--dry-run', action='store_true', help='试运行，不实际写入')
    parser.add_argument('--memory-dir', type=str, default='~/.memory_system', 
                        help='记忆系统存储目录')
    
    args = parser.parse_args()
    
    print("="*60)
    print("🔄 Get笔记 → 记忆外挂 同步工具")
    print("="*60)
    
    # 初始化同步器
    syncer = GetNoteSync(memory_dir=args.memory_dir)
    
    # 获取笔记
    if args.api:
        notes = syncer.fetch_from_api(limit=args.limit)
    elif args.file:
        notes = syncer.import_from_file(args.file)
    else:
        print("\n用法示例:")
        print("  从 API 同步:     python getnote_sync.py --api")
        print("  从文件导入:      python getnote_sync.py --file notes.json")
        print("  试运行:          python getnote_sync.py --api --dry-run")
        print("\n请先配置 API:")
        print("  export GETNOTE_API_KEY='gk_live_xxx'")
        print("  export GETNOTE_CLIENT_ID='cli_xxx'")
        return
    
    # 执行同步
    if notes:
        syncer.sync(notes, dry_run=args.dry_run)


if __name__ == "__main__":
    main()
