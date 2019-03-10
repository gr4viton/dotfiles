#!/bin/bash

home="/home/$USER/"
main_dir=$home"gr4log/"
cd $main_dir

dotfiles=$main_dir"dotfiles/"

urxvt_to=$dotfiles"urxvt/.Xresources"
urxvt_from=$home".Xresources"

urxvt_to2=$dotfiles"urxvt/.Xdefaults"
urxvt_from2=$home".Xdefaults"

tmux_to=$dotfiles"tmux/.tmux.conf"
tmux_from=$home".tmux.conf"

nvim_dir_to=$dotfiles"nvim/"
nvim_dir_from=$home".config/nvim/"
nvim_to=$dotfiles"nvim/init.vim"
nvim_from=$home".config/nvim/init.vim"

mux_sys=$home".config/tmuxinator/"
mux_my=$dotfiles"tmuxinator/"

muxp_sys="${home}.tmuxp/"
muxp_my="${dotfiles}tmuxp/"

autokey_sys="${home}.config/autokey/data/"
autokey_my="${dotfiles}/autokey_data/"


apply_configs () {
	echo ">>> Applying configs"

	echo ">>> tmux conf"
	cp $tmux_to $tmux_from

	echo ">>> urxvt conf"
	cp $urxvt_to $urxvt_from

    # urxvt
    xrdb ~/.Xresources

	echo ">>> nvim conf"
	mkdir -p dirname $nvim_dir_from
	cp $nvim_to $nvim_from

	cp -r $nvim_dir_to* $nvim_dir_from

    echo ">>> tmuxinator"
    mkdir $mux_sys
    cp $mux_my"*.yml" $mux_sys

    echo ">>> tmuxp"
    mkdir $muxp_sys
    cp $muxp_my $muxp_sys

    echo ">>> autokey"
    mkdir $autokey_sys
    cp $autokey_my $autokey_sys
}

copy_configs () {

	echo ">>> Copying configs"

	echo ">>> tmux conf"
	cp $tmux_from $tmux_to

	echo ">>> urxvt conf"
	cp $urxvt_from $urxvt_to

	echo ">>> urxvt conf"
	cp $urxvt_from2 $urxvt_to2

	echo ">>> nvim conf"
	nvim_from=$home".config/nvim/"
	cp $nvim_from $nvim_to
	cp -r $nvim_dir_from"colors" $nvim_dir_to

    echo ">>> tmuxinator"
    cp $mux_sys"*.yml" $mux_my

    echo ">>> tmuxp"
    mkdir $muxp_my
    cp $muxp_sys $muxp_my

    echo ">>> autokey"
    mkdir $autokey_my
    cp $autokey_sys $autokey_my

    ls -aR $main_dir"dotfiles"
}
