

# gr4viton.cz/centroid


# what's the weather today
# bring a coat / sunglasses / umbrella
# play spotify in the kitchen
# turn the lights on
# download rick and morty latest with czech subtitles
# play latest rick and morty on all screens, with sound in combo
# play rick and morty - default

# MUSIC
# instant-music-downloader


# TRANS DATA
# download it into mobile
# where it is previously said content
# - music / rick and morty

# impl
# automatic alias creation for all the python functions


# POPCORN TIME API

nas_mount () {
    # needed inst nfs-common
    local="${1:?local mount directory}"
    remote="${2:?remote dir in volume1}"
    set -x
    sudo /sbin/mount.nfs 192.168.0.118:/volume1/$remote $local
    set +x
echo ">>> $local"
    ll $local
}
nas_umount () {
    local="${1:?local mount directory}"
# sudo /sbin/mount.nfs 192.168.0.118:/volume1/video $local
sudo umount $local
echo ">>> $local"
    ll $local
}

nas_mount_homes () {
    echo "Probly won't work cuz the folder shared ips is not *"
    showmount -e 192.168.0.118

    nas_mount $dirnashomes homes
}

nas_umount_homes () {
    nas_umount $dirnashomes
}

nas_mount_video () {
    nas_mount $dirnasvideo video
}
nas_umount_video () {
    nas_umount $dirnasvideo
}


alias cdnas="cd $dirnas"
alias cdnasvid="cd $dirnasvideo"
# not this
# sudo /sbin/mount.nfs -o username=gr4viton,password=* //192.168.0.118/volume1/video video

