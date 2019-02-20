#!/bin/bash

# PS1 from ams
END="\[\e[0m\]"
BLUE="\[\e[34;1m\]"
RED="\[\e[31;1m\]"
CYAN="\[\e[36;1m\]"
GREEN="\[\e[32;1m\]"
YELLOW="\[\e[33;1m\]"
DOLLAR="${GREEN}\$"
DOLLAR="${RED}▶"

git_branch_cutted() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's:.*/::'
}

BRANCH="\$(git_branch_cutted)"

export PS1="${BLUE}${BRANCH}${END} ${GREEN}\u ${YELLOW}\W ${DOLLAR}${END} "
