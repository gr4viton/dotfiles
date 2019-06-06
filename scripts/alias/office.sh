#!/bin/bash

to_base64 () {
    echo "$1" | base64
}

from_base64 () {
    echo "$1" | base64 -d
}


# LL
alias llpy="ll | grep '.*py$'"

# AG = ag-silversearcher
alias agp='ag --py '
# find all non-get dicts value accesses via str key (=dict_['something'])

agp_dict() {
    agp "\[['|\"][^,]*?['|\"]\]";
}

# VIM
vimopen () {
    nvim -O $@
}

vimo () {
    if [ "$#" -lt 10 ]; then
        vimopen $@
    else
        if $(ask_yes "$# files to be open, continue?"); then
            vimopen $@
        else
            echo "skipped opening of $# files"
        fi
    fi
}

vim () {
    nvim -O $@
}

vis () {
    # load vim Session file
    nvim -S $@
}
viss () {
    vis Session.vim
}

vimdiff_color () {
    vim -d $1 $2 +"windo set wrap"
}

# alias vimo='vim -O'

alias vim_is_clipboardable='vim --version | grep clipboard' #` gets you `-xterm_clipboard'

viag() {
    vimo $(ag -l $@)
}

viagp() {
    vimo $(agp -l $@)
}

viag_cd () {
    dir=$1
    cd $dir
    viag ${@:2} $dir
}
# FOLDERIZE

gr4_folderize() {
    # creates aliases and variables for a folder
    #
    # $1 = abbreviation used for folder aliases
    # $2 = folder path
    #
    # gr4_folderize "esp32" "/srv/dd/esp32"
    # creates:
    # - aliases: `cdesp32`, `lsesp32`
    # - envars: `diresp32`, `desp32`

    # ${param:?word} writes word to stdout when param is unset or null
    local abbrev="${1:?No abbreviation alias.}"
    local folder="${2:?No directory to folderize.}"

    export dir${abbrev}="$folder"
    export d${abbrev}="$folder"
    which > /dev/null 2>&1 cd${abbrev} || alias cd${abbrev}="cd $folder"
    which > /dev/null 2>&1 ls${abbrev} || alias lll${abbrev}o="lla $folder"
}

# MV = move

gr4_mkdir_move() {
    local what="${1:?No files.}"
    local new_dir="${2:?No directory to move to.}"
    mkdir -p $new_dir
    mv $what $new_dir
}

alias mvc=gr4_mkdir_move

alias rename_make_lowercase="rename 'y/A-Z/a-z/' *"

# ASK

ask_yes () {
    read -r -p "$1 = Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
        return 0  # true = 0
    else
        return 1  # false = 1
    fi
}

ask_yes_test () {
    echo "TEST function of ask_yes function"

    # using call in if
    if $(ask_yes "Question 1?")
    then
        echo 'Answered yes'
    else
        echo 'Answered no'
    fi

    # using precall and var in if test-case `[]`
    yus=$(ask_yes "Question 2?")
    if [[ $yus ]]
    then
        echo 'Answered yes'
    else
        echo 'Answered no'
    fi

    TEST_VAR="THISHIT"
    if $(ask_yes "Do you really want to $TEST_VAR")
    then
        echo 'Answered yes'
    else
        echo 'Answered no'
    fi
}

countdown_str () {
  # countdown "00:01:00" # = hh:mm:ss
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    w  ait
  done
  echo
}
countdown_5 () {
    countdown 5 2>/dev/null
}

countdown () {
    secs=${1:-"00"}
    mins=${2:-"00"}
    hours=${3:-"00"}
    chars=$(printf "%02d:%02d:%02d" $hours $mins $secs)
    echo "Countdown from $chars"
    countdown_str $chars 2>/dev/null
}

countdown_test() {
    echo "You will be scared as hell in 5 seconds. And counting:"
    # countdown "00:00:03"
    countdown_5
    echo "BOO!"
}

# DISK

alias disk_show_space='df -h'
alias disk_swap_show='swapon --show'
alias disk_swap_show_ram='free -h'

# WIFI

wifi_device='wlp2s0'

alias wifi_get='ifconfig'
alias wifi_connect_dhclient="sudo dhclient $wifi_device"
alias wifi_selected_device="echo $wifi_device; echo 'set other wifi_device env var'"

wifi_connect () {
    echo "wifi_connect wifi_name password"

    sudo iwconfig $wifi_device essid $1 key $2

    wifi_connect_dhclient
}

# KILL

assasinate () {
    ps -aux | grep $1 | sed 1q
    ps_num=$(ps -aux | grep $1 | sed 1a | awk 'NR=1{print $2}')
    echo "gonna kill process with number $ps_num"
    countdown 3 2>/dev/null

    sudo kill -9 $ps_num
}

killit () {
    sudo pkill $@
}
alias kfire="killit firefox"
alias kchrome="killit chromium-browser"
alias kvlc="killit vlc"
alias kpycharm="killit pycharm"
alias kblender="killit blender"
alias kunity="killit unity"

# LIBINPUT-GESTURES


alias lgs='libinput-gestures-setup'
rclgs_home='~/.config/libinput-gestures.conf'
rclgs_main='/etc/libinput-gestures.conf'
alias virclgs_home="vim $rclgs_home"
alias virclgs_main="sudo vim $rclgs_main"
alias virclgs="sudo vim -O $rclgs_home $rclgs_main"

# TERMINAL SETTINGS

set_term_xterm(){ export TERM="xterm" ; }
set_term_xterm256color(){ export TERM="xterm-256color" ; }
set_term_urxvt(){ export TERM="rxvt-unicode-256color" ; }
alias term_is_color="set_term_xterm256color"

term_clear() { printf "\033c" ; }

# APK

apt_installed () {
    apt list --installed 2>/dev/null | grep $1
}

alias syslog="sudo tail -f /var/log/syslog"

# dotglob - set = the * does not omit "." prefixed files
alias set_dotglob="shopt -s dotglob"
alias unset_dotglob="shopt -u dotglob"

# BLACK

alias black120="black -l 120"
alias black120_str="black -l 120 -S"

alias blak="black120"
alias blaks="black120_str"

alias x_gparted_fix="xhost +SI:localuser:root"

alias vircpudb="vim ~/.config/pudb/pudb.cfg"

# gr4log

vigr () {
    viag_cd $dirgr4log $@
}

vigralias () {
    viag_cd $dirgr4log/scripts/alias $@
}
vigrlog () {
    viag_cd $dirgr4log/log $@
}

# yq

yqy () {
  # yaml output
  yq -y $@
}

# PIP env vars

env_clean_pip () {
	unset PYPI_PASSWORD
	unset PIP_INDEX_URL
	unset PIP_EXTRA_INDEX_URL
	unset PYPI_USERNAME
}
alias unset_pip_extras="env_clean_pip"


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


eval $(thefuck --alias)

difff () {
    diff -u $@ | ydiff -s
}

alias xclip_pipe='xargs echo -n | xclip -selection clipboard'
alias tmux_check_xclip="tmux -Ltest list-keys | grep copy-pipe"
