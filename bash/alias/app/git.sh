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

git_repo_name() {
  basename -s .git "$(git config --get remote.origin.url 2>/dev/null)" \
    || basename "$(git rev-parse --show-toplevel)"
}

git_branch_default () {
  git config --get init.defaultBranch || echo "master"
}
git_branch_main_is_default () {
  git config init.defaultBranch main
}
git_branch_master_is_default () {
  git config init.defaultBranch master
}

gpr () {
    git pull --rebase origin $(git_branch_default)
}
gprbranch () {
    # concrete branch
    git pull --rebase origin "$(1)"
}
gprb () {
    # current branch
    git pull --rebase origin "$(git_branch)"
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
    git status "$@"
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

gpfnf () {
    # push new branch
    # fn = like full and new
    git push --set-upstream origin $(git_branch) "$@"
}
gpfns () {
    # push new branch without ci pipeline start
    # sn = like skip pipe and new
    gpfnf "-o ci.skip"
}


gidi () {
    git diff "$@"
    # force less to avoid anti-UX behavior dependent on diff length - then CTRL-D killing the terminal...
    # Skip less entirely if diff is empty
    # if git diff --quiet "$@" 2>/dev/null; then
    #     return
    # fi
    # # Force less to always open (no auto-quit on short diffs)
    # LESS="-RX" git diff "$@"
}

gidiw () {
    LESS="-RX" git diff --color-words "$@"
}
gidimr () {
    # changes like in MR
    # ... from common ancestor
    LESS="-RX" git diff $(git_branch_default)...$(git_branch) "$@"
}
gidimrfiles () {
    git diff --name-only $(git_branch_default)...$(git_branch) "$@"
}

prerunchanged () {
    pre-commit run --files $(gidimrfiles | grep '\.py$') "$@"
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
    git log $(git_branch_default)...$(git_branch) -p "$@"
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
    # gci  # what was the name of the tool? anyway
    #git branch --sort=-committerdate | fzf | xargs git checkout
    # there were prefixes + *
    git branch --sort=-committerdate | fzf | sed 's/^[ *+]*//' | xargs git checkout
}

gim () {
  git checkout $(git_branch_default)
}

git_delete_merged_branches () {
    git checkout $(git_branch_default) && git branch -d $(git branch --merged | tr '*' ' ' | tr "$(git_branch_default)" ' ')
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
girip () { giri 15 ; }

gir_conflict_files () {
    set -x
    git diff --name-only --diff-filter=U
    set +x
}
vigir_conflict_files () {
    vim $(git diff --name-only | uniq)
}
vigi () {
  # same as vigir_conflict_files
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
    git rebase --rebase-merges origin/$(git_branch_default)
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
    git checkout $(git_branch_default)
    # git branch -D $cur
    git pull
    git checkout $cur
}

git_delete_and_recheckout_current_branch() {
    # if the diff is empty
    # - deletes current branch, pulls origin, checkout it again
    cur=`git rev-parse --abbrev-ref HEAD`
    echo Current branch = $cur
    git checkout $(git_branch_default)
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
    first_common_ancestor=`git merge-base $current_branch origin/$(git_branch_default)`
    git rebase -i $first_common_ancestor
}

git_override_remote_master_with_local_master () {
    # be sure the remote master is not needed - as it will be overriden
    git branch --set-upstream-to=origin/$(git_branch_default) $(git_branch_default)
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

git_push_upstream_origin_master () {
    git push --set-upstream origin $(git_branch_default)
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
    git branch --merged origin/$(git_branch_default) | grep -v "^\*" | grep -v "$(git_branch_default)"
}
gib_merged_delete_no () {
    gife_short
    git branch --merged origin/$(git_branch_default) | grep -v "^\*" | grep -v "$(git_branch_default)" | xargs -n 1 git branch -d
}

gib_merged_delete() {
    gife_short

    echo "Listing local branches fully merged into origin/$(git_branch_default):"
    branches_to_delete=$(git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads/ |
    while read branch track; do
        if [[ "$branch" != "$(git_branch_default)" && "$branch" != "main" ]]; then
            if git merge-base --is-ancestor $branch origin/$(git_branch_default); then
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
        if [[ -n "$remote" && "$local" != "$(git_branch_default)" && "$local" != "main" ]]; then
            if git rev-parse --verify $remote &>/dev/null; then
                # Find the common ancestor of local branch and local $(git_branch_default)
                local_base=$(git merge-base $local $(git_branch_default))
                # Count commits from common ancestor to local branch
                local_commits=$(git rev-list --count $local_base..$local)

                # Find the common ancestor of remote branch and origin/$(git_branch_default)
                remote_base=$(git merge-base $remote origin/$(git_branch_default))
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


git_check_merged_branch() {
  # has issues
    # Function to check if a local branch has been merged to master.
    # Uses a temporary git worktree to avoid modifying the original branch.
    #
    # Usage: check_merged_branch <branch_name>
    # Returns: branch name if merged, nothing if not merged or on error
    local branch_name="$1"
    
    # Validate input
    if [[ -z "$branch_name" ]]; then
        echo "Usage: check_merged_branch <branch_name>" >&2
        return 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    
    # Check if branch exists locally
    if ! git show-ref --verify --quiet "refs/heads/$branch_name"; then
        echo "Error: Branch '$branch_name' does not exist locally" >&2
        return 1
    fi
    
    # Fetch master to ensure we have latest
    if ! git fetch origin master:master 2>/dev/null; then
        # If fetch fails, try to update master from current branch
        git fetch origin master 2>/dev/null || true
    fi
    
    # Ensure we have a local master branch
    if ! git show-ref --verify --quiet "refs/heads/master"; then
        # Create local master tracking origin/master
        git branch master origin/master 2>/dev/null || {
            echo "Error: Could not access master branch" >&2
            return 1
        }
    fi
    
    # Update local master
    git fetch origin master:master 2>/dev/null || true
    
    # Create a unique temporary worktree directory
    local worktree_dir
    worktree_dir=$(mktemp -d -t "git-worktree-${branch_name}-XXXXXX")
    local cleanup_worktree=true
    local test_branch=""
    
    # Cleanup function
    cleanup() {
        # Delete test branch if it was created
        if [[ -n "$test_branch" ]]; then
            git branch -D "$test_branch" 2>/dev/null || true
        fi
        # Remove worktree (this also removes the directory)
        if [[ "$cleanup_worktree" == "true" ]] && [[ -d "$worktree_dir" ]]; then
            git worktree remove -f "$worktree_dir" 2>/dev/null || rm -rf "$worktree_dir"
        fi
    }
    
    # Set trap to cleanup on exit
    trap cleanup EXIT
    
    # Create worktree for the branch
    if ! git worktree add "$worktree_dir" "$branch_name" >/dev/null 2>&1; then
        echo "Error: Failed to create worktree for branch '$branch_name'" >&2
        return 1
    fi
    
    # Change to worktree directory
    cd "$worktree_dir" || {
        echo "Error: Failed to change to worktree directory" >&2
        return 1
    }
    
    # Update master in worktree context
    git fetch origin master:master >/dev/null 2>&1 || true
    
    # Find the merge base with master (where branch diverged)
    local merge_base
    merge_base=$(git merge-base master HEAD 2>/dev/null)
    
    if [[ -z "$merge_base" ]]; then
        # If no merge base, branches might be unrelated
        # Check if branch is already at master
        if git diff --quiet master HEAD; then
            # Branch is identical to master
            echo "$branch_name"
            return 0
        else
            # Unrelated branches, consider not merged
            return 1
        fi
    fi
    
    # Check if branch is already at merge base (no commits)
    if git diff --quiet "$merge_base" HEAD; then
        # Branch has no commits beyond merge base
        echo "$branch_name"
        return 0
    fi
    
    # Check if branch is already at master (fast-forward case)
    if git merge-base --is-ancestor HEAD master 2>/dev/null; then
        # Branch is behind or at master
        if git diff --quiet master HEAD; then
            echo "$branch_name"
            return 0
        fi
    fi
    
    # Create a temporary branch for testing (in worktree, this is isolated)
    test_branch="MERGE_TEST-${branch_name}-$$"
    if ! git checkout -b "$test_branch" >/dev/null 2>&1; then
        echo "Error: Failed to create test branch" >&2
        return 1
    fi
    
    # Squash all commits from merge base to branch tip into one commit
    # We use reset --soft to merge base, then create a new commit with all changes
    # Reset to merge base but keep all changes staged
    if ! git reset --soft "$merge_base" >/dev/null 2>&1; then
        echo "Error: Failed to reset to merge base" >&2
        return 1
    fi
    
    # Check if there are any changes to commit
    if git diff --cached --quiet; then
        # No changes to commit, branch is already merged
        echo "$branch_name"
        return 0
    fi
    
    # Create the squash commit
    if ! git commit -m "Squashed branch changes for merge test" --no-verify >/dev/null 2>&1; then
        echo "Error: Failed to create squash commit" >&2
        return 1
    fi
    
    # Fetch latest master again before rebase
    git fetch origin master:master >/dev/null 2>&1 || true
    
    # Rebase onto current master
    if ! git rebase master >/dev/null 2>&1; then
        # Rebase failed, likely due to conflicts or changes
        # Abort the rebase
        git rebase --abort >/dev/null 2>&1
        return 1
    fi
    
    # Check if there are any changes compared to master
    if git diff --quiet master HEAD; then
        # No differences, branch is merged
        echo "$branch_name"
        return 0
    else
        # There are differences, branch is not fully merged
        return 1
    fi
}



git_smart_cleanup() {
  # works
    # Function to remove all local branches starting with 'tmp-' prefix
    #
    # Usage: git_smart_cleanup [--force]
    #   --force: Skip confirmation prompt
    
    local force=false
    if [[ "$1" == "--force" ]]; then
        force=true
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    
    # Get all local branches starting with 'tmp-'
    local tmp_branches
    tmp_branches=$(git branch --format='%(refname:short)' | grep '^tmp-' || true)
    
    if [[ -z "$tmp_branches" ]]; then
        echo "No branches with 'tmp-' prefix found."
        return 0
    fi
    
    # Count branches
    local count
    count=$(echo "$tmp_branches" | wc -l | tr -d ' ')
    
    echo "Found $count branch(es) with 'tmp-' prefix:"
    echo "$tmp_branches" | sed 's/^/  - /'
    
    # Ask for confirmation unless --force is used
    if [[ "$force" != "true" ]]; then
        echo ""
        echo "Delete these branches? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Cancelled."
            return 0
        fi
    fi
    
    # Delete each branch
    local deleted=0
    local failed=0
    
    while IFS= read -r branch; do
        [[ -z "$branch" ]] && continue
        
        if git branch -D "$branch" 2>/dev/null; then
            echo "Deleted: $branch"
            ((deleted++))
        else
            echo "Failed to delete: $branch" >&2
            ((failed++))
        fi
    done <<< "$tmp_branches"
    
    echo ""
    echo "Summary: $deleted deleted, $failed failed"
    
    if [[ $failed -gt 0 ]]; then
        return 1
    fi
    return 0
}

git_worktree_cd() {
    # Fuzzy finder for git worktrees - quickly navigate to any worktree
    # Usage: git-worktree-cd [or alias as 'gcd' or 'wtcd']
    #
    # Requires: fzf (fuzzy finder)
    # Install fzf: https://github.com/junegunn/fzf
    #
    # Get the main git repository root (where .git is)
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)
    
    if [[ -z "$git_root" ]]; then
        echo "Error: Not in a git repository" >&2
        return 1
    fi
    
    # Get all worktrees using git worktree list
    local worktrees
    worktrees=$(git -C "$git_root" worktree list --porcelain 2>/dev/null)
    
    if [[ -z "$worktrees" ]]; then
        echo "No worktrees found" >&2
        return 1
    fi
    
    # Parse worktree list and format for fzf
    # Format: "path | branch/commit | status"
    local selection
    selection=$(echo "$worktrees" | awk '
        /^worktree / { path = $2; next }
        /^HEAD / { head = $2; next }
        /^branch / { branch = $2; gsub(/refs\/heads\//, "", branch); next }
        /^detached/ { branch = "detached HEAD"; next }
        /^$/ {
            if (path != "") {
                # Get short commit hash
                short_hash = substr(head, 1, 7)
                # Get last part of path for display
                path_display = path
                gsub(/.*\//, "", path_display)
                printf "%s | %s | %s\n", path, branch, short_hash
            }
            path = ""; head = ""; branch = ""
        }
        END {
            if (path != "") {
                short_hash = substr(head, 1, 7)
                path_display = path
                gsub(/.*\//, "", path_display)
                printf "%s | %s | %s\n", path, branch, short_hash
            }
        }
    ' | fzf --height=40% --layout=reverse --border \
        --header="Select a worktree to navigate to" \
        --preview='git -C {1} log --oneline -10 2>/dev/null || echo "No git log"' \
        --preview-window=right:40% \
        --bind='ctrl-/:change-preview-window(down:50%:wrap)' \
        --delimiter='|' \
        --with-nth=1,2,3)
    
    if [[ -z "$selection" ]]; then
        # User cancelled
        return 1
    fi
    
    # Extract the path (first field before |)
    # Strip any leading * or + symbols and whitespace
    local selected_path
    selected_path=$(echo "$selection" | awk -F' | ' '{print $1}' | sed 's/^[*+[:space:]]*//')
    
    if [[ -d "$selected_path" ]]; then
        cd "$selected_path" || return 1
        echo "Changed to: $selected_path"
        # Optionally show git status
        if [[ -n "$GIT_WORKTREE_CD_SHOW_STATUS" ]]; then
            git status --short
        fi
    else
        echo "Error: Worktree path does not exist: $selected_path" >&2
        return 1
    fi
}

alias gicd="git_worktree_cd"
giwnew () {
  giwnewname "$(git_branch)$@"
}
giwnewname () {
  # creates a new worktree based on currently checked out branch (HEAD) with a new branch name passed as an argument
  git worktree add -b "$@" "/tmp/giw/$@" HEAD
}
giwnew_branch_path () {
  git worktree add -b "$1" "$2" HEAD
}

# git stash
gispush () {
  # stash the files
  # example:
  # $ gisp path/to/your/file.ext path/to/your/file2.ext
  git stash -u -- "$@"
}
gismerge0 () {
  # overwrite local with the stash
  git merge --squash --strategy-option=theirs stash@{0}
}

gisdiff0 () {
  # also `gisdiff0 -- file/path.ext
  git diff stash@{0} "$@"
}

gislist () {
  git stash list
}

gisdrop0 () {
  git stash drop stash@{0}
}

# Apply git mv for parallel src/dst arrays. Uses explicit status checks so a failed
# git mv never trips errexit and closes an interactive shell (see gimv_* callers).
_gimv_apply_git_mv () {
  local -n _gimv_srcs=$1
  local -n _gimv_dsts=$2
  local i mv_failed=0
  for ((i = 0; i < ${#_gimv_srcs[@]}; i++)); do
    if ! mkdir -p "$(dirname -- "${_gimv_dsts[i]}")"; then
      echo "ERROR: mkdir -p failed for $(dirname -- "${_gimv_dsts[i]}")" >&2
      mv_failed=1
      continue
    fi
    if ! git mv -- "${_gimv_srcs[i]}" "${_gimv_dsts[i]}"; then
      echo "ERROR: git mv failed: ${_gimv_srcs[i]} -> ${_gimv_dsts[i]}" >&2
      mv_failed=1
    fi
  done
  if ((mv_failed)); then
    return 1
  fi
  return 0
}

gimv_simple () {
  local from="$1"
  local to="$2"

  if [ -z "$from" ] || [ -z "$to" ]; then
    echo 'Usage: gimv "seg1 seg2 ..." "seg1 seg2 ..."'
    return 2
  fi
  command -v git >/dev/null 2>&1 || { echo "git not found"; return 127; }

  local -a A B
  read -r -a A <<< "$from"
  read -r -a B <<< "$to"

  local from_suffix="${A[0]}" i
  for ((i=1; i<${#A[@]}; i++)); do from_suffix+="/${A[i]}"; done

  local to_suffix="${B[0]}"
  for ((i=1; i<${#B[@]}; i++)); do to_suffix+="/${B[i]}"; done

  mapfile -d '' dirs < <(find . -type d -path "*/$from_suffix" -print0)
  ((${#dirs[@]} == 0)) && { echo "No directories matched */$from_suffix"; return 0; }

  local -a srcs dsts
  local d f rel base dst
  for d in "${dirs[@]}"; do
    base="${d%/$from_suffix}"

    while IFS= read -r -d '' f; do
      # Skip __pycache__ and .pyc
      case "$f" in
        *"/__pycache__/"*|*.pyc) continue ;;
      esac

      rel="${f#"$d"/}"
      dst="$base/$to_suffix/$rel"
      srcs+=("$f")
      dsts+=("$dst")
    done < <(find "$d" -type f -print0)
  done

  ((${#srcs[@]} == 0)) && { echo "No files to move (after filtering)."; return 0; }

  echo "Will move these files (git mv):"
  for ((i=0; i<${#srcs[@]}; i++)); do
    printf '  %s -> %s\n' "${srcs[i]}" "${dsts[i]}"
  done
  echo

  printf 'Proceed (y/n)? '
  read -r answer
  [[ "$answer" =~ ^[Yy]$ ]] || { echo "No."; return 0; }

  _gimv_apply_git_mv srcs dsts
  return $?
}

# --- original folder mover (your previous gimv_only logic), renamed ---
gimv_folder () {
  local from="$1"
  local to="$2"

  if [ -z "$from" ] || [ -z "$to" ]; then
    echo 'Usage: gimv_move "seg1 seg2 ..." "seg1 seg2 ..."'
    return 2
  fi
  command -v git >/dev/null 2>&1 || { echo "git not found"; return 127; }

  local -a A B
  read -r -a A <<< "$from"
  read -r -a B <<< "$to"

  local from_suffix="${A[0]}" i
  for ((i=1; i<${#A[@]}; i++)); do from_suffix+="/${A[i]}"; done

  local to_suffix="${B[0]}"
  for ((i=1; i<${#B[@]}; i++)); do to_suffix+="/${B[i]}"; done

  mapfile -d '' dirs < <(find . -type d -path "*/$from_suffix" -print0)
  ((${#dirs[@]} == 0)) && { echo "No directories matched */$from_suffix"; return 0; }

  local -a srcs dsts
  local d f rel base dst
  for d in "${dirs[@]}"; do
    base="${d%/$from_suffix}"

    while IFS= read -r -d '' f; do
      # Skip caches/bytecode
      case "$f" in
        *"/__pycache__/"*|*.pyc) continue ;;
      esac

      rel="${f#"$d"/}"
      dst="$base/$to_suffix/$rel"
      srcs+=("$f")
      dsts+=("$dst")
    done < <(find "$d" -type f -print0)
  done

  ((${#srcs[@]} == 0)) && { echo "No files to move (after filtering)."; return 0; }

  echo "Will move these files (git mv):"
  for ((i=0; i<${#srcs[@]}; i++)); do
    printf '  %s -> %s\n' "${srcs[i]}" "${dsts[i]}"
  done
  echo

  printf 'Proceed with git mv (y/n)? '
  read -r answer
  [[ "$answer" =~ ^[Yy]$ ]] || { echo "No."; return 1; }  # return 1 = user said no

  _gimv_apply_git_mv srcs dsts
  return $?
}

# --- new: file mover (moves matching */from_file to */to_file) ---
gimv_file () {
  local from="$1"
  local to="$2"
  local answer="$3"

  if [ -z "$from" ] || [ -z "$to" ]; then
    echo 'Usage: gimv_file "seg1 seg2 file.ext" "seg1 seg2 ... newfile.ext"'
    return 2
  fi
  command -v git >/dev/null 2>&1 || { echo "git not found"; return 127; }

  local -a A B
  read -r -a A <<< "$from"
  read -r -a B <<< "$to"

  local from_suffix="${A[0]}" i
  for ((i=1; i<${#A[@]}; i++)); do from_suffix+="/${A[i]}"; done

  local to_suffix="${B[0]}"
  for ((i=1; i<${#B[@]}; i++)); do to_suffix+="/${B[i]}"; done

  # Find all matching files anywhere under PWD
  mapfile -d '' srcs < <(find . -type f -path "*/$from_suffix" -print0)
  ((${#srcs[@]} == 0)) && { echo "No files matched */$from_suffix"; return 0; }

  local -a dsts
  local s base dst
  for s in "${srcs[@]}"; do
    # Skip caches/bytecode
    case "$s" in
      *"/__pycache__/"*|*.pyc) continue ;;
    esac

    base="${s%/$from_suffix}"
    dst="$base/$to_suffix"
    dsts+=("$dst")
  done

  ((${#dsts[@]} == 0)) && { echo "No files to move (after filtering)."; return 0; }

  echo "Will move these files (git mv):"
  for ((i=0; i<${#dsts[@]}; i++)); do
    printf '  %s -> %s\n' "${srcs[i]}" "${dsts[i]}"
  done
  echo

  [[ "$answer" =~ ^[Yy]$ ]] || printf 'Proceed with git mv (y/n)? ' && read -r answer
  [[ "$answer" =~ ^[Yy]$ ]] || { echo "No."; return 1; }

  _gimv_apply_git_mv srcs dsts
  return $?
}

# --- gimv: decide folder vs file, then (if moved) run regexpath with suffix-stripped tokens ---
gimv () {
  local from="$1"
  local to="$2"

  if [ -z "$from" ] || [ -z "$to" ]; then
    echo 'Usage: gimv "seg1 seg2 ..." "seg1 seg2 ..."'
    return 2
  fi

  local -a FA TA
  read -r -a FA <<< "$from"
  read -r -a TA <<< "$to"

  # Decide: if FROM last token contains a dot, treat as file move
  local mover="gimv_folder"
  if [[ "${FA[-1]}" == *.* ]]; then
    mover="gimv_file"
  fi

  $mover "$from" "$to"
  local rc=$?

  # Prepare regexpath args: strip extension from last token if it looks like a filename
  local from_rp="$from"
  local to_rp="$to"

  # add a space after
  if [[ "${FA[-1]}" == *.* ]]; then
    FA[-1]="${FA[-1]%.*}"
    from_rp="${FA[*]} "
  fi
  if [[ "${TA[-1]}" == *.* ]]; then
    TA[-1]="${TA[-1]%.*}"
    to_rp="${TA[*]} "
  fi

  if [ $rc -eq 0 ]; then
    echo
    echo "Now updating references via regexpath..."
    regexpath "$from_rp" "$to_rp"
  elif [ $rc -eq 1 ]; then
    echo "Move cancelled; not running regexpath."
    return 0
  else
    echo "Move failed; not running regexpath."
    return $rc
  fi
}

gisave_to () {
  local count="${1:?usage: export_commits <count> [output-file]}"
  local outfile="${2:-last_${count}_commits.txt}"
  git log -"${count}" --format=fuller -p --stat > "${outfile}"
  echo "Wrote last ${count} commit(s) to ${outfile}"
}

gisave_simple () {
  local count="${1:?usage: export_commits <count> [output-file]}"
  local outfile="branch__$(git_branch).txt"
  git log -"${count}" --format=fuller -p --stat > "${outfile}"
  echo "Wrote last ${count} commit(s) to ${outfile}"
}

gisave () {
  local count="${1:?usage: export_commits <count> [output-file]}"
  local outfile="branch__$(git_branch).txt"
  local repo_name="$(git_repo_name)"
  echo "create MR in ${repo_name} repo with the following commits, MRtitle = first commit message, and branch name the same as this file name (eg branch__dd-asd.txt -> branch = dd-asd)" > "${outfile}"
  git log -"${count}" --format=fuller -p --stat >> "${outfile}"
  echo "Wrote last ${count} commit(s) to ${outfile}"
}
