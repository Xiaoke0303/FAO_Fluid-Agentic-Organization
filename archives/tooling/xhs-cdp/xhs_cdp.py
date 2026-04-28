# -*- coding: utf-8 -*-
"""
XHS Browser-CDP 抓取工具箱 (Linux 适配版)
Xiaohongshu (小红书) scraping via Chrome DevTools Protocol

用法：
    python xhs_cdp.py                           # 检查连接状态
    python xhs_cdp.py --launch                   # 启动 Chrome 调试模式
    python xhs_cdp.py --article <URL或短链>    # 抓取笔记详情
    python xhs_cdp.py --profile <user_id>       # 抓取用户主页
    python xhs_cdp.py --homepage                # 抓取首页推荐流
    python xhs_cdp.py --screenshot <URL>        # 截图任意页面
"""

import sys, os, json, time, re, base64, asyncio, argparse
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
sys.stderr.reconfigure(encoding='utf-8', errors='replace')

# Linux 默认保存目录
DEFAULT_SAVE_DIR = os.path.expanduser('~/.openclaw/workspace/artifacts/xhs')

# ---------------------------------------------------------------------------
# CDP 核心连接
# ---------------------------------------------------------------------------

def find_xhs_tab(tabs):
    """从标签页列表中找到小红书标签页"""
    for t in tabs:
        if t.get('type') == 'page' and 'xiaohongshu.com' in t.get('url', ''):
            return t
    return None

import urllib.request, urllib.error

def check_chrome_running():
    """检查 Chrome 是否以调试模式运行"""
    try:
        resp = urllib.request.urlopen('http://127.0.0.1:9222/json/version', timeout=3)
        info = json.loads(resp.read())
        print(f"  Chrome 调试模式正常")
        print(f"     Browser: {info.get('Browser', 'N/A')}")
        return True
    except Exception:
        print(f"  Chrome 调试端口未开启")
        print(f"     请运行: python xhs_cdp.py --launch")
        return False

def get_all_tabs():
    """获取所有标签页列表"""
    try:
        resp = urllib.request.urlopen('http://127.0.0.1:9222/json/list', timeout=5)
        return json.loads(resp.read())
    except Exception as e:
        print(f"  获取标签页失败: {e}")
        return []

# ---------------------------------------------------------------------------
# CDP 会话封装
# ---------------------------------------------------------------------------

class CDPSession:
    def __init__(self, ws_url):
        self._ws_url = ws_url
        self._ws = None
        self._msg_id = 1

    async def __aenter__(self):
        import websockets
        self._ws = await asyncio.wait_for(
            websockets.connect(self._ws_url, max_size=15*1024*1024),
            timeout=15
        )
        return self

    async def __aexit__(self, *args):
        try:
            await self._ws.close()
        except: pass

    async def _send_recv(self, method, params=None, timeout=15):
        """发送 CDP 命令并返回 result.value"""
        params = params or {}
        mid = self._msg_id
        self._msg_id += 1
        await self._ws.send(json.dumps({'id': mid, 'method': method, 'params': params}))
        while True:
            r = await asyncio.wait_for(self._ws.recv(), timeout=timeout)
            d = json.loads(r)
            if d.get('id') == mid:
                result = d.get('result', {})
                if 'error' in d:
                    return {'error': d['error']}
                return result.get('result', {}).get('value', '')

    async def eval_js(self, js, timeout=15):
        """执行 JS 并尝试解析返回的 JSON"""
        raw = await self._send_recv('Runtime.evaluate',
                                     {'expression': js, 'returnByValue': True}, timeout)
        try:
            return json.loads(raw) if isinstance(raw, str) else raw
        except:
            return {'text': str(raw)[:5000]}

    async def navigate(self, url, wait_sec=8):
        """导航到 URL"""
        await self._send_recv('Page.navigate', {'url': url}, timeout=wait_sec+5)
        await asyncio.sleep(wait_sec)

    async def scroll_down(self, px=600, times=5, delay=1.5):
        """滚动页面触发懒加载"""
        for _ in range(times):
            await self.eval_js(f'window.scrollBy(0, {px})')
            await asyncio.sleep(delay)
        await asyncio.sleep(2)

    async def screenshot(self, path):
        """截图并保存到文件"""
        data = await self._send_recv('Page.captureScreenshot',
                                     {'format': 'png', 'captureBeyondViewport': True,
                                      'fromSurface': True}, timeout=25)
        if data:
            try:
                with open(path, 'wb') as f:
                    f.write(base64.b64decode(data))
                return True
            except: pass
        return False

