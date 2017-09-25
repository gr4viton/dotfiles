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

git_set_global() {
git config --global user.name $1
git config --global user.email $2
}

alias git_iam_gr4viton="git_set_global gr4viton lordmutty@gmail.com"
alias git_iam_kiwi="git_set_global daniel.davidek daniel.davidek@kiwi.com"
alias git_whoami="git config --list"

recheckout_current_branch() {
# if the diff is empty 
# - deletes current branch, pulls origin, checkout it again
cur=`git rev-parse --abbrev-ref HEAD`
echo Current branch = $cur
git checkout master
git branch -D $cur
git pull
git checkout $cur
}

git_branch() {
# returns only the last part after '/' of current branch name
git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's:.*/::'
}

