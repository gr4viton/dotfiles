# TMUX, tmuxinator, tmuxp

# alias mux='tmuxinator'
alias mux='tmuxp'
alias muxl='tmuxp load'

dirtmuxp="/home/dd/.tmuxp/"
muxe() {
    paths=""
    for name in "$@"; do
        paths=$paths"$dirtmuxp/$name.yml "
    done
    # vim $dirtmuxp/$1.yml
    vimo $paths
}

muxe_all() {
    cd $dirtmuxp
    vim *.yml
}

muxecd() {
    cd $dirtmuxp
    muxe $1
}


mux_create() {
    nam=${1:?Tmux session name}
    session_names=$(tmux ls -F "#S")
    match=$(echo $session_names | grep $nam)
    if [[ -z "$match" ]]; then
        echo -n "no match for session name $nam in session_names: ["
        echo $session_names | tr -d "\n"
        echo "]"
        if $(ask_yes "Do you want to create new session [$nam]?"); then
            mux_new_session $nam
        fi
    else
        tmux a -t $match
    fi
}

mux_new_session() {
    nam=${1:?Tmux session name}
    tmux new -s $nam
}

muxl_base () {
    # commands to be ran as starting command of every mux
    term_is_color;
}

muxl_base_da () {
    muxl_base
}

muxl_base_dd () {
    muxl_base
    unset_pip_env
    gitlab_iam_gr4viton
}


alias tmux_check_xclip="tmux -Ltest list-keys | grep copy-pipe"

_tmux_conf="/home/$USER/.tmux.conf"
tmux_src () {
    tmux source $_tmux_conf
}
tmux_vrc () {
    vim $_tmux_conf
}
vitmux () {
    vim $_tmux_conf
}

# files
## configs
alias virctmuxp="vim -O ~/.confix/tmuxp/*.yml"
alias virctmux='vim ~/.tmux.conf'
alias cdtmuxp="cd ~/.tmuxp/"
# muxl, muxe

