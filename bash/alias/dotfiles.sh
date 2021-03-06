init_dot () {

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


DIR_DDDOT="${DIR_DDD}/dotfiles/"

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
    init_dot $app_name \
        "${config_dir}/data/gr4viton" \
        "${DIR_DDDOT}/autokey_data/data/gr4viton"
}

init_dot_tmux () {
    app_name="tmux"
    config_dir="${HOME}"
    init_dot $app_name \
        "${config_dir}/.tmux.conf" \
        "${DIR_DDDOT}/tmux/dd.tmux.conf"


    echo "NOT FULLY IMPLEMENTED YET"
    mux_sys=$home".config/tmuxinator/"
    mux_my=$dotfiles"tmuxinator/"

    muxp_sys="${home}.tmuxp/"
    muxp_my="${dotfiles}tmuxp/"
}

_init_dot_urxvt () {
    echo "NOT IMPLEMENTED YET"
    urxvt_to=$dotfiles"urxvt/.Xresources"
    urxvt_from=$home".Xresources"

    urxvt_to2=$dotfiles"urxvt/.Xdefaults"
    urxvt_from2=$home".Xdefaults"
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
