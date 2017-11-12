#!/bin/bash

make_python_venv () {
    python3.6 -m venv $1

}

alias venv_cv2='source /srv/cv2/venv_cv2/bin/activate'

alias all_py='find . -type f -regextype sed -regex ".*\.py" -print0'

# https://stackoverflow.com/questions/1583219/awk-sed-how-to-do-a-recursive-find-replace-of-a-string
regex_all_py () {
    echo "Do you want to execute this regex:" 
    echo $1
    echo "On all the *.py files in this directory and subdirectories?:"
    all_py

    echo ""
    read -p "Do you really?" yn

    select yn in "Yes" "No"; do
        case $yn in
            Yes ) all_py | xargs -0 sed -i $1; break;;
            No ) exit;;
        esac
    done
} 

centroid_dir='/srv/centroid/'
alias cd_centroid='cd '$centroid_dir


# why is import cv2 functional only when venv_cv2 runned from /srv/


alias mount_ntfs_kill_hibernate='sudo umount /mnt/C || sudo mount -t ntfs-3g -o remove_hiberfile /dev/nvme0n1p3 /mnt/C && echo "/mnt/C remounted Successfully as rw!!"'
