#!/bin/bash
# git
alias git_initial_setup='git config --global pull.rebase true; git config --global alias.pushf "push --force-with-lease"'
# alias gdiff='git diff --color-words'

alias git_current_branch="git rev-parse --abbrev-ref HEAD"

git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

git_branch_cutted() {
    # returns only the last part after '/' of current branch name
    git_branch | sed 's:.*/::'
}

gpl () {
    git pull --rebase origin master
}
alias gpull_rebase='gpl'
gpf () {
    ddate
    git push --force-with-lease
}

gid () {
    git diff --color-words
}

alias pushf='gpf'

alias glog='git log --stat'
alias glog_oneline='git log --pretty=oneline'
alias glogp='git log --stat --patch'
alias glogfiles='git ls-files'

# git
glogdd () {
    # git branch --sort=-committerdate
    # the same
    git for-each-ref --format='%(refname:short)' refs/heads/** --sort=-committerdate
}

glogd () {
    glogdd | head -20
}
glogd_get () {
    num="${1:?number of line - first = 1}"
    sed -n "${num}p" <(glogdd)
}
git_install_gci () {
    echo "install the git checkout interactive"
    npm install --global git-checkout-interactive
}
gic () {
    gci
}

gi_delete_merged () {
    git checkout master && git branch -d $(git branch --merged | tr '*' ' ' | tr 'master' ' ')
}
alias gloghash='git log --pretty=format:"%h %s"'

glogdog () { git log --all --decorate --oneline --graph; }
gloggraph () { git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all; }
gloggraph_2line () { git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all; }

alias gir="git rebase"


giri () {  # git rebase
    git rebase --interactive HEAD~$1
}

gir_conflict_files () {
    git diff --name-only --diff-filter=U
}
vigir_conflict_files () {
    vim $(git diff --name-only | uniq)
}

vigit_rebase_conflict2 () {
    vimo $(gir_conflict_files)
}
vigit_rebase_conflict () {
    vimo $(git diff --name-only | uniq)
}

alias g='git'
alias b='branch'
alias ch='checkout'

git_set_global() {
    git config --global user.name $1
    git config --global user.email $2
    git config --list
}
git_set_local() {
    git config --local user.name $1
    git config --local user.email $2
    git config --list
}

alias git_iam_gr4viton_global="git_set_global gr4viton lordmutty@gmail.com"
alias git_iam_gr4viton="git_set_local gr4viton lordmutty@gmail.com"

alias git_iam_kiwi_global="git_set_global daniel.davidek daniel.davidek@kiwi.com"
alias git_iam_kiwi="git_set_local daniel.davidek daniel.davidek@kiwi.com"

alias git_whoami="git config --list"

## git ssh
alias generate_ssh='ssh-keygen'
#https://confluence.atlassian.com/bitbucket/set-up-ssh-for-git-728138079.html
git_generate_ssh() {
    if [ -f $HOME/.ssh/id_rsa.pub ]; then
        echo $HOME/.ssh/id_rsa.pub public ssh_key already exist
    else
        echo Generating new ssh_key - press enter to save to default directory
        generate_ssh
    fi

    cat $HOME/.ssh/id_rsa.pub
    echo "Now add the ssh key via web"
    echo "https://bitbucket.org/account/user/gr4viton/ssh-keys/"
}


git_delete_and_recheckout_current_branch() {
    # if the diff is empty
    # - deletes current branch, pulls origin, checkout it again
    cur=`git rev-parse --abbrev-ref HEAD`
    echo Current branch = $cur
    git checkout master
    git branch -D $cur
    git pull
    git checkout $cur
}

alias git__branches_all="git branch | sed 's|* |  |' | sort"
alias git__branches_remote="git branch -r | sed 's|origin/||' | sort"

alias git_branch_only_local_without_remote="comm -23 <(git__branches_all) <(git__branches_remote)"
#alias git_branch_only_local_without_remote="comm -23 <(git branch | sed 's|* |  |' | sort) <(git branch -r | sed 's|origin/||' | sort )"
# not functional when the alias is made of it
# alias git_branch_only_local_without_remote="git branch -vv | grep -v origin | awk '{print $1}'"


alias gitcal_mine='git cal --author=daniel.davidek'


git_rebase_interactive_till_master() {
    current_branch=`git_current_branch`
    git fetch
    first_common_ancestor=`git merge-base $current_branch origin/master`
    git rebase -i $first_common_ancestor
}

# autocomplete
git_autocomplete_rc="/usr/share/bash-completion/completions/git"
if [[ -f $git_autocomplete_rc ]]; then
source $git_autocomplete_rc
fi


# search in commits
git_search () {
    set -x
    git log $@
    set +x
}

git_search_in_all_commits_current_branch () {
    git_search -S "$1" --source
}
git_search_in_all_commits_current_branch_patch () {
    git_search -S "$1" --source --patch
}
git_search_in_all_commits_all_branches () {
    git_search -S "$1" --source --all
}
git_search_in_all_commits_all_branches_patch () {
    git_search -S "$1" --source --patch -all
}

git_regex_in_all_commits_current_branch () {
    git_search -G "$1" --source
}
git_regex_in_all_commits_current_branch_patch () {
    git_search -G "$1" --source --patch
}
git_regex_in_all_commits_all_branches () {
    git_search -G "\"$1\"" --source --all --patch
}
git_regex_in_all_commits_all_branches_patch () {
    git_search -G "\"$1\"" --source --all --patch
}



# git
GIT_ALIAS_FILE="$HOME/.gitconfig"

git_alias_set () {
	ABBREV="${1:?abbreviation}"
	COMMAND="${2:?abbreviation}"
	git config --global alias.$ABBREV $COMMAND
}

git_alias_show () {
	cat $GIT_ALIAS_FILE
}

git_alias_open () {
	vim $GIT_ALIAS_FILE
}
