#!/bin/sh
printf '\033c\033]0;%s\a' October
base_path="$(dirname "$(realpath "$0")")"
"$base_path/october.x86_64" "$@"
