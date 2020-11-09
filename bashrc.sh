#!/bin/bash

if [ -z "$DIR_DD" ]; then
    echo "DIR_DD varialble not defined!"
fi
DIR_DDD="$DIR_DD/dotfiles/"

# .bashrc of gr4viton

c_end=$'\e[0m'
c_blue=$'\e[1;34m'
c_red=$'\e[1;31m'
c_cyan=$'\e[1;36m'
c_green=$'\e[1;32m'
c_yellow=$'\e[1;33m'


loadit() {
    script_path=$1
    if [ -f $script_path ]; then
        . $script_path
        script_name=$(basename $script_path)
        # script_name=$($script_name%%.*)
        # echo -n "$script_name "
        echo -n "$(basename $script_name .sh) "
    fi
}

loadit_here() {
    _dir_here="$(dirname $0)"
    script_path=$1
    loadit "${_dir_here}${script_path}"
}

DIR_LOADIT_SCRIPT="${DIR_DDD}bash/"

loadit_script() {
    script_path=$1
    loadit "${DIR_LOADIT_SCRIPT}${script_path}"
}

the_config=${DIR_DD}the_config.yaml
# ############## LOAD ALIASES AND FUNCTION FILES ###############
# speak synthesis
# git

HOSTNAME=$(hostname)


if [[ "$HOSTNAME" == "dddell-latitude-5401" ]]; then
    _scripts="full"
elif [[ "$HOSTNAME" == "ubuntu" || "$HOSTNAME" == "ros_bot" ]]; then
    _scripts="min"
else
    _scripts="full"
fi

echo "Sourcing [$_scripts script] files from $DIR_LOADIT_SCRIPT:"

if [[ "$_scripts" == "full" ]]; then

    scripts=(
        "ps1.sh"
        "alias/office.sh"
        "alias/git.sh"
        "alias/centroid.sh"
        "alias/install.sh"
        "alias/speak.sh"
        "alias/graphic.sh"
        "alias/dev.sh"
        "alias/esp32.sh"
        "alias/hw.sh"
        "alias/connect.sh"
        "alias/dell.sh"
        "alias/dirs.sh"
        "alias/docker.sh"
        "alias/kiwi.sh"
        "alias/config.sh"
        "alias/game.sh"
        "alias/tags.sh"
    )

elif [[ "$_scripts" == "ros" ]]; then

    scripts=(
        "ps1.sh"
        "alias/office.sh"
        "alias/git.sh"
        "alias/connect.sh"
        "alias/ros.sh"
    )

elif [[ "$_scripts" == "min" ]]; then

    scripts=(
        "ps1.sh"
        "alias/office.sh"
        "alias/git.sh"
        "alias/connect.sh"
    )

fi



