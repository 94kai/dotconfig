#!/usr/bin/env bash

set -euo pipefail

# 这个脚本用于把当前目录临时启动成一个静态文件服务，
# 方便你本地先验证 bootstrap.sh / manifest.txt / scripts/ 的下载流程。

# 默认监听端口，可通过 PORT 覆盖。
PORT="${PORT:-8000}"
# 默认绑定所有网卡，方便局域网或 WSL 内访问。
HOST="${HOST:-0.0.0.0}"

# 获取当前目录的绝对路径，启动服务时会以这里作为站点根目录。
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v python3 >/dev/null 2>&1; then
  PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
else
  echo "错误：未找到 python3 或 python，无法启动本地文件服务。" >&2
  exit 1
fi

echo "站点目录: $ROOT_DIR"
echo "监听地址: http://$HOST:$PORT"
echo
echo "入口脚本 URL:"
echo "  http://127.0.0.1:$PORT/bootstrap.sh"
echo
echo "manifest URL:"
echo "  http://127.0.0.1:$PORT/manifest.txt"
echo
echo "示例测试命令:"
echo "  baseurl=http://127.0.0.1:$PORT; curl -fsSL \"\$baseurl/bootstrap.sh\" | bash -s -- \"\$baseurl\""
echo

cd "$ROOT_DIR"
exec "$PYTHON_BIN" -m http.server "$PORT" --bind "$HOST"
