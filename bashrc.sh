#!/bin/bash

if [ -z "$DIR_DD" ]; then
    echo "DIR_DD varialble not defined!"
fi
DIR_DDD="$DIR_DD/dotfiles/"

# .env file load
source "$HOME_DD/dd/dd_env"

loadit() {
    script_path=$1
    if [ -f $script_path ]; then
        . $script_path
        script_name=$(basename $script_path)
        # script_name=$($script_name%%.*)
        # echo -n "$script_name "
        if [[ -z "$DOTFILES_SILENT_LOADING" ]]; then
            echo -n "$(basename $script_name .sh) "
        fi
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

# central config for dotfiles - never used yet
# the_config=${DIR_DD}the_config.yaml

# ############## LOAD ALIASES AND FUNCTION FILES ###############

HOSTNAME=$(hostname)

# echo "Sourcing ${DIR_DDD}/device_config.sh"
loadit "${DIR_DDD}/device_config.sh"


if [[ "$HOSTNAME" == "dddell-latitude-5401" ]]; then
    DD_SELECTOR="full"
    USER_DD="dd"
elif [[ "$HOSTNAME" == "dd-think" ]]; then
    DD_SELECTOR="work"
    USER_DD="dd"
    DOTFILES_SILENT_LOADING=1
elif [[ "$HOSTNAME" == "ubuntu" || "$HOSTNAME" == "rosbot" ]]; then
    DD_SELECTOR="ros"
    USER_DD="ubuntu"
elif [[ "$HOSTNAME" == "localhost" ]]; then
    DD_SELECTOR="droid"
    # add decision to distinguish between androids
    # https://www.reddit.com/r/termux/comments/ctl5gj/how_to_uniquely_identify_a_termux_device/
    USER_DD=$con_user_s8
    USER_DD=$con_user_s20
elif [[ "$HOSTNAME" == "gr4retropie" ]]; then
    DD_SELECTOR="retro_kodi"
    USER_DD=$con_user_rpi
else
    DD_SELECTOR="full"
    USER_DD="dd"
fi

if [[ "$DD_SELECTOR" == "droid" ]]; then
	HOME_DD="/data/data/com.termux/files/home/"
	HOME_ROOT="/root/"
	# deprecated:
	# $home -> HOME_DD
	# $user -> USER_DD
	# $home_root -> HOME_ROOT
else
	HOME_DD="/home/${USER_DD}/"
	HOME_ROOT="/root/"
fi

if [[ -z "$DOTFILES_SILENT_LOADING" ]]; then
  echo "Sourcing [$DD_SELECTOR script] files from $DIR_LOADIT_SCRIPT:"
fi

# script lists
# - all script lists should contain the alias/git.sh
#   - because the ps1 prompt uses the `git_branch_cutted` function

# prompt line - ps1
# source $DIR_DD/dotfiles/bash/ps1.sh
# basic stuff - colors, ll, cd.., grep, rm ...
# source $DIR_DD/dotfiles/bash/basic.sh


if [[ "$DD_SELECTOR" == "full" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"

            # basic
            "alias/app/ag.sh"
            "alias/app/apt.sh"
            "alias/app/git.sh"
            "alias/app/python.sh"
            "alias/app/tmux.sh"
            "alias/app/vim.sh"
            "alias/app/ssh.sh"

            # laptop ubuntu
            "alias/app/aosd.sh"
            "alias/app/curlftpfs.sh"
            "alias/app/docker.sh"
            "alias/app/kubectl.sh"
            "alias/app/lxc.sh"
            "alias/app/redis.sh"
            "alias/app/tldr.sh"
            "alias/app/youtube-dl.sh"
            "alias/app/tizonia.sh"


        "alias/office.sh"
        "alias/ai.sh"
        "alias/monitor.sh"
        "alias/centroid.sh"
        "alias/install.sh"
        "alias/speak.sh"
        "alias/graphic.sh"
        "alias/dev.sh"
        "alias/esp32.sh"
        "alias/hw.sh"
        "alias/connect.sh"
        "alias/sshfs.sh"
        "alias/ssh.sh"
        "alias/ftp.sh"
        "alias/dell.sh"
        "alias/think-x1.sh"
        "alias/dirs.sh"
        "alias/config.sh"
        "alias/game.sh"
        "alias/dotfiles.sh"
    )

elif [[ "$DD_SELECTOR" == "work" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"

            # basic
            "alias/app/ag.sh"
            "alias/app/apt.sh"
            "alias/app/git.sh"
            "alias/app/python.sh"
            "alias/app/tmux.sh"
            "alias/app/vim.sh"
            "alias/app/ssh.sh"

            # laptop ubuntu
            "alias/app/aosd.sh"
            "alias/app/curlftpfs.sh"
            "alias/app/docker.sh"
            "alias/app/kubectl.sh"
            "alias/app/redis.sh"
            "alias/app/tldr.sh"

        "alias/office.sh"
        "alias/ai.sh"
        "alias/monitor.sh"
        "alias/centroid.sh"
        "alias/install.sh"
        "alias/graphic.sh"
        "alias/esp32.sh"
        "alias/hw.sh"
        "alias/connect.sh"
        "alias/sshfs.sh"
        "alias/ssh.sh"
        "alias/ftp.sh"
        "alias/dell.sh"
        "alias/think-x1.sh"
        "alias/dirs.sh"
        "alias/config.sh"
        "alias/game.sh"
        "alias/dotfiles.sh"
    )


elif [[ "$DD_SELECTOR" == "ros" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"

            # basic
            "alias/app/ag.sh"
            "alias/app/git.sh"
            "alias/app/python.sh"
            "alias/app/tmux.sh"
            "alias/app/vim.sh"
            "alias/app/ssh.sh"

            # ubuntu
            "alias/app/apt.sh"

        "alias/office.sh"
        "alias/connect.sh"
        "alias/sshfs.sh"
        "alias/ssh.sh"
        "alias/ftp.sh"

            # rosbot
            "alias/project/ros_bot.sh"

    )

elif [[ "$DD_SELECTOR" == "droid" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"

            # basic
            "alias/app/ag.sh"
            "alias/app/git.sh"
            "alias/app/python.sh"
            "alias/app/tmux.sh"
            "alias/app/vim.sh"

        "alias/office.sh"
        "alias/connect.sh"
        "alias/sshfs.sh"
        "alias/ssh.sh"
        "alias/ftp.sh"

        "alias/android.sh"
    )

elif [[ "$DD_SELECTOR" == "retro_kodi" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"

            # basic
            "alias/app/ag.sh"
            "alias/app/git.sh"
            "alias/app/python.sh"
            "alias/app/tmux.sh"
            "alias/app/vim.sh"

        "alias/office.sh"
        "alias/connect.sh"
        "alias/sshfs.sh"
        "alias/ssh.sh"
        "alias/ftp.sh"

        "alias/retropi.sh"
    )

elif [[ "$DD_SELECTOR" == "min" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"

            # basic
            "alias/app/ag.sh"
            "alias/app/git.sh"
            "alias/app/python.sh"
            "alias/app/tmux.sh"
            "alias/app/vim.sh"
            "alias/app/ssh.sh"

        "alias/office.sh"
        "alias/connect.sh"
        "alias/sshfs.sh"
        "alias/ssh.sh"
        "alias/ftp.sh"
    )

fi


# load scripts + echo their names if not disabled
_len_so_far=0
_limit_len_per_line=140
_start_line='>>> '
if [[ -z "$DOTFILES_SILENT_LOADING" ]]; then
    echo -en ${_start_line}
fi
for script in ${scripts[@]}; do
    script_name=$(basename $script)
    script_name="${script_name%%.*}"
    _len_so_far=$(( $_len_so_far + ${#script} ))
    if (( $_len_so_far > $_limit_len_per_line )); then
        if [[ -z "$DOTFILES_SILENT_LOADING" ]]; then
            # do the >>> for load_script echo filenames
            echo ""
            echo -en ${_start_line}
            _len_so_far=0
        fi
    fi
    loadit_script $script
done

# computer specific


rcbash="${HOME_DD}.bashrc"
rcbash_root="${HOME_ROOT}.bashrc"

src1 () {
    file="${1:-.bashrc}"
    if [[ "$file" == ".bashrc" ]]; then
        source "$rcbash";
    else
        shift
        file=$(ag --sh -l "$@" "${DIR_DDD}")
        echo "source $file"
        source "$file"
    fi
}
vrc1 () {
    file="${1:-.bashrc}"
    if [[ "$file" == ".bashrc" ]]; then
        vim "${DIR_DDD}bashrc.sh"
    else
        file=$(ag --sh -l "$@" "${DIR_DDD}")
        echo "vim $file"
        vim "$file"
    fi
}

src_ () {
    path="${1:-}"
    file="${2:-.bashrc}"
    if [[ "$file" == ".bashrc" ]]; then
        source "$rcbash";
    else
        shift
        file=$(ag --sh -l "$@" "${path}")
        echo "source $file"
        source $file
    fi
}
vrc_ () {
    path="${1:-}"
    file="${2:-.bashrc}"
    if [[ "$file" == ".bashrc" ]]; then
        vim "${path}bashrc.sh"
    else
        shift
        set -x
        file=$(ag --sh -l "$@" "${path}")
        set +x
        echo "vim $file"
        vim $file
    fi
}

src () { src_ "${DIR_DDD}" "$@" ; }
vrc () { vrc_ "${DIR_DDD}" "$@" ; }
vrcs () {
    vrc_ "${DIR_DDD}" "$@" ;
    src_ "${DIR_DDD}" "$@" ;
}
srckw () { src_ "${DIR_DDD_KW}" "$@" ; }
vrckw () { vrc_ "${DIR_DDD_KW}" "$@" ; }

# echo ""
echo "gr${c_red}4${c_end}viton .bashrc loaded!"

# ⇧2024-03-14
# zoxide

# eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"
eval "$(direnv hook bash)"
