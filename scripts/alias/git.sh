#!/bin/bash
# git
alias git_initial_setup='git config --global pull.rebase true; git config --global alias.pushf "push --force-with-lease"'
alias pushf='git push --force-with-lease'
alias gdiff='git diff --color-words'
alias gpull_rebase='git pull --rebase origin master'
alias glog='git log --stat'
alias gsquash2='git rebase --interactive HEAD~2'
alias g='git'
alias b='branch'
alias ch='checkout'

