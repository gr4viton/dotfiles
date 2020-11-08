#!/bin/bash

ddate () {
    # date in rfc-3339 format
    # it's like iso-8601 + time
    date --rfc-3339=seconds
}

to_base64 () {
    echo "$1" | base64
}

from_base64 () {
    echo "$1" | base64 -d
}


# LL
alias llpy="ll | grep '.*py$'"

alias disc_usage="du"

disc_usage_summarize () {
    # use `du -sh out/*` to get sizes of folders
    du -sh
}

lsd () {
    path="${1:-*}"
    du -sh $path
}
alias lls="lsd"

# AG = ag-silversearcher
alias agp='ag --py '
# find all non-get dicts value accesses via str key (=dict_['something'])

agp_dict() {
    agp "\[['|\"][^,]*?['|\"]\]";
}

# VIM
vimopen () {
    nvim -O "$@"
}

vimo () {
    if [ "$#" -lt 10 ]; then
        vimopen "$@"
    else
        if $(ask_yes "$# files to be open, continue?"); then
            vimopen "$@"
        else
            echo "skipped opening of $# files"
        fi
    fi
}

vim_last_learned () {
    out=$(cat <<-EOF
%s//.../g  # uses the last searched term
^r" # yells buffer to commandline
EOF
)
    echo "$out"
}

vim () {
    nvim -O "$@"
}

vis () {
    # load vim Session file
    nvim -S "$@"
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
    # search via ag and open the found files - search for the string in the opened files
    vimo -c "silent! /$@" $(ag -l "$@")
}

viagp() {
    # search via ag --py and open the found files - search for the string in the opened files
    vimo -c "silent! /$@" $(agp -l "$@")
}

visearch() {
    # open file specified and search in it the first arg
    search_pattern=$1
    shift  # remove $1 from $@
    vimo -c "silent! /$search_pattern" $@
}

viag_cd () {
    dir=$1
    shift
    cd $dir
    viag $@ $dir
}

