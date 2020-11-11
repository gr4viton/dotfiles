#!/bin/bash

if [ -z "$DIR_DD" ]; then
    echo "DIR_DD varialble not defined!"
fi
DIR_DDD="$DIR_DD/dotfiles/"

# .bashrc of gr4viton

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

if [[ "$HOSTNAME" == "dddell-latitude-5401" ]]; then
    _scripts="full"
elif [[ "$HOSTNAME" == "ubuntu" || "$HOSTNAME" == "ros_bot" ]]; then
    _scripts="ros"
else
    _scripts="full"
fi

echo "Sourcing [$_scripts script] files from $DIR_LOADIT_SCRIPT:"

# script lists
# - all script lists should contain the alias/git.sh
#   - because the ps1 prompt uses the `git_branch_cutted` function

# prompt line - ps1
# source $DIR_DD/dotfiles/bash/ps1.sh
# basic stuff - colors, ll, cd.., grep, rm ...
# source $DIR_DD/dotfiles/bash/basic.sh

if [[ "$_scripts" == "full" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"
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
        "basic.sh"
        "alias/office.sh"
        "alias/git.sh"
        "alias/connect.sh"
        "alias/ros.sh"
    )

elif [[ "$_scripts" == "min" ]]; then

    scripts=(
        "ps1.sh"
        "basic.sh"
        "alias/office.sh"
        "alias/git.sh"
        "alias/connect.sh"
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

# deprecated:
# $home -> HOME_DD
# $user -> USER_DD
# $home_root -> HOME_ROOT
USER_DD="dd"
HOME_DD="/home/${USER_DD}/"
HOME_ROOT="/root/"

rcbash="${HOME_DD}.bashrc"
rcbash_root="${HOME_ROOT}.bashrc"

ssasd () { echo "A" ; }

src () { source /home/dd/.bashrc ; }
vrc () { vim "${rcbash}" "${DIR_DD}/dotfiles/bashrc.sh" ; }


echo ""
echo "gr${c_red}4${c_end}viton .bashrc loaded!"
