#!/bin/bash

shin_ip[dalek]="pi@192.168.0.198"
shin_ip[octopi]="pi@192.168.0.111" # was 199
shin_ip[centroid]="pi@10.8.0.39"
shin_ip[retropie]="pi@192.168.0.105"
shin_ip[tapa]="gr4viton@192.168.0.118"
# 164 = old rpi1
# 163 = rpi3b+

from_get () {
    # non functional
    dict=${1:?dict}
    key=${2:?key}
    value=${${dict}[$key]}
    echo $value
}

shin () {
	conf_shin_file="~/.config/shin.rc"
glom $conf_shin_file $key
    key=${1:?key shin_ip dict}
    user_ip=${shin_ip[$key]}
    glom
    echo ">>> connecting via ssh to $user_ip"
    ssh $user_ip
}


### gr4viton
alias dalek_me="shin dalek"
alias octopi_me="shin octopi"
alias centroid_me="shin centroid"
alias tapa_me="shin tapa"
# alias nas_ssh="shin tapa"
ssh_nas () {
	ssh gr4viton@192.168.0.118
}
ssh_rpi () {
	ssh pi@192.168.0.110
	# ssh pi@192.168.0.105
}

ssh_s8 () {
    ssh 192.168.0.108 -p 8022
}

mosh_rpi () {
	mosh pi@192.168.0.105
}
# alias retropie_me="shin retropie"


# sshfs
sshfs_mount_path () {
    key=${1:?key shin_ip dict}
    echo "/media/ssh/$key/"
}

sshfs_keys () {
    # =(retropie dalek octopi centroid tapa)
    cat $the_config | yq '.connect.ssh | to_entries[].key'
}

# cat config.yaml | yq '.connect.ssh[]'
ssh_alia () {
    key=${1:?key shin_ip dict}
    echo "ssh_$key"
}

ssh_local_abbrev () {
    key=${1:?key in the_config.connect.ssh}
    abbrev=${2:?remote folderizer abbrev}
	echo "ssh_${key}_$abbrev"
}

for key in ${sshfs_keys[@]}; do
    alia=$(ssh_alia $key)
    path=$(sshfs_mount_path $key)
    gr4_folderize $alia $path
done

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

sshfs_mount () {
    key=${1:?key in the_config.connect.ssh}
    user_ip=${shin_ip[$key]}
    mnt_path=$(sshfs_mount_path $key)
    if [ ! -d $mnt_path ]; then
        sudo mkdir $mnt_path
    fi
    echo ">>> mounting remote filesystem $user_ip via sshfs to $mnt_path"
	sshfs_options="-o allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa"
	sshfs_options="reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa"

    sudo sshfs -o $sshfs_options $user_ip:/ $mnt_path || return

	sshfs_post_mount $key
}

sshfs_post_mount () {
    key=${1:?key in the_config.connect.ssh}
    mnt_path=$(sshfs_mount_path $key)

    fold_path=$(cat $the_config | yq -r ".connect.ssh.$key.folderizer")
    fold_file="${mnt_path}${fold_path}"
    echo ">>> searching for folderizer setup in $fold_file"
    base_path=${mnt_path}
    folderize_from_file $fold_file $base_path
}

sshfs_umount () {
    key=${1:?key in the_config.connect.ssh}
    mnt_path=$(sshfs_mount_path $key)
    sudo umount $mnt_path
}


# ftp + ftpfs
endora_me () {
    echo "Input user gr4viton, and pwd"
    echo
    ftp sasanka.endora.cz
}


mount_ftp () {
    local server="${1:?ftp server must be specified}"
    local mount_dir="${1:?ftp mount directory must be specified}"
    local user="${1:?user must be specified}"
    curlftpfs $server $mount_dir -o user=$user
}

gr4_folderize endora_gr4viton "/media/ftp/gr4viton.cz/"

alias mount_ftp_endora_gr4viton="mount_ftp sasanka.endora.cz $direndora_gr4viton gr4viton"


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
    rsync $_basic_rsync_kwargs "${@:1:$#-1}" 192.168.0.108:$out -e 'ssh -p 8022' --rsync-path=/data/data/com.termux/files/usr/bin/rsync
}

# nas
rsync_to_nas() {
__usage="
Usage: $(basename $0) [OPTIONS]

Options:
    copy to nas via rsync
    example:
    nas_rsync_cp -zz "booo/*" /volume1/video/
    if you use wildcards, enquote the argument (like in the example

    -a = take folder - use the / at the end
    -n = dry run
    nas_rsync_cp_precompress -an zz/ /volume1/video/
"
if [ "$1" == "-h" ]; then
  echo "$__usage"
else

    last=${@:$#} # last parameter
    other=${*%${!#}} # all parameters except the last
    in=$other
    out=$last

    set -x
    rsync $_basic_rsync_kwargs $in gr4viton@192.168.0.118:$out --rsync-path=/opt/bin/rsync
    set +x
fi
}

rsync_to_nas_zip_it () {
    nas_rsync_cp -C "$@"
}

rsync_to_nas_precompress () {
    # precompress sent data, but decompress on reciever
    nas_rsync_cp -zz "$@"
}

alias rsync_progress="rsync -a --info=progress2"


rsync_to_l5401 () {
    last=${@:$#} # last parameter
    other=${*%${!#}} # all parameters except the last
    in=$other
    out=$last

    address="dd@192.168.0.110"
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

ssh_l5401 () {
    ssh -6 dd@fe80::65bd:f19:c882:8b95%enx00e04c41b085
}
