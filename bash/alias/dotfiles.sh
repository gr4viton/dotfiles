## __dotfiles


init_dot () {
    # Initialize the saved customized dotfile for
    # given application by creating symlinks to
    # the github versioned dotfile folder


    # should work also with folder
    app_name="${1:?app_name}"
    local_file="${2:?local rc file of the app}"
    versioned_file="${3:?versioned rc file of the app}"
    echo ""
    echo "> Init symlink of versioned dotfile"
    echo "        app = $c_yellow$app_name$c_end"
    echo "      local = $c_red$local_file$c_end"
    echo "  versioned = $c_blue$versioned_file$c_end"

    if [[ -L "$local_file" ]]; then
        echo ""
        echo "> local file/dir exist and is a ${c_green}symlink$c_end $local_file"
        echo "  $(stat $local_file | grep File)"
        echo ""
    fi

    # using call in if
    if $(ask_yes "Do you want to use the symlink?")
    then
        if [[ -L "$local_file" ]]; then
            # if symlink - just delete
            echo "> symlink exist -> removing $local_file"
            echo "  $(stat $local_file | grep File)"
            rm $local_file
        else
            # only if non-symlink file exists
            if [[ -f "$local_file" || -d "$local_file" ]]; then
                # make backup if file / folder exist
                rnd=$(( RANDOM % 9999 ))
                bkp_file="$local_file.$rnd.backup"
                echo "> moving original as backup '$bkp_file'"
                mv $local_file $bkp_file

                if [[ -f "$local_file" ]]; then
                    folder=$(dirname $local_file)
                    echo "> make folder $folder"
                    mkdir -p $folder
                fi
            fi
        fi

        echo "> making symlink of versioned: $versioned_file"
        ln -s $versioned_file $local_file
    else
        echo "No dotfile initialized for $app_name"
    fi
}


DIR_DDDOT="${DIR_DDD}/dotfiles"
DIR_DDDOT_KW="${DIR_DDD_KW}/dotfiles"

init_dot_monitors () {
    # if the update of the setup is needed - use this: https://askubuntu.com/a/716677
    app_name="linux_monitors"
    config_
    init_dot $app_name \
        "${HOME}/.config/monitors.xml" \
        "${DIR_DDDOT}/monitors/monitors.xml"
}

init_dot_nvim () {
    app_name="neovim"
    config_dir="${HOME}/.config/nvim/"
    init_dot $app_name \
        "${config_dir}/init.vim" \
        "${DIR_DDDOT}/nvim/init.vim"
    init_dot $app_name \
        "${config_dir}/plug_install.vim" \
        "${DIR_DDDOT}/nvim/plug_install.vim"
    init_dot $app_name \
        "${config_dir}/plug_info.md" \
        "${DIR_DDDOT}/nvim/plug_info.md"
    init_dot $app_name \
        "${config_dir}/plug_coc.vim" \
        "${DIR_DDDOT}/nvim/plug_coc.vim"

    init_dot $app_name \
        "${config_dir}/UltiSnips" \
        "${DIR_DDDOT}/nvim/UltiSnips"

    init_dot $app_name \
        "${config_dir}/colors/wombat256mod.vim" \
        "${DIR_DDDOT}/nvim/colors/wombat256mod.vim"

}

init_dot_autokey () {
    app_name="autokey"
    config_dir="${HOME}/.config/autokey/"
    # dd
    init_dot $app_name \
        "${config_dir}/data/gr4viton" \
        "${DIR_DDDOT}/autokey_data/data/gr4viton"
    init_dot $app_name \
        "${config_dir}/data/scripts" \
        "${DIR_DDDOT}/autokey_data/scripts"

    # kw
    init_dot $app_name \
        "${config_dir}/data/kw" \
        "${DIR_DDDOT_KW}/autokey_data/data/kw"
}


init_dot_tmux_all () {
    config_dir="${HOME}"

    app_name="tmux"
    init_dot $app_name \
        "${config_dir}/.tmux.conf" \
        "${DIR_DDDOT}/tmux/dd.tmux.conf"

    app_name="tmuxp"
    init_dot $app_name \
        "${config_dir}/.tmuxp" \
        "${DIR_DDDOT}/tmuxp/.tmuxp"

    echo "NOT FULLY IMPLEMENTED YET - missing tmuxinator"
    mux_sys=$home".config/tmuxinator/"
    mux_my=$dotfiles"tmuxinator/"
}

init_dot_urxvt () {
    # sometimes can be Xresources?
    # - .Xresources is more modern
    # - .Xdefaults not suitable for remote access (not read by xrdb)
    # - use .Xresources
    # - keep .Xdefaults minimal if needed (only for legacy apps)
    # urxvt_to=$dotfiles"urxvt/.Xresources"
    # urxvt_from=$home".Xresources"
    app_name="urxvt"
    init_dot $app_name \
        "${HOME}/.Xresources" \
        "${DIR_DDDOT}/urxvt/.Xresources"
}

_init_dot_mate_panel () {
    echo "NOT IMPLEMENTED YET"
    sys="/usr/share/mate-panel/layouts/gr4viton*"
    myy="${dotfiles}mate_panel_layouts/"
    echo $1 "files" $myy $sys
}

init_dot_git_config () {
    app_name="git_user_config"
    config_dir="${HOME}"
    echo $config_dir
    init_dot $app_name \
        "${config_dir}/.gitconfig" \
        "${DIR_DDDOT}/git/dd.gitconfig"
}

init_dot_hackoviny_iam_root () {
    app_name="x11_keyboard_layout_hackoviny"
    config_dir="/usr/share/X11/xkb/symbols"
    echo $config_dir
    init_dot $app_name \
        "${config_dir}/en_hackoviny" \
        "${DIR_DDDOT}/keyboard/usr_share_x11_xkb_symbols/en_hackoviny"
}


init_dot_hackoviny () {
    echo "need to be root, to add the keyboard layout"
    sudo su -c "source ${DIR_DDD}/bashrc_local.sh && whoami && init_dot_hackoviny_iam_root"
    whoami
    echo "> Now you need to insert the following item:"
    echo ""
    keybd_hackoviny_echo
    echo ""
    echo "> into the /usr/share/X11/xkb/rules/evdev.xml"
    echo "> You can use the keybd_update_layout_list function to open it for editing"

    echo ""
    echo "> Then you can select the keyboard layout."
    echo "> Be sure to also set 'Keyboard - Layouts - Options... - Key to choose the 3rd level - Right Alt'"
    echo "> Otherwise the AltGr + letter wont produce the wanted diacritics."
}

init_dot_vlc () {
    app_name="vlc_config"
    config_dir="${HOME}/.config/vlc/"
    echo $config_dir
    init_dot $app_name \
        "${config_dir}/vlcrc" \
        "${DIR_DDDOT}/vlc/vlcrc"

}
