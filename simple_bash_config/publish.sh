#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASEURL_FILE="$SCRIPT_DIR/baseurl"
source "$BASEURL_FILE"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

sed "s#_BASE_URL=\"https://xxx\"#$(cat "$BASEURL_FILE")#" "$SCRIPT_DIR/simple_bash_config" > "$tmpdir/simple_bash_config"

(
  cd "$tmpdir"
  /bin/bash -c "$(curl -fsSL "$_BASE_URL/tosupload/tos.sh")" -- simple_bash_config -d=script
)
