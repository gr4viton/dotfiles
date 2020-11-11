#!/bin/bash

# my colors
c_end=$'\e[0m'
c_blue=$'\e[1;34m'
c_red=$'\e[1;31m'
c_cyan=$'\e[1;36m'
c_green=$'\e[1;32m'
c_yellow=$'\e[1;33m'

# PS1 from ams
END="\[\e[0m\]"
BLUE="\[\e[34;1m\]"
RED="\[\e[31;1m\]"
CYAN="\[\e[36;1m\]"
GREEN="\[\e[32;1m\]"
YELLOW="\[\e[33;1m\]"
DOLLAR="${GREEN}\$"
DOLLAR="${RED}▶"

# git_branch_cutted sourced from bash/alias/git.sh
# git_branch_cutted() {
#   git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's:.*/::'
# }

BRANCH="\$(git_branch_cutted)"

export PS1="${BLUE}${BRANCH}${END} ${GREEN}\u ${YELLOW}\W ${DOLLAR}${END} "
