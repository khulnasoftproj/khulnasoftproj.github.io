#!/usr/bin/env bash

set -eu
set -o pipefail

cd "$(dirname "$0")/.."

command_console() {
  echo '```console'
  echo "$ $*"
  "$@"
  echo '```'
}

commands() {
  for cmd in install generate init update-khulnasoft update-checksum which generate-registry cp info list completion exec; do
    echo "
## khulnasoft $cmd

$(command_console khulnasoft help $cmd)"
  done
}

echo "---
sidebar_position: 400
---

# Usage

<!-- This is generated by scripts/generate-usage.sh. Don't edit this file directly. -->

$(command_console khulnasoft help)
$(commands)
"