len_so_far=0
limit_len_per_line=140
start_line='>>> '
echo -en ${start_line}
for script in ${scripts[@]}; do
    script_name=$(basename $script)
    script_name="${script_name%%.*}"
    len_so_far=$(( $len_so_far + ${#script} ))
    if (( $len_so_far > $limit_len_per_line )); then
        echo ""
        echo -en ${start_line}
        len_so_far=0
    fi
    loadit_script $script
done

# for script in ${scripts[@]}; do
#     loadit_script $script
# done

# for i in ${!scripts[@]}; do
#     loadit_script ${scripts[$i]}
#     if (( !(($i + 1) % 7) )); then
#         echo ""
#     fi
# done

export SHELL="/bin/bash"
export EDITOR="/usr/bin/nvim"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    os_name="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    os_name="mac"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    os_name="cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    os_name="mingw"
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    os_name="win32"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    os_name="freebsd"
else
    # Unknown.
    os_name="unknown"
fi

# prompt line
BRANCH="\$(git_branch_cutted)"

export PS1="${BLUE}${BRANCH}${END} ${GREEN}\u ${YELLOW}\W ${DOLLAR}${END} "

# colors
set colored-stats on

# Nice output and secure deletion/moving and verbosity
if [ "$TERM" != "dumb" ]; then
 eval "`dircolors -b`"
 alias ll='ls -l -F -h -X --group-directories-first --color=always --hide=*~'
 alias lla='ls -lA -F -h -X --group-directories-first --color=always'
 alias la='ls -a'
fi
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias rm='rm -iv'
alias cp='cp -vR'

# Handy directory aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

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

alias vircvim_old='vim '$home'.vimrc'
alias vircvim='vim ~/.config/nvim/init.vim'

alias vircbash="vim $rcbash"


# ############## gr4log

# gr4log
dirgr4log=$HOME'/gr4log/'
dir_gr4scripts="$HOME/gr4log/scripts"
alias gr4log='vim '$dirgr4log'gr4log.vim'
alias gr4log_sync=$dirgr4log'gr4log_git_update.sh'
alias cdgr4log='cd '$dirgr4log

alias vgr4='vim -O bashrc alias/install.sh ~/.bashrc'
alias vgrc='cd $dir_gr4scripts && vgr4'

alias log='cdgr4log;gr4log'
alias log_dreamer='vim '$dirgr4log'LOG/logDreamer.vim'
# sync all
alias syncall='gr4log_sync'


dir_datagrab='/srv/centroid/datagrab/'
alias cd_datagrab='cd '$dir_datagrab
alias venv_datagrab='source '$dir_datagrab'/venv_data_py36/bin/activate'


logAutomateMe=$dirgr4log'LOG/dev/logAutomateMe.vim'

dirkiwilog=$dirgr4log'LOG/work/kiwi/'
# logs
alias v1='vim -O '$rcbash' '$gr4env
alias v2='cd '$dirgr4log';vim -O '$dirgr4log'gr4log.vim '$dirkiwilog'kiwi\ log.vim '$logAutomateMe
alias v3='vim -O '$dirgr4log'LOG/nix/logFedora.vim '$dirgr4log

if [[ $(apt_installed thefuck) ]]; then
    eval $(thefuck --alias)
fi

alias cdC='cd /mnt/C'
alias cdD='cd /mnt/D'






# colorscheme from
# http://ciembor.github.io/4bit/#

# data:text/plain,%23!%2Fbin%2Fbash %0A%0A%23 Save this script into set_colors.sh%2C make this file executable and run it%3A %0A%23 %0A%23 %24 chmod %2Bx set_colors.sh %0A%23 %24 .%2Fset_colors.sh %0A%23 %0A%23 Alternatively copy lines below directly into your shell. %0A%0Agconftool-2 --set %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fuse_theme_background --type bool false %0Agconftool-2 --set %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fuse_theme_colors --type bool false %0Agconftool-2 -s -t string %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fbackground_color '%23393902022727'%0Agconftool-2 -s -t string %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fforeground_color '%23d9d9e6e6f2f2'%0Agconftool-2 -s -t string %2Fapps%2Fgnome-terminal%2Fprofiles%2FDefault%2Fpalette '%23000000000000%3A%23bdbd4c4c4f4f%3A%234f4fbdbd4c4c%3A%23bdbdbaba4c4c%3A%234c4c4f4fbdbd%3A%23baba4c4cbdbd%3A%234c4cbdbdbaba%3A%23e1e1e1e1e1e1%3A%231a1a1a1a1a1a%3A%23e8e8bfbfc0c0%3A%23c0c0e8e8bfbf%3A%23e8e8e6e6bfbf%3A%23bfbfc0c0e8e8%3A%23e6e6bfbfe8e8%3A%23bfbfe8e8e6e6%3A%23ffffffffffff'%0A

# Save this script into set_colors.sh, make this file executable and run it:
#
# $ chmod +x set_colors.sh
# $ ./set_colors.sh
#
# Alternatively copy lines below directly into your shell.

#if [ -n $set_colors_gconftool ]
#then
#	gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_background --type bool false
#	gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_colors --type bool false
#	gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/background_color '#393902022727'
#	gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/foreground_color '#d9d9e6e6f2f2'
#	gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/palette '#000000000000:#bdbd4c4c4f4f:#4f4fbdbd4c4c:#bdbdbaba4c4c:#4c4c4f4fbdbd:#baba4c4cbdbd:#4c4cbdbdbaba:#e1e1e1e1e1e1:#1a1a1a1a1a1a:#e8e8bfbfc0c0:#c0c0e8e8bfbf:#e8e8e6e6bfbf:#bfbfc0c0e8e8:#e6e6bfbfe8e8:#bfbfe8e8e6e6:#ffffffffffff'
#fi


dirsonginator='/srv/songinator/'
alias cdsonginator='cd $dirsonginator'

# colors
set colored-stats on

# Nice output and secure deletion/moving and verbosity
if [ "$TERM" != "dumb" ]; then
 eval "`dircolors -b`"
 alias ll='ls -l -F -h -X --group-directories-first --color=always --hide=*~'
 alias lla='ls -lA -F -h -X --group-directories-first --color=always'
fi

alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias rm='rm -iv'
alias cp='cp -vR'

# Handy directory aliases
alias ..='cd ..'
alias ...='..;..'
alias ....='..;...'
alias .....='..;....'

# ele
## log analyzers
export SIGROK_FIRMWARE_DIR='/home/dd/DATA/dev/log_analyzer/fw'


# computer specific
user=$USER
home='/home/'$user'/'
home_root='/root/'
rcbash=$home'.bashrc'
rcbash_root=$home_root'.bashrc'

vrc () { vim $rcbash $DIR_DD/dotfiles/bashrc.sh; }
src () { source $rcbash; }

export PYTHONDONTWRITEBYTECODE=1  # do not write pyc files when running python

# export MESA_GL_VERSION_OVERRIDE=4.6

echo ""
echo "gr4viton .bashrc loaded!"

LANG=en_GB.UTF-8
LANGUAGE=en_US
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
