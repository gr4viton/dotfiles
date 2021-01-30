# __sshfs - filesystem over sshfs

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


sshfs_mount () {
    user_ip=${1:?user_ip}
    remote_path="${2:?remote_path}"
    mnt_path=${3:?mount_path}
    port="${4:-}"

    if [ ! -d $mnt_path ]; then
        sudo mkdir -p $mnt_path
    fi
    echo ">>> mounting"
    echo "   remote filesystem: $user_ip $port"
    echo "        via sshfs to: $mnt_path"

    port_cmd="-p $port"
    [ -z "$port" ] && port_cmd=""

	sshfs_options="-o allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa"
	sshfs_options="reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,allow_other,default_permissions,IdentityFile=~/.ssh/id_rsa"

    sudo sshfs -o $sshfs_options $user_ip:$remote_path $mnt_path $port_cmd || return
	# sshfs_post_mount $key
}

sshfs_mount_retrokodi () {
    dir_local="/mnt/sshfs/retrokodi"
    sshfs_mount $con_userip_retrokodi $dir_local
    ll $dir_local
    cd $dir_local
}

sshfs_mount_s8 () {
    dir_local="/mnt/sshfs/s8"
    sshfs_mount $con_userip_retrokodi $dir_local
    ll $dir_local
    cd $dir_local
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
    # key=${1:?key in the_config.connect.ssh}
    # mnt_path=$(sshfs_mount_path $key)
    sudo umount $mnt_path
}

sshfs_mount_retrokodi_lubricus () {
    user_ip=
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


sshfs_omatic () {
    local name="$1"
    local userip="$2"
    local remote_path="$3"
    local mount_path="$4"
    local port="$5"
    local info="$6"
    shift
    shift
    shift

    # sshfs filesystem
    which > /dev/null 2>&1 ${name}_mount_sshfs || alias ${name}_mount_sshfs="echo $info; sshfs_mount $userip $remote_path $mount_path $port"
    which > /dev/null 2>&1 ${name}_umount_sshfs || alias ${name}_umount_sshfs="sshfs_umount $mount_path"

    # post mount
    # folderize from file
    # post umount
    # unalias folderize after umount
}

# LOCAL CONFIG
sshfs_omatic "s8" "$con_userip_s8" "/data/data/com.termux/files/home/" "/mnt/sshfs/s8" "$con_sshport_s8" "be sure the device is running ssh daemon - in termux run 'sshd'"
sshfs_omatic "retrokodi" "$con_userip_retrokodi" "/" "/mnt/sshfs/retrokodi"

