#!/bin/bash
# __office__

# handy extract function for various archives
extract () {
 if [ -f $1 ] ; then
 case $1 in
 *.tar.bz2) tar xjf $1 ;;
 *.tar.gz) tar xzf $1 ;;
 *.bz2) bunzip2 $1 ;;
 *.rar) rar x $1 ;;
 *.gz) gunzip $1 ;;
 *.tar) tar xf $1 ;;
 *.tbz2) tar xjf $1 ;;
 *.tgz) tar xzf $1 ;;
 *.zip) unzip $1 ;;
 *.Z) uncompress $1 ;;
 *.7z) 7z x $1 ;;
 *) echo "'$1' cannot be extracted via extract()" ;;
 esac
 else
 echo "'$1' is not a valid file"
 fi
}


date_rfc_3339 () {
    # date in rfc-3339 format
    # it's like iso-8601 + time
    date --rfc-3339=seconds
    # date --rfc-3339=ns
    # date --rfc-3339=date
}
date_seconds () {
    date --utc --rfc-3339=seconds
}

date_rfc_3339_date () {
    date --rfc-3339=date
}

echo_time () {
    echo $(date --rfc-3339=s)
}

to_base64 () {
    echo "$1" | base64
}

from_base64 () {
    echo "$1" | base64 -d
}


# LL

ltree () {
    tree -L 2 -I "_*" $@
}

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
# FOLDERIZE

folderize () {
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
    local abbrev="${1:?Abbreviation alias needed.}"
    local folder="${2:?Directory to folderize needed.}"

    export dir${abbrev}="$folder"
    export d${abbrev}="$folder"
    which > /dev/null 2>&1 cd${abbrev} || alias cd${abbrev}="cd \"$folder\""
    which > /dev/null 2>&1 ls${abbrev} || alias lll${abbrev}o="lla \"$folder\""

}

alias gr4_folderize="folderize"

folderize "ddd" "$DIR_DDD"

# MV = move

