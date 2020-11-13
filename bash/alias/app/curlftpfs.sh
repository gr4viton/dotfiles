mount_ftp () {
    local server="${1:?ftp server must be specified}"
    local mount_dir="${1:?ftp mount directory must be specified}"
    local user="${1:?user must be specified}"
    curlftpfs $server $mount_dir -o user=$user
}

