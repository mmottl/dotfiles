#!/bin/sh

set -eu

nvim -d +'colorscheme catppuccin' "$LOCAL" "$BASE" "$REMOTE" "$MERGED" \
  -c "\$wincmd w" -c 'wincmd J'
