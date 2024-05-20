#!/bin/bash
# __ps1__

# urxvt randomize color
urxvt_set_random_preset_theme () {
  arr[0]="\033]11;#310024\007\033]10;white\007"  # ubuntu violet
  arr[1]="\033]11;#000000\007\033]10;#008f11\007" # matrix
  arr[2]="\033]11;#242424\007\033]10;#e3e0d7\007" # wombat256 vim? gray
  #arr[3]="\033]11;#000080\007\033]10;white\007"  # m$
  arr[3]="\033]11;#000030\007\033]10;white\007"  # dark blue
  arr[4]="\033]11;#000000\007\033]10;#AAAAAA\007"  #

  URXVT_THEME_LEN=5

  #if [[ -z "$URXVT_THEME_CURRENT" ]]; then
      #URXVT_THEME_CURRENT=0
  #fi
  #if [[ $URXVT_THEME_CURRENT == $URXVT_THEME_LEN ]]; then
      #URXVT_THEME_CURRENT=0
  #fi

  # or rand
  rand=$[ $RANDOM % $URXVT_THEME_LEN ]
  theme=${arr[$rand]}
  # theme=${arr[$URXVT_THEME_CURRENT]}  # envs are local to the started terminal

  # set the urxvt background and foreground color values
  # \033]11;#ff0000\007\033]10;yellow\007
  echo -e "$theme"

  #((URXVT_THEME_CURRENT=URXVT_THEME_CURRENT + 1))
  #let URXVT_THEME_CURRENT++
  #echo $URXVT_THEME_CURRENT
  #export URXVT_THEME_CURRENT

}
urxvt_set_random_preset_theme

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

BRANCH="\$(git_branch)"

export PS1="${BLUE}${BRANCH}${END} ${GREEN}\u ${YELLOW}\W ${DOLLAR}${END} "