# ---------------------------------------------------------------------------
# 抓取任务
# ---------------------------------------------------------------------------

async def fetch_article(url, save_dir=DEFAULT_SAVE_DIR):
    """抓取单篇小红书笔记"""
    os.makedirs(save_dir, exist_ok=True)
    
    tabs = get_all_tabs()
    xhs_tab = find_xhs_tab(tabs)
    if not xhs_tab:
        print("ERROR: 没有找到小红书标签页，请先在Chrome中打开小红书")
        return

    print(f"使用标签页: {xhs_tab['url'][:60]}")

    # 短链解析
    if 'xhslink.com' in url:
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
            with urllib.request.urlopen(req, timeout=10) as resp:
                url = resp.url
                print(f"短链解析: {url[:80]}")
        except Exception as e:
            print(f"短链解析失败: {e}")

    note_id = re.search(r'/explore/([a-f0-9]+)', url)
    note_id = note_id.group(1)[:8] if note_id else 'unknown'

    async with CDPSession(xhs_tab['webSocketDebuggerUrl']) as session:
        await session.navigate(url, wait_sec=10)
        await session.scroll_down(px=800, times=6, delay=1.5)

        print("提取页面内容...")
        info = await session.eval_js('''
            JSON.stringify({
                url: window.location.href,
                title: document.title.replace(' - 小红书','').trim(),
                author: (document.querySelector('[class*="author"]') || document.querySelector('[class*="nickname"]'))?.innerText || 'N/A',
                time: (document.querySelector('[class*="time"]') || document.querySelector('[class*="date"]'))?.innerText || 'N/A',
                location: (document.querySelector('[class*="location"]'))?.innerText || '',
                tags: Array.from(document.querySelectorAll('[class*="tag"], [class*="topic"]'))
                       .map(t=>t.innerText).filter(t=>t && t.length<30).slice(0,20).join(' | '),
                body: document.body.innerText.substring(0, 10000)
            })
        ''')

        title = info.get('title', '')
        author = info.get('author', 'N/A')
        post_time = info.get('time', 'N/A')
        location = info.get('location', '')
        tags = info.get('tags', '')
        body = info.get('body', '')
        final_url = info.get('url', '')

        print(f"\n{'='*60}")
        print(f"标题: {title}")
        print(f"作者: {author}")
        print(f"时间: {post_time} {location}")
        print(f"标签: {tags}")
        print(f"{'='*60}")
        print(f"\n正文 ({len(body)} 字):")
        print(body[:3000])
        if len(body) > 3000:
            print(f"\n... 还有 {len(body)-3000} 字")

        # 截图
        snap = os.path.join(save_dir, f'xhs_{note_id}.png')
        if await session.screenshot(snap):
            print(f"\n截图: {snap}")

        # 保存正文
        body_path = os.path.join(save_dir, f'xhs_{note_id}_body.txt')
        with open(body_path, 'w', encoding='utf-8') as f:
            f.write(f"URL: {final_url}\n标题: {title}\n作者: {author}\n时间: {post_time}\n地点: {location}\n标签: {tags}\n\n正文:\n{body}")
        print(f"正文: {body_path}")

async def fetch_homepage(save_dir=DEFAULT_SAVE_DIR):
    """抓取首页推荐流"""
    os.makedirs(save_dir, exist_ok=True)
    
    tabs = get_all_tabs()
    xhs_tab = find_xhs_tab(tabs)
    if not xhs_tab:
        print("ERROR: 没有找到小红书标签页")
        return

    async with CDPSession(xhs_tab['webSocketDebuggerUrl']) as session:
        await session.navigate('https://www.xiaohongshu.com/explore', wait_sec=8)
        await session.scroll_down(px=800, times=8, delay=1.5)

        items = await session.eval_js('''
            JSON.stringify({
                cards: Array.from(document.querySelectorAll('[class*="note"]')).slice(0,20).map(n=>({
                    title: (n.querySelector('[class*="title"]')||n.querySelector('h3'))?.innerText||'',
                    author: n.querySelector('[class*="author"]')?.innerText||'',
                    likes: n.querySelector('[class*="count"]')?.innerText||'',
                })).filter(c=>c.title),
                body: document.body.innerText.substring(0,5000)
            })
        ''')

        cards = items.get('cards', [])
        print(f"\n{'='*60}")
        print(f"推荐笔记 ({len(cards)} 篇):")
        for i, c in enumerate(cards[:10], 1):
            print(f"  {i}. {c['title'][:40]} | {c['author']} | {c['likes']}")
        print(f"{'='*60}")

        path = os.path.join(save_dir, 'xhs_homepage.txt')
        with open(path, 'w', encoding='utf-8') as f:
            f.write(items.get('body', ''))
        print(f"保存: {path}")

