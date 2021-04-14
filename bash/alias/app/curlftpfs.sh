# __curlftpfs__

mount_ftp () {
    # not sure if works
    local server="${1:?ftp server must be specified}"
    local mount_dir="${2:?ftp mount directory must be specified}"
    local user="${3:?user must be specified}"
    local password="${4:?password must be specified}"
    echo "> unmounting the folder $mount_dir"
    umount $mount_dir
    echo "> mounting the remote ftp $server as a filesystem to $mount_dir"
    set -x
    curlftpfs "$server" "$mount_dir" -o user="$user:$password"
    set +x
    # curlftpfs ftp.example.com /mnt/ftp/ -o user=username:password
    # from https://wiki.archlinux.org/index.php/CurlFtpFS
    echo "> lla $mount_dir"
    lla $mount_dir
}

