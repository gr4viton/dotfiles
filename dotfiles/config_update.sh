#!/bin/bash

home="/home/$USER/"
main_dir="/home/dd/dd/dotfiles/"
cd $main_dir

dotfiles=$main_dir"dotfiles/"

urxvt_to=$dotfiles"urxvt/.Xresources"
urxvt_from=$home".Xresources"

urxvt_to2=$dotfiles"urxvt/.Xresources"
urxvt_from2=$home".Xresources"

tmux_to=$dotfiles"tmux/.tmux.conf"
tmux_from=$home".tmux.conf"

# nvim_dir_to=$dotfiles"nvim/"
# nvim_dir_from=$home".config/nvim/"
# nvim_to=$dotfiles"nvim/init.vim"
# nvim_from=$home".config/nvim/init.vim"

mux_sys=$home".config/tmuxinator/"
mux_my=$dotfiles"tmuxinator/"

muxp_sys="${home}.tmuxp/"
muxp_my="${dotfiles}tmuxp/"

autokey_sys="${home}.config/autokey/data/"
autokey_my="${dotfiles}/autokey_data/"

espanso_sys="${home}.config/espanso/"
espanso_my="${dotfiles}/espanso/"

config_updater () {
    update_option="${1?save/load}"
    dir_option="${2?files/dir}"
    my="${3?folder to save to}"
    sys="${@:4}"
    echo ">>> [$update_option][$dir_option] configs:"
    echo "> to my=$my"
    echo "> from sys:"
    echo "$sys"
    echo ">>>"
    if [[ "$update_option" = "save" ]]; then
        if [[ "$dir_option" = "dir" ]]; then
            cp $sys $my
        elif [[ "$dir_option" = "files" ]]; then
            mkdir $my
            cp $sys $my
        fi
    fi
}


gr4cfg_mate_panel () {
    sys="/usr/share/mate-panel/layouts/gr4viton*"
    myy="${dotfiles}mate_panel_layouts/"
    config_updater $1 "files" $myy $sys
}

gr4cfg_autokey () {
    sys=$autokey_sys
    myy=$autokey_my
    config_updater $1 "dir" $myy $sys
}


apply_configs () {
	echo ">>> Applying configs"

	echo ">>> tmux conf"
	cp $tmux_to $tmux_from

	echo ">>> urxvt conf"
	cp $urxvt_to $urxvt_from

    # urxvt
    #xrdb ~/.Xresources

	# echo ">>> nvim conf"
	# mkdir -p dirname $nvim_dir_from
	# cp $nvim_to $nvim_from

	# cp -r $nvim_dir_to* $nvim_dir_from

    echo ">>> tmuxinator"
    mkdir $mux_sys
    cp $mux_my"*.yml" $mux_sys

    echo ">>> tmuxp"
    mkdir $muxp_sys
    cp $muxp_my $muxp_sys

    echo ">>> autokey"
    mkdir $autokey_sys
    cp $autokey_my $autokey_sys

    echo ">>> espanso"
    mkdir $espanso_sys
    cp $espanso_my $espanso_sys
}

copy_configs () {

	echo ">>> Copying configs"
    opt="save"

	echo ">>> tmux conf"
	cp $tmux_from $tmux_to

	echo ">>> urxvt conf"
	cp $urxvt_from $urxvt_to

	echo ">>> urxvt conf"
	cp $urxvt_from2 $urxvt_to2

	# echo ">>> nvim conf"
	# nvim_from=$home".config/nvim/"
	# cp $nvim_from $nvim_to
	# cp -r $nvim_dir_from"colors" $nvim_dir_to

    echo ">>> tmuxinator"
    cp $mux_sys"*.yml" $mux_my

    echo ">>> tmuxp"
    mkdir $muxp_my
    cp $muxp_sys $muxp_my

    echo ">>> autokey"
    # gr4cfg_autokey $opt
	mkdir $autokey_my
    cp $autokey_sys $autokey_my


    echo ">>> mate_panel"
    gr4cfg_mate_panel $opt

    echo ">>> all dotfiles"
    ls -a $main_dir"dotfiles"
}
