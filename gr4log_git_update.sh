#!/bin/bash
#git config --global credential.helper 'cache --timeout=28800'

set -x

function commit_it {
    git add .
    date=$(date '+%d/%m/%Y %H:%M:%S')
    commit_msg_base="$date: from $(uname -no)"
    commit_msg="$commit_msg_base $1"
    git commit -m "$commit_msg"
    echo ">>> Commited gr4log with commit message"
    echo $commit_msg
}

home="/home/dd/"
main_dir=$home"gr4log/"
cd $main_dir
echo ">>> Saving gr4log in $main_dir"

commit_it "start" 

# COPY CONFIGS
echo ">>> Copying configs"
dotfiles=$main_dir"dotfiles/"
urxvt_to=$dotfiles"urxvt/.Xdefaults"
nvim_to=$dotfiles"nvim/"
tmux_to=$dotfiles"tmux/"

echo ">>> Saving tmux conf"
cp $home".tmux.conf" $tmux_conf

echo ">>> Saving urxvt conf"
cp $home".Xdefaults" $urxvt_to

echo ">>> Saving nvim conf"
nvim_from=$home".config/nvim/"
cp $nvim_from"init.vim" $nvim_to
cp -r $nvim_from"colors" $nvim_to

ls -aR $main_dir"dotfiles"

commit_it "after config copy"

# AFTER PULL
echo $SSH_AUTH_SOCK
git pull -v --no-rebase --progress "origin"

commit_it "after git pull"

git push origin master

# beep
python -c "print('\7')" 

echo ">>> End of $0"

#exit()
