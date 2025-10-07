#!/bin/bash
# __git__

# git
# alias gdiff='git diff --color-words'

alias git_current_branch="git rev-parse --abbrev-ref HEAD"

git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

git_branch_cutted() {
    # returns only the last part after '/' of current branch name
    git_branch | sed 's:.*/::'
}

# gpl () {
    # git pull --rebase origin master
# }
gpr () {
    git pull --rebase origin master
}
gprbranch () {
    # concrete branch
    git pull --rebase origin "$(1)"
}
gprb () {
    # current branch
    git pull --rebase origin "$(git_branch)"
}
gprmain () {
    git pull --rebase origin main
}

gife () { git fetch ; }
gifeo () { git fetch origin ; }

giad () { git add "$@" ; }
giau () { git add -u "$@" ; }
giap () { git add -p "$@" ; }

gico () { git commit "$@" ; }
gica () { git commit --amend "$@" ; }

gicono () {
    git commit --no-verify "$@"
}
giconoa () {
    git commit --no-verify --amend "$@"
}
gicano () {
    git commit --no-verify --amend "$@"
}
giconopre () {
    PRE_COMMIT_ALLOW_NO_CONFIG=1 git commit "$@"
}

gireabort () { git rebase --abort ; }
girecontinue () { git rebase --continue ; }
gire_edit_split () {
    echo "This command moves the HEAD and branch pointer back one commit,"
    echo "effectively "uncommitting" the changes but leaving them in your working directory."
    git reset HEAD^
    git status
    echo "Now interactive add by-parts - only add one portion of the files you want to keep in the commit"
    git add -p
    echo "Now commit, then add and commit the other changes in a separate commit (if you want) and then girecontinue"
}

gist () {
    git status
}

gpff () {
    # f like full
    date_rfc_3339
    git push --force-with-lease --force-if-includes "$@"
}

gpfs () {
    # s - like skip
    gpff "-o ci.skip"
}

gpffn () {
    # push new branch
    # fn = like full and new
    git push --set-upstream origin $(git_branch) "$@"
}
gpfsn () {
    # push new branch without ci pipeline start
    # sn = like skip pipe and new
    gpfF "-o ci.skip"
}


gidi () {
    git diff "$@"
}
gidiw () {
    git diff --color-words "$@"
}
gidimr () {
    # changes like in MR
    # ... from common ancestor
    git diff master...$(git_branch) "$@"
}
gidis () {
    gis
    gidi
}
gis () {
    git status
}

