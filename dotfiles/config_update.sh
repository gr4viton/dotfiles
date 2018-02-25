#!/bin/bash

home="/home/$USER/"
main_dir=$home"gr4log/"
cd $main_dir

dotfiles=$main_dir"dotfiles/"

urxvt_to=$dotfiles"urxvt/.Xresources"
urxvt_from=$home".Xresources" 

tmux_to=$dotfiles"tmux/.tmux.conf"
tmux_from=$home".tmux.conf" 

nvim_dir_to=$dotfiles"nvim/"
nvim_dir_from=$home".config/nvim/"
nvim_to=$dotfiles"nvim/init.vim"
nvim_from=$home".config/nvim/init.vim"


function apply_configs {
	echo ">>> Applying configs"

	echo ">>> tmux conf"
	cp $tmux_to $tmux_from

	echo ">>> urxvt conf"
	cp $urxvt_to $urxvt_from

    # urxvt
    xrdb ~/.Xresources

	echo ">>> nvim conf"
	mkdir -p dirname $nvim_from
	cp $nvim_to $nvim_from"init.vim" 
	cp -r $nvim_dir_to $nvim_dir_from"colors" 
}

function copy_configs {

	echo ">>> Copying configs"

	echo ">>> tmux conf"
	cp $tmux_from $tmux_to

	echo ">>> urxvt conf"
	cp $urxvt_from $urxvt_to

	echo ">>> nvim conf"
	nvim_from=$home".config/nvim/"
	cp $nvim_from"init.vim" $nvim_to
	cp -r $nvim_dir_from"colors" $nvim_dir_to

}
