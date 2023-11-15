#!/bin/sh
echo -ne '\033c\033]0;wizard_battler\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/wizard_battler.x86_64" "$@"
