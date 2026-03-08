#!/usr/bin/env bash

set -euo pipefail

# 最简单的发布脚本：
# 遍历当前目录及子目录中的文件，
# 对每个文件执行同一条发布命令。
#
# 你只需要改下面这个命令模板即可。
# 模板里只有一个变量：{rel}
# 它表示当前文件相对项目根目录的路径。
#
# 示例：
# COMMAND_TEMPLATE='tos {rel} other-args'
# COMMAND_TEMPLATE='upload {rel}'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 直接改这里。
COMMAND_TEMPLATE='echo tos {rel} -d=xk_installer'

run_one() {
  local rel="$1"
  local command="$COMMAND_TEMPLATE"

  command="${command//\{rel\}/$rel}"

  echo "Publishing: $rel"
  bash -lc "$command"
}

main() {
  local rel

  while IFS= read -r rel; do
    run_one "$rel"
  done < <(cd "$ROOT_DIR" && find . -type f | sed 's#^\./##' | sort)

  echo
  echo "Publish completed."
}

main "$@"
