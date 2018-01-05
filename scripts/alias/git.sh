#!/bin/bash
# git
alias git_initial_setup='git config --global pull.rebase true; git config --global alias.pushf "push --force-with-lease"'
alias pushf='git push --force-with-lease'
alias gdiff='git diff --color-words'
alias gpull_rebase='git pull --rebase origin master'

alias glog='git log --stat'
alias glogp='git log --stat --patch'
alias gsquash2='git rebase --interactive HEAD~2'
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


alias git__branches_all="git branch | sed 's|* |  |' | sort"
alias git__branches_remote="git branch -r | sed 's|origin/||' | sort"

alias git_branch_only_local_without_remote="comm -23 <(git__branches_all) <(git__branches_remote)"
#alias git_branch_only_local_without_remote="comm -23 <(git branch | sed 's|* |  |' | sort) <(git branch -r | sed 's|origin/||' | sort )"
# not functional when the alias is made of it
# alias git_branch_only_local_without_remote="git branch -vv | grep -v origin | awk '{print $1}'"



# autocomplete
source /usr/share/bash-completion/completions/git
