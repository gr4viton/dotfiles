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
    key=${1:?key shin_ip dict}
    user_ip=${shin_ip[$key]}
    echo ">>> connecting via ssh to $user_ip"
    ssh $user_ip
}


### gr4viton
alias dalek_me="shin dalek"
alias octopi_me="shin octopi"
alias centroid_me="shin centroid"
alias tapa_me="shin tapa"
alias nas_ssh="shin tapa"
alias retropie_me="shin retropie"


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



# nas
nas_rsync_cp() {
    # copy to nas via rsync
    # example:
    # nas_rsync_cp -zz "booo/*" /volume1/video/
    # if you use wildcards, enquote the argument (like in the example

    # -a = take folder - use the / at the end
    # -n = dry run
    # nas_rsync_cp_precompress -an zz/ /volume1/video/


    last=${@:$#} # last parameter
    other=${*%${!#}} # all parameters except the last
    in=$other
    out=$last

    set -x
    rsync -v --info=progress2 $in gr4viton@192.168.0.118:$out --rsync-path=/opt/bin/rsync
    set +x
}

nas_rsync_cp_zip_it () {
    nas_rsync_cp -C "$@"
}

nas_rsync_cp_precompress () {
    # precompress sent data, but decompress on reciever
    nas_rsync_cp -zz "$@"
}


