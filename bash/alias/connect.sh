#!/bin/bash
# __connect__
# __folderize
folderize_from_file () {
    fil=${1?yaml file with config}
    base_path=${2?base path to which the folderizer config paths are relative to}

	backup_pwd=$(pwd)
	file_dir=$(dirname $fil)
	file_name=$(basename $fil)
	echo ">>> cd in $file_dir"
	cd $file_dir
	yaml=$(<$file_name)
	echo ">>> found folderizer setup:"
	echo "$yaml"

	yq_abbrev_path='.folder[] | {"abbrev": .abbrev, "path": .path}'

    for row in $(echo "$yaml" | yq -c '.folder[] | {"abbrev": .abbrev, "path": .path}'); do
		_yq () {
		  echo ${row} | jq -cr ${1}
		}

		remote_path=$(_yq '.path')
		local_abs_path=${base_path}${remote_path}

		remote_abbrev=$(_yq '.abbrev')
		local_abbrev=$(ssh_local_abbrev ${key} ${remote_abbrev})
		echo "> folderizing${c_green} ${local_abbrev} ${c_end}= ${local_abs_path}"
		gr4_folderize ${local_abbrev} ${local_abs_path}
	done
	cd $backup_pwd
}

_basic_rsync_kwargs="-v --info=progress2 --ignore-existing --safe-links"

echi () {
    echo ""
    echo "$@"
    echo "arg1=$1"
    echo "arg2=$2"
    echo "arg3=$3"
}

rsync_which_echi_works () {
    # input 3 args with spaces like
    # rsync_which_echi_works "asdh asd" "sbasd as das" "as das d"
    # the echi should output only first 2 args

    # other="${@:1:$#-1}"  # bashizm
    # in=$other

    echo "in='$in'"
    echo $in
    echi "$in"
    echi "$@"
    echi ${@:1:$#-1}
    echi "${@:1:$#-1}"
    echi ${*%${!#}}
    echi "${*%${!#}}"
    echi $other
    echi "$other"
    echo "out='$out'"
}

rsync_to_s8 () {
    d_prefix="/data/data/com.termux/files/home/"
    d_all="storage/shared/_ALL/"
    # "view/zz"
    out=${d_prefix}${d_all}${last}

    # last=${@:$#} # last parameter
    last="${!#}"   # last param
    # other=${*%${!#}} # all parameters except the last - works without bash
    rsync $_basic_rsync_kwargs "${@:1:$#-1}" 192.168.0.120:$out -e 'ssh -p 8022' --rsync-path=/data/data/com.termux/files/usr/bin/rsync
}

rsync_dir_from_s8 () {
    remote_path="$1"
    local_path="$2"

    rsync -a $_basic_rsync_kwargs $con_userip_s8:$remote_path $local_path -e 'ssh -p 8022' --rsync-path=/data/data/com.termux/files/usr/bin/rsync
}
# con_rsyncpath_s8="/data/data/com.termux/files/usr/bin/rsync"
dev_s8_dhome="/data/data/com.termux/files/home/"
dev_s8_dall="${dev_s8_dhome}/storage/shared/_ALL"

backup_dir_all_from_s8 () { rsync_dir_from_s8 "${dev_s8_dall}" "$HOME/DATA/s8/"; }

rsync_basic () {
    set -x
    rsync $_basic_rsync_kwargs "$@"
    set +x
}

rsync_from_s8__ () {
    local_path=$1
    remote_path=$2
    rsyncpath_cmd="--rsync-path=${con_rsyncpath_s8}"
    rsync_basic $con_userpi_s8:$remote_path $local_path -e $(echo "ssh -p $con_sshport_s8") $rsyncpath_cmd
}

# rsync_from_s8_home () { rsync_from_s8 $1 "${dev_s8_dhome}${2}"; }
# rsync_from_s8_all () { rsync_from_s8 $1 "${dev_s8_dall}${2}"; }

# nas
rsync_to_nas() {
__usage="
Usage: $ (basename $0) [OPTIONS]

Options:
    copy to nas via rsync
    example:
    rsync_to_nas -zz "booo/*" /volume1/video/
    if you use wildcards, enquote the argument (like in the example

    -a = take folder - use the / at the end
    -n = dry run
    rsync_to_nas -an zz/ /volume1/video/
"
if [ "$1" == "-h" ]; then
  echo "$__usage"
else

    last="${@:$#}" # last parameter
    other="${*%${!#}}" # all parameters except the last
    local_files="$other"
    remote_dir="$last"

    set -x
    rsync $_basic_rsync_kwargs $local_files "gr4viton@192.168.0.220:$remote_dir" --rsync-path=/opt/bin/rsync
    set +x
fi
}

rsync_from_nas () {
    last="${@:$#}" # last parameter
    other="${*%${!#}}" # all parameters except the last
    remote_files="$other"
    local_dir="$last"

    set -x
    rsync $_basic_rsync_kwargs "gr4viton@192.168.0.220:$remote_files" $local_dir --rsync-path=/opt/bin/rsync
    set +x
}


rsync_from_rpi_favourites () {
    remote_files="/home/pi/.kodi/userdata/favourites.xml"
    local_dir=$1

    set -x
    rsync $_basic_rsync_kwargs "pi@192.168.0.150:$remote_files" $local_dir
    set +x
}
rsync_from_rpi_favourites_to_linux () {
    local_dir="/home/dd/.kodi/userdata/"
    rsync_from_rpi_favourites $local_dir
}

rsync_to_nas_zip_it () {
    nas_rsync_cp -C "$@"
}

rsync_to_nas_precompress () {
    # precompress sent data, but decompress on reciever
    nas_rsync_cp -zz "$@"
}

rsync_dnz () {
    rsync_to_nas -a /home/dd/DATA/DNz/new/ /volume1/video/video/dnz/vid/new/
}

alias rsync_progress="rsync -a --info=progress2"

rsync_basic () {
    rsync $_basic_rsync_kwargs $@
}


rsync_to_l5401 () {
    last=${@:$#} # last parameter
    other=${*%${!#}} # all parameters except the last
    in=$other
    out=$last

    address="dd@192.168.0.199"
    # address='dd@[fe80::65bd:f19:c882:8b95%enx00e04c41b085]'
    # rsync -a --safe-links --info=progress2 $in dd@192.168.0.110:$out # --rsync-path=/opt/bin/rsync
    # rsync -va --ignore-existing --safe-links --info=progress2 -6  $in 'dd@[fe80::65bd:f19:c882:8b95%enx00e04c41b085]':$out # --rsync-path=/opt/bin/rsync
    set -x
    rsync -a $_basic_rsync_kwargs $in $address:$out # --rsync-path=/opt/bin/rsync
    set +x

 # ip -o link show  # to get the interface suffix after % = enx... = ethernet port
# ls /sys/class/net

# stop putting usb - eth device - to sleep
# https://askubuntu.com/questions/185274/how-can-i-disable-usb-autosuspend-for-a-specific-device
# inst tlp
# sudo vim /etc/default/tlp  # USB_BLACKLIST < usb id from lsusb
}

mount_camera () {
	gphotofs /media/camera/
}
umount_camera () {
	gphotofs -u /media/camera/
}

mount_android () {
	go-mtpfs /media/android/
}
umount_android () {
	go-mtpfs -u /media/android/
}
