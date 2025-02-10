#!/bin/sh

# Catch errors
set -eu

# Only use colors when connected to a terminal that supports them
if [ -t 1 ] && command -v tput >/dev/null 2>&1; then
  if [ "$(tput colors 2>/dev/null)" -ge 8 ]; then
    RED=$(printf '\033[0;31m')
    BLUE=$(printf '\033[0;34m')
    BOLD=$(printf '\033[1m')
    NC=$(printf '\033[0m')
  fi
fi

# Make sure color variables are initialized
: "${RED:=}"
: "${BLUE:=}"
: "${BOLD:=}"
: "${NC:=}"

# Check if stow is installed
if ! command -v stow >/dev/null 2>&1; then
  printf "%bError: GNU Stow is not installed%b\n" "$RED" "$NC" >&2
  exit 1
fi

# Usage information
usage() {
  printf "%bUsage: %s [-S|-D|-R] [-n] [-c] [packages...]%b\n" \
    "$BOLD" "$0" "$NC" >&2
  printf "  %b-S%b: stow packages (default)\n" "$BLUE" "$NC" >&2
  printf "  %b-D%b: delete packages\n" "$BLUE" "$NC" >&2
  printf "  %b-R%b: restow packages (delete then stow)\n" "$BLUE" "$NC" >&2
  printf "  %b-n%b: dry-run (show what would happen)\n" "$BLUE" "$NC" >&2
  exit 1
}

# Default action and options
action="-S"
dry_run=""

# Parse options
while getopts "SDRnc:h" opt; do
  case $opt in
    S) action="-S" ;;
    D) action="-D" ;;
    R) action="-R" ;;
    n) dry_run="-n" ;;
    h | ?) usage ;;
  esac
done

cd pkgs

shift $((OPTIND - 1))
if [ $# -eq 0 ]; then
  # Determine default packages
  packages=$(find . -maxdepth 1 -type d \
    -not -name '.*' \
    -not -name '.' \
    | sed 's|^./||')
else
  packages="$*"
fi

# shellcheck disable=SC2086
stow --dotfiles --no-folding -v $dry_run -t "$HOME" "$action" $packages
