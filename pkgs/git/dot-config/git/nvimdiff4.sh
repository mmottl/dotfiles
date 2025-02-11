#!/bin/sh

set -eu

LOCAL="$1"
BASE="$2"
REMOTE="$3"
MERGED="$4"

nvim -d +'colorscheme catppuccin' "$LOCAL" "$BASE" "$REMOTE" "$MERGED" \
  -c "\$wincmd w" -c 'wincmd J'