gr4_mkdir_move () {
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

disk_show_space () {
    df -h | grep -v -E "/dev/loop.*"
}
alias disk_swap_show='swapon --show'
alias disk_swap_show_ram='free -h'

# WIFI

# KILL

assasinate () {
    ps -aux | grep $1 | sed 1q
    ps_num=$(ps -aux | grep $1 | sed 1a | awk 'NR=1{print $2}')
    echo "gonna kill process with number $ps_num"
    countdown 3 2>/dev/null

    sudo kill -9 $ps_num
}

killit () {
    sudo pkill "$@"
}
killit2 () {
    # killall -9 $@
    pkill -9 "$@"
}

alias kdota="killit dota2"
# alias kfire="killit firefox"
alias kfire="kill `pidof firefox`"
# alias kfire="kill -9 `pidof firefox`"
alias kfi="killit firefox"

alias kslack="kill `pidof slack`"

alias ksteam="killit steam"
kchrome () {
    killit2 chromium-browser
    killit2 chrome
}
alias kch="kchrome"
kkodi () {
    killit2 kodi
}
alias kvlc="killit2 vlc"
alias kpycharm="killit pycharm"
alias kblender="killit blender"
alias kunity="killit unity"
klutris () {
    killit2 lutris
}


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
alias syslog="sudo tail -n 1000 -f /var/log/syslog"
alias visyslog="sudo vim /var/log/syslog"

# dotglob - set = the * does not omit "." prefixed files
alias set_dotglob="shopt -s dotglob"
alias unset_dotglob="shopt -u dotglob"

alias prc="pre-commit"
alias prca="prc run -a"
alias prcinstall="prc install"


alias x_gparted_fix="xhost +SI:localuser:root"

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
pypi_unset_kiwi () {
    env_clean_pip
}

difff () {
    diff -u $@ | ydiff -s
}

alias xclip_pipe='xargs echo -n | xclip -selection clipboard'

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


file_uptime_log="${dirddd}/uptime.log"

reboot_now () {
    echo "$(date_seconds) | $(uptime -p) | $(uptime)" >> $file_uptime_log
    echo "> logged uptime to $file_uptime_log"
    echo "> gonna reboot now"
    sudo reboot now
}

treep () {
    # tree with python cache folder ignored
    tree -I '__pycache__' $@
}


cddir () {
    cd $(dirname -- $@)
}


# aosd_cat - prints text on screen with transparent background

display_show_data () {
    # echoes data for connected monitors in the format
    # {width}x{height}+{offset_y}+{offset_y}  # there can be + or minus
    # eg "1920x1080+0-0" # for one monitor
    # info about primary monitor is removed
    xrandr --query | grep " connected" | sed 's/primary //' | awk '{print $3}'
}


# docs
# jekyll
alias jekyll_me='bundle exec jekyll serve'

wiki_run () {
    cdwik
    echo_time
    # yarn develop
    # GATSBY_EXPERIMENTAL_LAZY_DEVJS=true gatsby develop
    GATSBY_EXPERIMENTAL_LAZY_DEVJS=true yarn develop
    echo_time
}

wiki_clean_cache () {
    cdwik
    yarn clean
}



# rcurxvt="~/.Xresources"
rcurxvt="~/.Xdefaults"
alias urxvt_reload="xrdb -load $rcurxvt"
alias vircurxvt="vim -O $rcurxvt"


# this was so slow (1second)
#if [[ $(apt_installed thefuck) ]]; then
    #eval $(thefuck --alias)
#fi


# ############## gr4log

# gr4log
dirgr4log=$HOME'/gr4log/'
dir_gr4scripts="$HOME/gr4log/scripts"

alias gr4log='vim '$dirgr4log'gr4log.vim'
alias cdgr4log='cd '$dirgr4log

alias vgr4='vim -O bashrc alias/install.sh ~/.bashrc'
alias vgrc='cd $dir_gr4scripts && vgr4'

alias log='cdgr4log;gr4log'
alias log_dreamer='vim '$dirgr4log'LOG/logDreamer.vim'
# sync all

alias gr4log_sync=$dirgr4log'gr4log_git_update.sh'
alias syncall='gr4log_sync'

alias man="info"



### web dev blog
# pelican

pelic_import () {
    pim="/home/dd/venvs/gr4viton.gitlab.io-Gx8cGBko/bin/pelican-import"
    # export="../export/all_gr4vitonamppow3r.WordPress.2020-02-28.xml"
    export_file="../export/export.xml"
    # pelican-import --wpfile ../export/all_gr4vitonamppow3r.WordPress.2020-02-28.xml --wp-attach -m markdown --dir-page --dir-cat -o export5
    # out="export6"
    out="content"

    pictures="--wp-attach"  # if you want the pictures to be exported
    pictures=""

    # export SITEURL="http://www.gr4viton.cz"

    # kwargs2="--dir-page --dir-cat --wp-custpost"
    kwargs="--wpfile $export_file -m markdown -o $out $pictures"

    # normal
    pipenv run pelican-import $kwargs
    # # with pudb
    # pipenv run python -m pudb.run $pim $kwargs
}

pelic_build_ () {
    pelican content
}

pelic_build () {
    poetry run pelican content
}
pelic_run () {
    echo "http://localhost:8000/public/"
    poetry run pelican -lr --ignore-cache
}

pelic_run_ () {
    echo "http://localhost:8000/public/"
    pelican -lr --ignore-cache
}

pelic_plugins () {
    poetry run pelican-plugins
}

pelic_install () {
    poetry run python -m pip install $@
}

kde_create_and_use_local_theme_from_breezedark () {
    theme_name_current="org.kde.breezedark.desktop"
    theme_title_current="Breeze"

    kde_create_and_use_local_theme_ $theme_name_current $theme_title_current
}

kde_get_themes_local_folder () {
    echo "/home/${USER}/.local/share/plasma/look-and-feel/"
}

kde_get_theme_local_folder () {
    theme_name="${1:-org.kde.breezedark.desktop_dd}"
    echo "$(kde_get_themes_local_folder)${theme_name}"
}
cd_kde_theme_local () {
    theme_name=$1
    dir_theme_local=$(kde_get_theme_local_folder $theme_name)
    echo "$dir_theme_local"
    cd $dir_theme_local

}
dir_kde_theme_global="/usr/share/plasma/look-and-feel"

cd_kde_theme_global () {
    cd $dir_kde_theme_global
}



kde_create_and_use_local_theme_ () {
    # viz https://www.reddit.com/r/kde/comments/9j57z2/fixing_the_awful_volumebrightness_osd_size/
    theme_name_current="${1:-org.kde.breezedark.desktop}"
    theme_title_current="${2:-Breeze}"  # not full title because in other languages the dark is not "dark"

    theme_name_modified="${theme_name_current}_${USER}"
    theme_title_modified="${theme_title_current}_${USER}"
    dir_theme_os="${dir_kde_theme_global}/${theme_name_current}/"
    dir_theme_local=$(kde_get_theme_local_folder $theme_name_modified)

    echo "> creating new local theme ($theme_name_modified) folder ${dir_theme_local}"
    mkdir -p $dir_theme_local
    rm -df $dir_theme_local

    echo "> copy the global plasma theme to the new location"
    cp $dir_theme_os $dir_theme_local
    ll $dir_theme_local

    echo "> rename the theme in metadata files"
    PYSRC=$(cat <<EOF
import click
import os

@click.command()
@click.argument("word_old")
@click.argument("word_new")
@click.argument("dir_theme_local")
def main(**kwargs):
    word_old = kwargs["word_old"]
    word_new = kwargs["word_new"]
    folder = kwargs["dir_theme_local"]
    fnames = ["metadata.json", "metadata.desktop"]

    for fname in fnames:
        fpath = os.path.join(folder, fname)

        with open(fpath, "r") as fil:
            dat = fil.read()

        dat = dat.replace(word_new, word_old)  # to be indempotent
        dat = dat.replace(word_old, word_new)

        with open(fpath, "w") as fil:
            fil.write(dat)

        print(f"> changed {word_old} to {word_new} in {fname}")

main()
EOF
)


    echo_py_src "$PYSRC" $theme_title_current $theme_title_modified $dir_theme_local
    echo_py_src "$PYSRC" $theme_name_current $theme_name_modified $dir_theme_local

    # echo "> selecting modified theme $theme_name_modified"
    # lookandfeeltool -a $theme_name_modified  # usable only for global themes :big_sad:
    echo "> now select the modified theme via the plasma menus"
}


kde_edit_local_theme () {
    cd_kde_theme_local
    viss
}

wiki_markdown_check () {
    d_full_wiki="/srv/kiwi/repo/used/handbook/"
    mdl --config ".markdownlint-loose.yml" --rules "$d_full_wiki/src/utils/markdown-lint-rules.js" ${d_full_wiki}.
}
wiki_markdown_here () {
    mdl --config ".markdownlint-loose.yml" --rules "src/utils/markdown-lint-rules.js" . $@
}



# du sh
ag_size () {
    # show size of the files - searched via ag
    # du -sh $(ag -g ".json") | sort -k1 -h
    dush $(ag "$@")
}

agl () {
    ag -l "$@"
}

dush () {
    # echo the size of selected files - and sort them by their size
    du -sh "$@" | sort -k1 -h
}



# bash variable in path tab completion
# from: https://askubuntu.com/questions/70750/how-to-get-bash-to-stop-escaping-during-tab-completion
shopt -s direxpand

milkdrop () {
    # projectm
    sudo /fun/GAME/STEAM/steamapps/common/projectM/./projectM
    # does not detect the audio output device :(
    # info https://github.com/projectM-visualizer/projectm/issues/429
}



camunda () {
    /srv/kiwi/apps/camunda-modeler-4.7.0-linux-x64/./camunda-modeler
}

netcheck_log () {
    vim /srv/dd/app/netcheck/log/connection.log
}

netcheck_tail () {
    tail -n 200 /srv/dd/app/netcheck/log/connection.log
}

audacity () {
    # get rid of linux non-refreshing GUI bug
    # viz https://forum.audacityteam.org/viewtopic.php?p=407260#p407260
    # need to unset the GTK_IM_MODULE which might be by default GTK_IM_MODULE=xim which causes the problem
    GTK_IM_MODULE= audacity
    # you have to modify it in the application.desktop Exac statement
    vim /usr/share/applications/audacity.desktop
}


# freecad

cdfcmacros () {
    cd /home/dd/.FreeCAD/Macro
}

# tree
treepy () {
    tree -P '*.py' --prune "$@"
}

lstreepy () {
    treepy "$@"
}


keyboard_edit_layout () {
  cd /usr/share/X11/xkb/symbols
  ll
  # echo "include \"cz_custom\"" | sudo tee /usr/share/X11/xkb/symbols/cz_custom_layout
}


nvim_at () {
  # Opens via nvim and searches for the first passed param
  search_param=$1
  shift
  nvim -c "silent! /${search_param}" $@
}

keyboard_refresh_layouts () {
  # 2023-11-25 
  # idea from my hackoviny - http://www.gr4viton.cz/2014/12/rozlozeni-klavesnice-win7/gr4hackoaltgr/
  # help from phind.com - https://www.phind.com/search?cache=m1j81teoo5jv7dr1ene5aydz
  # 
  # you might need to allow third-row modifier on right alt (AltGr)
  sudo dpkg-reconfigure xkb-data
  sudo rm /var/lib/xkb/*.xkm
}

keyboard_update_layout_list () {
  sudo nvim -c "silent! /layoutList" /usr/share/X11/xkb/rules/evdev.xml
  keyboard_refresh_layouts
}
