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


alias mount_ntfs_kill_hibernate_C='sudo umount /mnt/C || sudo mount -t ntfs-3g -o remove_hiberfile /dev/nvme0n1p3 /mnt/C && echo "/mnt/C remounted Successfully as rw!!"'
alias mount_ntfs_kill_hibernate_D='sudo umount /mnt/D || sudo mount -t ntfs-3g -o remove_hiberfile /dev/nvme0n1p9 /mnt/D && echo "/mnt/D remounted Successfully as rw!!"'

alias mount_C_ro='sudo mount -o ro /dev/nvme0n1p3 /mnt/C'
alias mount_D_ro='sudo mount -o ro /dev/nvme0n1p9 /mnt/D'


recheckout_current_branch() {
    cur=`git rev-parse --abbrev-ref HEAD`
    echo Current branch = $cur           
    git checkout master
    git branch -D $cur
    git pull
    git checkout $cur
}

# POSTGRES

alias dbm_change_db='vim /srv/da/dbmodels/kw/automation/dbmodels/settings_local.py'

alias dbm_psql='psql -h 172.17.0.2 -U postgres postgres'
alias dbm_psql_drop='psql -h 172.17.0.2 -U postgres postgres -c "drop schema public cascade;"'
alias dbm_psql_create='psql -h 172.17.0.2 -U postgres postgres -c "create schema public;"'
alias dbm_psql_recreate='dbm_psql_drop; dbm_psql_create'

alias dbm_alembic_upgrade_head='alembic upgrade head'
alias dbm_test_up='time alembic upgrade head'
alias dbm_test_down='time alembic downgrade -1'

alias dbm_test_once='dbm_test_up; dbm_test_down'
alias dbm_test_twice='dbm_test_once; dbm_test_once'

alias dbm_versions_sort='ls alembic/versions/ |sort -k1.14'

dbm_recheckout_master_alembic_fcn() {
    cur=`git rev-parse --abbrev-ref HEAD`
    echo Current branch = $cur           
    git checkout master
    cur_master=`git rev-parse --abbrev-ref HEAD`
    if [ cur_master -ne "master" ]; then
        echo "You did not switch to master branch!"
        exit;
    fi
    git pull
    while true; do
        read -p "Are you sure you are not deleting PRODUCTION DB !???! " yn
        case $yn in
            [Yy]* ) dbm_psql_drop; dbm_psql_create; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    
    alembic upgrade head
    git checkout $cur
}

alias dbm_recheckout_master_alembic='dbm_recheckout_master_alembic_fcn'


export WORKON_HOME='~/venvs/'
source /home/dd/.local/bin/virtualenvwrapper.sh


alias urxvt_reload='xrdb -load ~/.Xdefaults'

#
#alias docker_containers_remove_stopped="docker ps -aq --no-trunc | xargs docker rm"
# Remove stopped containers
# This command will not remove running containers, only an error message will be printed out for each of them.