viag_gitlabci_in_subfolders () {
    # have to have "/.git/" line in ~/.agignore
    REGEX="${1?regex for files}"
    viag $REGEX --hidden -G ".*/.*gitlab-ci.y.*ml" -l
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
    which > /dev/null 2>&1 cd${abbrev} || alias cd${abbrev}="cd \"$folder\""
    which > /dev/null 2>&1 ls${abbrev} || alias lll${abbrev}o="lla \"$folder\""
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
alias wifi_iw_connect_dhclient="sudo dhclient $wifi_device"
alias wifi_iw_selected_device="echo $wifi_device; echo 'set other wifi_device env var'"

wifi_connect_iwconfig () {
    echo "wifi_connect wifi_name password"

    sudo iwconfig $wifi_device essid $1 key $2

    wifi_connect_dhclient
}

wifi_devices () {
    nmcli d wifi
}
wifi_devices_all () {
    nmcli d
}
wifi_list () {
    nmcli d wifi list
}

wifi_tunr_on () {
    nmcli r wifi on
}
wifi_tunr_off () {
    nmcli r wifi off
}

wifi_connect () {
    # https://docs.ubuntu.com/core/en/stacks/network/network-manager/docs/configure-wifi-connections
    # hidden:
    # nmcli c add type wifi con-name <name> ifname wlan0 ssid <ssid>
    # nmcli c modify <name> wifi-sec.key-mgmt wpa-psk wifi-sec.psk <password>
    # normal:
    # nmcli d wifi connect my_wifi password <password>
    wifi_name="${1:?wifi name}"
    password="${2:?wifi password}"
    wifi_device="${3:-}"
    wifi_device_option=""

    if [[ ! -z "$wifi_device" ]]; then
        wifi_device_option="ifname $wifi_device"
    fi
    nmcli d wifi connect $wifi_name password $password $wifi_device_option
}

wifi_connect_via_dongle () {
    wifi_name="${1:?wifi name}"
    password="${2:?wifi password}"
    wifi_device="wlx74da387faa12"
    wifi_connect $wifi_name $password $wifi_device
}

esp_wifi_connect () {
    pwd=$1
    wifi_name="esp8"
    wifi_connect_via_dongle $wifi_name $pwd
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
killit2 () {
    # killall -9 $@
    pkill -9 $@
}

alias kdota="killit dota2"
alias kfire="killit firefox"
kchrome () {
    killit2 chromium-browser
    killit2 chrome
}
alias kvlc="killit2 vlc"
alias kpycharm="killit pycharm"
alias kblender="killit blender"
alias kunity="killit unity"


kswap () {
    swapoff -a
}
kswap_restart () {
    swapoff -a
    swapon -a
}

kall () {
    kfire
    kvlc
    kpycharm
    kchrome
}

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

alias syslog="sudo tail -n 1000 -f /var/log/syslog"
alias visyslog="sudo vim /var/log/syslog"

# dotglob - set = the * does not omit "." prefixed files
alias set_dotglob="shopt -s dotglob"
alias unset_dotglob="shopt -u dotglob"

# BLACK

alias black120="black -l 120"
alias black120_str="black -l 120 -S"

alias blacks="black120_str"

alias prc="pre-commit"
alias prca="prc run -a"
alias prcinstall="prc install"


alias x_gparted_fix="xhost +SI:localuser:root"

alias vircpudb="vim ~/.config/pudb/pudb.cfg"

# gr4log

vigr () {
    viag_cd $dirgr4log $@
}

viw () {
    viag_cd $dirweb/content/ $@
}

vialias () {
    viag_cd $DIR_DDD/bash/alias/ $@
}

alias vigralias="vialias"

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

vi_compose () {
    vim /usr/share/X11/locale/en_US.UTF-8/Compose
}

# /opt/displaylink
# displaylink driver dock-in station - supsend setup



swap_info () {
    swapon
    cat /proc/sys/vm/swappiness
}
swap_set_swappiness () {
    swp=$1
    swap_info
    sudo sysctl vm.swappiness=$swp
    swap_info
}

swap_remove_swapfile () {
    sudo swapoff -v /swapfile
    sudo rm /swapfile
}

swap_add_swapfile () {
    # 4G = 4GB
    sudo fallocate -l 4G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    echo "also add to /etc/fstab"
    echo "/swapfile swap swap defaults 0 0"
    echo "> your /etc/fstab:"
    cat /etc/fstab
}


vigrub () {
    sudo vim /etc/default/grub
}

envg () {
    env | grep $@
}



# game
# wine https://help.ubuntu.com/community/Wine
wow () {
    wine /fun/game/wow/wow434/Wow.exe
}

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


alias youtube-dl="/srv/dd/app/youtube-dl/bin/youtube-dl"

dirydlb="$HOME/DATA/DNz/batch.txt"

alias ydl="youtube-dl"

ydlb () {
    youtube-dl -a $dirydlb $@
}

ydlbb () {
    cd $(dirname $dirydlb)
    cd ydlbb
    set -x
    ydl --username $YDL_USER --password $YDL_PWD $@
    set +x
}

alias yyy="ydlbb"

alias cdydlb="cd $HOME/DATA/DNz/"
alias viydlb="vim $dirydlb $dirydlb.old"

calc(){ awk "BEGIN { print "$*" }"; }

count_of_lines () {
     ag  -l | xargs wc -l | grep total | sed 's/ total//' | sed 's/ //'
}
count_of_words () {
     ag  -l | xargs wc -w | grep total | sed 's/ total//' | sed 's/ //'
}
count_of_words_per_line () {
   a=count_of_words
   b=count_of_lines
   calc $a/$b

}


alias zalgo="python3 /srv/dd/component/zalgo-cli/zalgo.py"

alias dolphin_here="dolphin $PWD"
alias dohe="dolphin $PWD"


display_restart_manager () {
    sudo systemctl restart display-manager
}


suspend_now () {
    sudo systemctl suspend
}

alias sus="suspend_now"


apt_search () {
    # search for package via its name in apt repos
    apt-cache search $@
}

treep () {
    # tree with python cache folder ignored
    tree -I '__pycache__' $@
}


git_mv_snake_case_to_dash_case () {
    for file in ./* ; do git mv "$file" "$(echo $file|sed -e 's/_/-/g')"; done
}


cddir () {
    cd $(dirname -- $@)
}


# echo_py

echo_py_src () {
    # echo python script output while the script is defined in the bash via EOF
    # usage
    # echo_py_src 'print("HI")' "first_arg" "second_arg"
    PYSRC="${1:?python source text}"
    shift  # skip the first arg = $PYSRC
    result="$(python3 -c "$PYSRC" "$@")"
    echo "$result"
}

echo_py_example () {
    # echoes the first argument + does not accept others
    # $ echo_py_example 'ahoj'
    PYSRC=$(cat <<EOF
import click

@click.command()
@click.argument("arg1")
def main(**kwargs):
    print(kwargs["arg1"])

main()
EOF
)
    echo_py_src "$PYSRC" $@
}


# aosd_cat - prints text on screen with transparent background

display_show_data () {
    # echoes data for connected monitors in the format
    # {width}x{height}+{offset_y}+{offset_y}  # there can be + or minus
    # eg "1920x1080+0-0" # for one monitor
    # info about primary monitor is removed
    xrandr --query | grep " connected" | sed 's/primary //' | awk '{print $3}'
}


aosd_cat_install () {
    sudo apt-get install -y aosd-cat
}

aosd_get_centers_xy_args () {
    # returns the aosd_cat arguments for centers of connected screens
    # example output for 3 connected monitors

    # --xpos=2160 --ypos=1815
    # --xpos=2160 --ypos=669
    # --xpos=600 --ypos=960


    PYSRC=$(cat <<EOF
import click

@click.command()
@click.argument("resolutions", nargs=-1)  # multiple args can be passed
def main(resolutions):
    """Get the args for aosd_cat method with the xpos and ypos in centers of every connected display.

    Args:
        resoltions (str): multiline str containing the connected displays data
    """

    centers = get_centers(resolutions)
    print_aosd_cat_args(centers)

def print_aosd_cat_args(centers):
    for center in centers:
        print(f"--x-offset={center[0]} --y-offset={center[1]}")

def get_centers(resolutions):
    """Get the centers of the screens.  In the end not exactly!

    Args:
        resoltions (list of str): list of connected display screen info
            "{width}x{height}+{offset_y}+{offset_y}"  # there can be plus or minus
    """
    centers = []
    for res in resolutions:
        words = []
        for words_x in res.split("x"):
            for words_plus in words_x.split("+"):
                for word in words_plus.split("-"):
                    words.append(word)
        nums = [int(word) for word in words]
        w, h, ox, oy = nums  # width height offset_x offset_y

        # CHANGE
        center_point = (int(ox + w/8), -1 * int(oy + h/4))
        # center_point = (int(ox), -int(oy))
        # center_point = (int(ox), -int(oy))
        centers.append(center_point)
    return centers

main()
EOF
)
    echo_py_src "$PYSRC" $(display_show_data)
}

aosd_show_time () {
    # show the current time in the middle of all connected screens
    # example
    # date +"%H:%M" | aosd_cat --font="Ubuntu 48" --shadow-offset=1 --back-color=black --back-opacity=200 --position=4 --padding=32 --fore-color=white --lines=0 --fade-in=0 --fade-out=0 --lines=3 --age=1;
    # date +"%H:%M" | aosd_cat --shadow-offset=1 --back-color=black --back-opacity=200 --position=4 --padding=32 --fore-color=white --lines=0 --fade-in=0 --fade-out=0 --lines=3 --age=1;
    font_size="${1:-333}"
    fade_full="${2:-500}"
    padding="${3:-0}"

    # base_args=(
    #     --font="Ubuntu $font_size" --shadow-offset=1 --back-color=black --back-opacity=200 --fore-color=white --lines=0 --lines=3
    #     --fade-in=0 --fade-out=0 --fade-full=$fade_full --padding=$padding
    # )
    echo "Getting centers"
    # IFS='\n' read -r centers <<< $(aosd_get_centers_xy_args)
    # echo "$centers"
    # for pos_args in
    # for pos_args in $(aosd_get_centers_xy_args)
    for pos_args in "$(aosd_get_centers_xy_args)"
    # for pos_args in ${centers[@]}
    do
        echo "Showing time: $pos_args"
        IFS=' ' read -r -a pos_args_array <<< "$pos_args"
        full_args=(
            --font="Ubuntu $font_size" --shadow-offset=1 --back-color=black --back-opacity=200 --fore-color=white --lines=0 --lines=3
            --fade-in=0 --fade-out=0 --fade-full=$fade_full --padding=$padding
            ${pos_args_array[@]}
        )
        echo "Showing time: $full_args"
        date +"%H:%M" | aosd_cat "${full_args[@]}"

    done
}


# jekyll
alias jekyll_me='bundle exec jekyll serve'