glog () {
    set -x
    git log --stat "$@"
    set +x
}
glogmr () {
    # changes like in MR
    # ... from common ancestor
    set -x
    git log master...$(git_branch) -p "$@"
    set +x
}
glog1 () {
    set -x
    git log --pretty=oneline "$@"
    set +x
}
glogp () {
    set -x
    git log --stat --patch "$@"
    set +x
}
glogrep () {

    if [ $# -eq 0 ]; then
        echo "Usage: glog <grep_pattern> [additional git log options]"
        return 1
    fi

    grep_pattern="$1"
    shift  # Remove the first argument (grep pattern) from the argument list
    set -x
    git log --stat --perl-regexp --grep="$grep_pattern" "$@"
    set +x
}
glogrepp () {  # lol glurp
    set -x
    glogrep --patch "$@"
    set +x
}
glogpword () {
    set -x
    git log --stat --patch --word-diff "$@"
    set +x
}
glogpporcelain () {
    set -x
    git log --stat --patch --word-diff=porcelain "$@"
    set +x
}
glogfiles () {
    set -x
    git ls-files "$@"
    set +x
}

# git

glogdd () {
    # git branch --sort=-committerdate
    # the same
    set -x
    git for-each-ref --format='%(refname:short)' refs/heads/** --sort=-committerdate
    set +x
}

glogd () {
    set -x
    glogdd | head -20
    set +x
}


glogd_get () {
    set -x
    num="${1:?number of line - first = 1}"
    sed -n "${num}p" <(glogdd)
    set +x
}
git_install_gci () {
    echo "install the git checkout interactive"
    npm install --global git-checkout-interactive
}
gic () {
    # interactvie checkout of branches
    gci
}

gim () {
    git checkout master
}
gimain () {
    git checkout main
}

git_delete_merged_branches () {
    git checkout master && git branch -d $(git branch --merged | tr '*' ' ' | tr 'master' ' ')
}
alias gloghash='git log --pretty=format:"%h %s"'

glog2 () {
    git log --decorate --oneline --graph;
}
glog2a () {
    git log --all --decorate --oneline --graph;
}

glog3 () {
    set -x
    git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' "$@";
    set +x
}
glog3a () {
    glog3 --all
}
glog4 () {
    set -x
    git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' "$@";
    set +x
}

glog4a () {
    glog4 --all
}
alias gir="git rebase"


giri () {  # git rebase
    git rebase --interactive HEAD~$1
}
giri_root () {
    git rebase -i --root
}
giri2 () { giri 2 ; }
giri3 () { giri 3 ; }
giri4 () { giri 4 ; }
giri5 () { giri 5 ; }

gir_conflict_files () {
    set -x
    git diff --name-only --diff-filter=U
    set +x
}
vigir_conflict_files () {
    vim $(git diff --name-only | uniq)
}
giriv () {
    vigir_conflict_files
}


gir_onto_commit_keeping_current_branch () {
    git rebase --onto $1 --root=$(git_branch)
}
gir_rebase_merges_on_remote_master () {
    # rebase to origin master preserving merge commits
    git fetch
    git rebase --rebase-merges origin/master
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

git_aliases_init () {
    git config --global alias.co checkout
    git config --global alias.ca "commit --amend"
    git config --global alias.br branch
    git config --global alias.cm commit
    git config --global alias.st status
    git config --global pull.rebase true
    #git config --global alias.pushf "push --force-with-lease"
}

git_iam_gr4viton_global () {
    git_aliases_init
    git_set_global $ENV_DD_MY_GIT_USER $ENV_DD_MY_GIT_EMAIL
}
git_iam_gr4viton () {
    git_aliases_init
    git_set_global $ENV_DD_MY_GIT_USER $ENV_DD_MY_GIT_EMAIL
}

git_iam_kiwi () {
    git_aliases_init
    git_set_global $ENV_KW_MY_GIT_USER $ENV_KW_MY_GIT_EMAIL
}

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


git_recheckout_current_branch() {
    cur=`git rev-parse --abbrev-ref HEAD`
    echo Current branch = $cur
    git checkout master
    git branch -D $cur
    git pull
    git checkout $cur
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

git_override_remote_master_with_local_master () {
    # be sure the remote master is not needed - as it will be overriden
    git branch --set-upstream-to=origin/master master
    gpf
}

# autocomplete
git_autocomplete_rc="/usr/share/bash-completion/completions/git"
if [[ -f $git_autocomplete_rc ]]; then
source $git_autocomplete_rc
fi


git_cap () {
    # just tried if it works
    datt="$(date_rfc_3339_date)T00:$(date +'%M:%S')"; GIT_COMMITTER_DATE=$datt git commit --amend --date=$datt
}


# search in commits
git_search () {
    set -x
    git log "$@"
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


git_mv_snake_case_to_dash_case () {
    for file in ./* ; do git mv "$file" "$(echo $file|sed -e 's/_/-/g')"; done
}

git_remote_list () {
    git remote -v
}
git_remote_add_origin () {
    # remote_name = origin
    git remote add origin "$@"
    git_remote_list
}
git_remote_rm_origin () {
    git_remote_list
    echo "> removing origin"
    git remote rm origin
    git_remote_list
}

git_remote_set_ssh_github () {
    repo_name="${1?Repository name required}"
    git_remote_rm_origin
    git_remote_add_origin $(git_remote_url_ssh_github "$repo_name")
}
git_remote_set_ssh_gitlab () {
    repo_name="${1?Repository name required}"
    git_remote_rm_origin
    git_remote_add_origin $(git_remote_url_ssh_gitlab "$repo_name")
}
git_remote_set_ssh_kiwi () {
    repo_name="${1?Repository name required}"
    git_remote_rm_origin
    git_remote_add_origin $(git_remote_url_ssh_kw "$repo_name")
}

git_push_upstream_origin_master () {
    git push --set-upstream origin master
}

git_remove_from_whole_history_file () {
    file_name="${1:?file name needed}"
    git filter-branch --index-filter "git rm --cached --ignore-unmatch $file_name" HEAD
}

git_remote_url_ssh_gitlab () {
    # pass: gr4viton.gitlab.io
    # get: git@gitlab.com:gr4viton/gr4viton.gitlab.io.git
    echo "git@gitlab.com:gr4viton/$1.git"
}
git_remote_url_ssh_github () {
    echo "git@github.com:gr4viton/$1.git"
}
git_remote_url_ssh_kw () {
    echo "git@skypicker.com:daniel.davidek/$1.git"
}

git_clone_gitlab () {
    git clone $(git_remote_url_ssh_gitlab $1)
}

git_clone_github () {
    git clone $(git_remote_url_ssh_github $1)
}

git_fix_permissions () {
	# https://stackoverflow.com/a/7849784
cd .git/objects
ls -al
sudo chown -R dd:dd *
}

gib () {
    git co -b "$@"
}

gig () {
    GREP="$1"
    shift
    git log --grep="$GREP" "$@"
}
gip () {
    GREP="$1"
    shift
    git log --grep="$GREP" -p "$@"
}

gife_short () {
    echo "Fetching updates from remote..."
    git fetch --all --prune > /dev/null
}


gib_merged_list_no () {
    # all branches merged in origin/master
    gife_short
    git branch --merged origin/master | grep -v "^\*" | grep -v "master"
}
gib_merged_delete_no () {
    gife_short
    git branch --merged origin/master | grep -v "^\*" | grep -v "master" | xargs -n 1 git branch -d
}

gib_merged_delete() {
    gife_short

    echo "Listing local branches fully merged into origin/master:"
    branches_to_delete=$(git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads/ |
    while read branch track; do
        if [[ "$branch" != "master" && "$branch" != "main" ]]; then
            if git merge-base --is-ancestor $branch origin/master; then
                echo $branch
            fi
        fi
    done)


    if [ -z "$branches_to_delete" ]; then
        echo "No branches to delete."
        return 0
    fi

    echo "$branches_to_delete"
    echo ""

    read -p "Do you want to delete these branches? (y/N): " confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        echo "Deleting branches..."
        echo "$branches_to_delete" | xargs git branch -d
        echo "Branches deleted."
    else
        echo "Operation cancelled. No branches were deleted."
    fi
}
gib_tmp_list () {
    # all branches without origin counterpart with tmp prefix
    gife_short


    git branch -vv | grep -v '\[origin/' | grep -E '^(tmp|temp)|/(tmp|temp)|-(tmp|temp)|(tmp|temp)$' | awk '{print $1}'
}
gib_tmp_delete() {
    # all branches without origin counterpart with tmp prefix
    gife_short

    echo "Listing temporary branches not in remote:"
    branches_to_delete=$(git branch -vv | grep -v '\[origin/' | grep -E '^(tmp|temp)|/(tmp|temp)|-(tmp|temp)|(tmp|temp)$' | awk '{print $1}')



    if [ -z "$branches_to_delete" ]; then
        echo "No temporary branches to delete."
        return 0
    fi

    echo "$branches_to_delete"
    echo ""

    read -p "Do you want to delete these branches? (y/N): " confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        echo "Deleting branches..."
        echo "$branches_to_delete" | xargs git branch -D
        echo "Branches deleted."
    else
        echo "Operation cancelled. No branches were deleted."
    fi
}

gib_localonly_list () {
    # all branches without origin counterpart with tmp prefix
    gife_short
    git branch -vv | grep -v '\[origin/' | awk '{print $1}'
}
gib_localonly_delete() {
    # all branches without origin counterpart with tmp prefix
    gife_short

    echo "Listing temporary branches not in remote:"
    branches_to_delete=$(git branch -vv | grep -v '\[origin/' | awk '{print $1}')


    if [ -z "$branches_to_delete" ]; then
        echo "No temporary branches to delete."
        return 0
    fi

    echo "$branches_to_delete"
    echo ""

    read -p "Do you want to delete these branches? (y/N): " confirm

    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        echo "Deleting branches..."
        echo "$branches_to_delete" | xargs git branch -D
        echo "Branches deleted."
    else
        echo "Operation cancelled. No branches were deleted."
    fi
}

gib_unpushed_list() {
    gife_short

    echo "Listing local branches with unpushed commits:"
    git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads/ |
    while read local remote; do
        if [[ -n "$remote" ]]; then
            if git rev-parse --verify $remote &>/dev/null; then
                ahead=$(git rev-list --count $remote..$local)
                if [[ $ahead -gt 0 ]]; then
                    echo "(ahead by $ahead commit(s)     : $local"
                fi
            else
                    echo "(no remote counterpart)    : $local"
            fi
        else
                    echo "(no remote tracking branch): $local"
        fi
    done
}
gib_localahead_list() {
    gife_short

    echo "Listing local branches with unpushed commits to existing remote branches:"
    git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads/ |
    while read local remote; do
        if [[ -n "$remote" ]]; then
            if git rev-parse --verify $remote &>/dev/null; then
                ahead=$(git rev-list --count $remote..$local)
                if [[ $ahead -gt 0 ]]; then
                    printf "Local ahead by %3d commit(s): %s \n" $ahead "$local"
                fi
            fi
        fi
    done
}


gib_localahead_table() {
    gife_short

    echo "Listing branches with unpushed commits:"
    printf "%7s | %7s | %7s | %-30s\n" "Local" "Origin" "Unpushed" "Branch"
    printf "%s\n" "---------|---------|----------|---------------------------------"
    git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads/ |
    while read local remote; do
        if [[ -n "$remote" && "$local" != "master" && "$local" != "main" ]]; then
            if git rev-parse --verify $remote &>/dev/null; then
                # Find the common ancestor of local branch and local master
                local_base=$(git merge-base $local master)
                # Count commits from common ancestor to local branch
                local_commits=$(git rev-list --count $local_base..$local)

                # Find the common ancestor of remote branch and origin/master
                remote_base=$(git merge-base $remote origin/master)
                # Count commits from common ancestor to remote branch
                origin_commits=$(git rev-list --count $remote_base..$remote)

                # Count unpushed commits
                ahead=$(git rev-list --count $remote..$local)

                if [[ $ahead -gt 0 ]]; then
                    printf "%7d | %7d | %7d | %-30s\n" $local_commits $origin_commits $ahead "$local"
                fi
            fi
        fi
    done
}

git_remove_ALL_without_origin_branch_USE_WITH_CARE () {
    gife_short
    git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}


glogstat () {
    set -x
  glog --stat --oneline  "${@}"
    set +x
}
glognumstat () {
    set -x
  glog --numstat --oneline  "${@}"
    set +x
}

gitouch () {
    folder="$1"
    fname="$folder/__init_.py"
    mkdir -p "$folder" && touch "$fname" && git add "$fname"
}
