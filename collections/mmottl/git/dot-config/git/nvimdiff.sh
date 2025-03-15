#!/bin/sh

set -eu

LOCAL="$1"
REMOTE="$2"

nvim -d +'colorscheme catppuccin' "$LOCAL" "$REMOTE" -c 'wincmd w' -c 'wincmd J'
