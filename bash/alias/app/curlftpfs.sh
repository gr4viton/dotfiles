mount_ftp () {
    local server="${1:?ftp server must be specified}"
    local mount_dir="${2:?ftp mount directory must be specified}"
    local user="${3:?user must be specified}"
    set -x
    curlftpfs $server $mount_dir -o USER=$user
    set +x
}

