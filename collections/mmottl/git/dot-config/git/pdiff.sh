#!/bin/sh

set -eu

cd "${GIT_PREFIX:-.}"
git difftool -y -x patdiff "$@" | less
