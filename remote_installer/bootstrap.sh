#!/usr/bin/env bash

set -euo pipefail

# 项目名称固定写死。
PROJECT_NAME="远程脚本启动器"
# 清单文件固定为 manifest.txt。
MANIFEST_NAME="manifest.txt"
# 子脚本固定放在远端 scripts 目录下。
SCRIPTS_DIR="scripts"
# 本地缓存目录固定为 /tmp/remote-script-launcher。
WORKDIR="/tmp/remote-script-launcher"
MANIFEST_PATH="$WORKDIR/$MANIFEST_NAME"
# 第一个参数必须传入远端根地址。
BASE_URL="${1:-}"

mkdir -p "$WORKDIR"

# 优先使用 curl，没有时退回 wget。
if command -v curl >/dev/null 2>&1; then
  HTTP_CLIENT="curl"
elif command -v wget >/dev/null 2>&1; then
  HTTP_CLIENT="wget"
else
  echo "Error: curl or wget is required." >&2
  exit 1
fi

# 校验启动参数。
validate_args() {
  if [[ -z "$BASE_URL" ]]; then
    echo "Error: missing BASE_URL argument." >&2
    echo "Usage example:" >&2
    echo '  baseurl=http://127.0.0.1:8000; curl -fsSL "$baseurl/bootstrap.sh" | bash -s -- "$baseurl"' >&2
    exit 1
  fi
}

# 下载文件到指定路径。
download_to() {
  local url="$1"
  local target="$2"

  if [[ "$HTTP_CLIENT" == "curl" ]]; then
    curl -fsSL "$url" -o "$target"
  else
    wget -qO "$target" "$url"
  fi
}

# 去掉字符串首尾空白。
trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

# 从终端读取用户输入。
# 这样即使脚本通过 curl | bash 执行，也仍然可以正常交互。
read_user_input() {
  local prompt="$1"
  local value

  if [[ -r /dev/tty ]]; then
    read -r -p "$prompt" value < /dev/tty
  else
    read -r -p "$prompt" value
  fi

  printf '%s' "$value"
}

# 拉取最新清单。
load_manifest() {
  local manifest_url="${BASE_URL%/}/$MANIFEST_NAME"
  echo "Fetching manifest: $manifest_url"
  download_to "$manifest_url" "$MANIFEST_PATH"
}

declare -a ITEM_IDS=()
declare -a ITEM_TITLES=()
declare -a ITEM_SCRIPTS=()

# 解析清单文件。
# 每行支持两种格式：
# 1. install-docker.sh
# 2. install-docker.sh|安装 Docker
# 支持空行和 # 注释。
parse_manifest() {
  ITEM_IDS=()
  ITEM_TITLES=()
  ITEM_SCRIPTS=()

  local line script_name item_title raw_title raw_script_name
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="$(trim "$line")"
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^# ]] && continue

    if [[ "$line" == *"|"* ]]; then
      IFS='|' read -r raw_script_name raw_title <<< "$line"
      script_name="$(trim "${raw_script_name:-}")"
      item_title="$(trim "${raw_title:-}")"
    else
      script_name="$line"
      item_title=""
    fi

    if [[ -z "$script_name" || "$script_name" == */* || "$script_name" == *".."* ]]; then
      echo "Warning: skipped invalid manifest line: $line" >&2
      continue
    fi

    if [[ -z "$item_title" ]]; then
      item_title="$script_name"
    fi

    ITEM_IDS+=("$script_name")
    ITEM_TITLES+=("$item_title")
    ITEM_SCRIPTS+=("$script_name")
  done < "$MANIFEST_PATH"

  if [[ "${#ITEM_IDS[@]}" -eq 0 ]]; then
    echo "Error: manifest does not contain any runnable items." >&2
    exit 1
  fi
}

# 打印菜单。
print_menu() {
  echo
  echo "==== $PROJECT_NAME ===="
  local i
  for i in "${!ITEM_IDS[@]}"; do
    printf '%2d) %s\n' "$((i + 1))" "${ITEM_TITLES[$i]}"
  done
  echo " q) Quit"
  echo
}

# 根据编号、标题或脚本名找到菜单项。
resolve_selection() {
  local input="${1:-}"
  local i

  if [[ -z "$input" ]]; then
    return 1
  fi

  if [[ "$input" =~ ^[0-9]+$ ]]; then
    local index=$((input - 1))
    if (( index >= 0 && index < ${#ITEM_IDS[@]} )); then
      printf '%s' "$index"
      return 0
    fi
    return 1
  fi

  for i in "${!ITEM_IDS[@]}"; do
    if [[ "$input" == "${ITEM_IDS[$i]}" || "$input" == "${ITEM_TITLES[$i]}" ]]; then
      printf '%s' "$i"
      return 0
    fi
  done

  return 1
}

# 下载并执行子脚本。
run_item() {
  local index="$1"
  local script_name="${ITEM_SCRIPTS[$index]}"
  local target="$WORKDIR/$script_name"
  local script_url="${BASE_URL%/}/${SCRIPTS_DIR}/$script_name"

  echo
  echo "Running: ${ITEM_TITLES[$index]}"
  echo "Downloading script: $script_url"
  download_to "$script_url" "$target"
  chmod +x "$target"

  bash "$target"
}

# 交互模式。
interactive_loop() {
  local choice index
  while true; do
    print_menu
    choice="$(read_user_input "Select a number or script name: ")"
    choice="$(trim "$choice")"

    if [[ "$choice" == "q" || "$choice" == "quit" || "$choice" == "exit" ]]; then
      echo "Bye."
      exit 0
    fi

    if index="$(resolve_selection "$choice")"; then
      run_item "$index"
      exit 0
    fi

    echo "Invalid selection, please try again."
  done
}

main() {
  validate_args
  load_manifest
  parse_manifest

  if [[ "${2:-}" == "--list" || "${1:-}" == "--list" ]]; then
    print_menu
    exit 0
  fi

  if [[ -n "${2:-}" ]]; then
    local index
    if index="$(resolve_selection "$2")"; then
      run_item "$index"
      exit 0
    fi

    echo "Error: command not found: $2" >&2
    exit 1
  fi

  interactive_loop
}

main "$@"
