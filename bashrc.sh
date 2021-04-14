#!/bin/bash

if [ -z "$DIR_DD" ]; then
    echo "DIR_DD varialble not defined!"
fi
DIR_DDD="$DIR_DD/dotfiles/"

# .bashrc of gr4viton

. "$DIR_DDD/../local_rc.sh"

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

# central config for dotfiles - never used yet
# the_config=${DIR_DD}the_config.yaml

# ############## LOAD ALIASES AND FUNCTION FILES ###############

HOSTNAME=$(hostname)

echo "Sourcing ${DIR_DDD}/device_config.sh"
loadit "${DIR_DDD}/device_config.sh"


if [[ "$HOSTNAME" == "dddell-latitude-5401" ]]; then
    DD_SELECTOR="full"
    USER_DD="dd"
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

echo "Sourcing [$DD_SELECTOR script] files from $DIR_LOADIT_SCRIPT:"

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

        "alias/office.sh"
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
        "alias/dirs.sh"
        "alias/kiwi.sh"
        "alias/config.sh"
        "alias/game.sh"
        "alias/tags.sh"
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


_len_so_far=0
_limit_len_per_line=140
_start_line='>>> '
echo -en ${_start_line}
for script in ${scripts[@]}; do
    script_name=$(basename $script)
    script_name="${script_name%%.*}"
    _len_so_far=$(( $_len_so_far + ${#script} ))
    if (( $_len_so_far > $_limit_len_per_line )); then
        echo ""
        echo -en ${_start_line}
        _len_so_far=0
    fi
    loadit_script $script
done

# computer specific


rcbash="${HOME_DD}.bashrc"
rcbash_root="${HOME_ROOT}.bashrc"

src () {
    file="${1:-.bashrc}"
    if [[ "$file" == ".bashrc" ]]; then
        source $rcbash;
    else
        file=$(ag --sh -l "$@" ${DIR_DDD})
        echo "source $file"
        source $file
    fi
}
vrc () {
    file="${1:-.bashrc}"
    if [[ "$file" == ".bashrc" ]]; then
        # vim "${DIR_DDD}bashrc.sh" "${rcbash}" ;
        vim "${DIR_DDD}bashrc.sh"
    else
        file=$(ag --sh -l "$@" ${DIR_DDD})
        echo "vim $file"
        vim $file
    fi
}


echo ""
echo "gr${c_red}4${c_end}viton .bashrc loaded!"
