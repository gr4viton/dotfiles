#!/bin/bash



alias llpy="ll | grep '.*py$'"

alias vimo='vim -O'

# alias mux='tmuxinator'
alias mux='tmuxp'
alias muxl='tmuxp load'
muxe() {
    vim ~/.tmuxp/$1.yml
}

# ag-silversearcher
alias agp='ag --py '
# find all non-get dicts value accesses via str key (=dict_['something'])

agp_dict() { 
    agp "\[['|\"][^,]*?['|\"]\]";
}

viag() {
    vimo $(ag -l $@)
}

viagp() {
    vimo $(agp -l $@)
}

gr4_folderize() {
    # creates aliases and variables for a folder
    #
    # $1 = abbreviation used for folder aliases
    # $2 = folder path
    #
    # gr4_folderize "esp32" "/srv/dd/esp32"
    # creates aliases `cdesp32`, `lsesp32` and `diresp32` env

    # ${param:?word} writes word to stdout when param is unset or null
    local abbrev="${1:?No abbreviation alias.}"
    local folder="${2:?No directory to folderize.}"

    export dir${abbrev}="$folder"
    which > /dev/null 2>&1 cd${abbrev} || alias cd${abbrev}="cd $folder"
    which > /dev/null 2>&1 ls${abbrev} || alias lll${abbrev}o="lla $folder"
}


gr4_mkdir_move() {
    local what="${1:?No files.}"
    local new_dir="${2:?No directory to move to.}"
    mkdir -p $new_dir
    mv $what $new_dir
}

alias mvc=gr4_mkdir_move

alias rename_make_lowercase="rename 'y/A-Z/a-z/' *"



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
    wait
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


alias disk_show_space='df -h'
alias disk_swap_show='swapon --show'
alias disk_swap_show_ram='free -h'

wifi_device='wlp2s0'

alias wifi_get='ifconfig'
alias wifi_connect_dhclient="sudo dhclient $wifi_device"
alias wifi_selected_device="echo $wifi_device; echo 'set other wifi_device env var'"

wifi_connect () {
    echo "wifi_connect wifi_name password"

    sudo iwconfig $wifi_device essid $1 key $2

    wifi_connect_dhclient
}

assasinate () {
    ps -aux | grep $1 | sed 1q
    ps_num=$(ps -aux | grep $1 | sed 1a | awk 'NR=1{print $2}')
    echo "gonna kill process with number $ps_num"
    countdown 3 2>/dev/null
    
    sudo kill -9 $ps_num
}

alias lgs='libinput-gestures-setup'
rclgs_home='~/.config/libinput-gestures.conf'
rclgs_main='/etc/libinput-gestures.conf'
alias virclgs_home="vim $rclgs_home"
alias virclgs_main="sudo vim $rclgs_main"
alias virclgs="sudo vim -O $rclgs_home $rclgs_main"

alias set_term_termx="export TERM=xterm"
alias set_term_urxvt="export TERM=rxvt-unicode-256color"

apt_installed () {
    apt list --installed 2>/dev/null | grep $1
}

alias syslog="sudo tail -f /var/log/syslog"

# dotglob - set = the * does not omit "." prefixed files
alias set_dotglob="shopt -s dotglob"
alias unset_dotglob="shopt -u dotglob"


alias black120="black -l 120"
alias black120_str="black -l 120 -S"

alias blak="black120"
alias blaks="black120_str"


alias x_gparted_fix="xhost +SI:localuser:root"

alias kill_firefox="sudo pkill firefox"
alias kill_chrome="sudo pkill chromium-browser"
