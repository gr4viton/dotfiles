

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
# generate say alias...


# POPCORN TIME API

dirnas="/media/nas/"
dirnasvideo=$dirnas"video/"
nas_mount () {
    # needed inst nfs-common
    local=$dirnasvideo
    sudo /sbin/mount.nfs 192.168.0.118:/volume1/video $local
echo ">>> $local"
    ll $local
}

nas_umount () { 
    local=$dirnasvideo
# sudo /sbin/mount.nfs 192.168.0.118:/volume1/video $local
sudo umount $local
echo ">>> $local"
    ll $local
}

alias cdnas="cd $dirnas"
alias cdnasvid="cd $dirnasvideo"
# not this
# sudo /sbin/mount.nfs -o username=gr4viton,password=* //192.168.0.118/volume1/video video

