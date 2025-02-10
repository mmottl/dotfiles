#!/bin/sh

set -eu

nvim -d "$LOCAL" +'colorscheme catppuccin' "$REMOTE" -c 'wincmd w' -c 'wincmd J'
