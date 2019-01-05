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

alias dbm_autogenerate="alembic revision --autogenerate -m $msg"
alias dbm_run_postgres='docker run postgres'
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

alias dbm_venv='source /srv/da/dbmodels/venv3_test/bin/activate'

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
    
    echo 'Using this DATABASE settings:'
    echo $(python -c "from kw.automation.dbmodels.settings import DATABASES as DB; print(DB)")
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
# source /home/dd/.local/bin/virtualenvwrapper.sh



alias logrotate_edit='vim /etc/logrotate.conf'
alias log_varlog_space='sudo du -csh /var/log/*'

# https://askubuntu.com/questions/5980/how-do-i-free-up-disk-space
alias apt_list_biggest_packages="dpkg-query -W --showformat='\$\{Installed-Size\} \$\{Package\}\n' | sort -nr | less"
alias apt_list_biggest_packages='dpkg-query -W --showformat="${Installed-Size} ${Package}\n" | sort -nr | less'




alias pip_compile='pip-compile --no-index --output-file requirements.txt requirements.in'
alias pip_compile_test='pip-compile --no-index -r requirements.txt --output-file ./test-requirements.txt ./test-requirements.in'

alias pip_compile_both='pip_compile; pip_compile_test'

# git
alias glogd="git branch --sort=-committerdate"
alias gloghash='git log --pretty=format:"%h %s"'


# sound
alias sound_restart="pulseaudio -k && sudo alsa force-reload"


alias samsung_mount="sudo jmtpfs /media/samsungS8; ls /media/samsungS8"
alias samsung_unmount="fusermount -u /media/myphone"


alias pyc_remove_recursively='find . -name "*.pyc" -exec rm -f {} \;'