# ---------------------------------------------------------------------------
# 启动 Chrome
# ---------------------------------------------------------------------------

def launch_chrome():
    """通过 subprocess 启动带调试端口的 Chrome"""
    import subprocess
    
    # Linux 路径检测
    chrome_candidates = [
        '/usr/bin/google-chrome',
        '/usr/bin/chromium',
        '/usr/bin/chromium-browser',
    ]
    chrome = None
    for c in chrome_candidates:
        if os.path.exists(c):
            chrome = c
            break
    
    if not chrome:
        print("ERROR: 未找到 Chrome/Chromium，请安装")
        return
    
    # 使用临时用户数据目录
    userdata = os.path.expanduser('~/.xhs_chrome_profile')
    os.makedirs(userdata, exist_ok=True)
    
    cmd = [chrome, '--remote-debugging-port=9222', '--user-data-dir=' + userdata, '--no-sandbox']
    try:
        subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print(f"Chrome 已启动（调试端口 9222），等待 3 秒...")
        time.sleep(3)
        print(f"用户数据目录: {userdata}")
    except Exception as e:
        print(f"启动失败: {e}")

# ---------------------------------------------------------------------------
# 主入口
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description='XHS Browser-CDP 抓取工具 (Linux版)')
    parser.add_argument('--check', action='store_true', help='检查连接状态')
    parser.add_argument('--launch', action='store_true', help='启动 Chrome 调试模式')
    parser.add_argument('--article', nargs='?', const='', help='抓取笔记 (URL/短链 或留空用当前页)')
    parser.add_argument('--profile', help='抓取用户主页 (user_id)')
    parser.add_argument('--homepage', action='store_true', help='抓取首页推荐')
    parser.add_argument('--screenshot', nargs='?', const='', help='截图当前页或指定 URL')
    parser.add_argument('--save-dir', default=DEFAULT_SAVE_DIR, help=f'保存目录 (默认: {DEFAULT_SAVE_DIR})')
    args = parser.parse_args()

    print("\n XHS Browser-CDP 工具 (Linux版)")
    print("=" * 40)

    if args.launch:
        launch_chrome()
        return

    if args.check or args.article is None and not (args.profile or args.homepage or args.screenshot):
        ok = check_chrome_running()
        tabs = get_all_tabs()
        print(f"\n当前标签页 ({len(tabs)} 个):")
        for t in tabs:
            flag = "XHS" if 'xiaohongshu.com' in t.get('url','') else "   "
            print(f"  [{flag}] {t.get('url','')[:65]}")
        if args.check:
            return

    if args.article is not None:
        url = args.article or 'current'
        asyncio.run(fetch_article(url, args.save_dir))
    elif args.profile:
        url = f"https://www.xiaohongshu.com/user/profile/{args.profile}"
        asyncio.run(fetch_article(url, args.save_dir))
    elif args.homepage:
        asyncio.run(fetch_homepage(args.save_dir))
    elif args.screenshot is not None:
        async def _snap():
            tabs = get_all_tabs()
            xhs_tab = find_xhs_tab(tabs)
            if not xhs_tab:
                print("ERROR: 没有小红书标签页")
                return
            snap = os.path.join(args.save_dir, 'xhs_snap.png')
            os.makedirs(args.save_dir, exist_ok=True)
            async with CDPSession(xhs_tab['webSocketDebuggerUrl']) as session:
                if args.screenshot:
                    await session.navigate(args.screenshot, wait_sec=8)
                await session.screenshot(snap)
            print(f"截图: {snap}")
        asyncio.run(_snap())

if __name__ == '__main__':
    main()
