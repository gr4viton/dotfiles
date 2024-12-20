#!/bin/bash
alias venv_cv2='source /srv/cv2/venv_cv2/bin/activate'

centroid_dir='/srv/centroid/'
alias cd_centroid='cd '$centroid_dir


# why is import cv2 functional only when venv_cv2 runned from /srv/


alias mount_ntfs_kill_hibernate_C='sudo umount /mnt/C || sudo mount -t ntfs-3g -o remove_hiberfile /dev/nvme0n1p3 /mnt/C && echo "/mnt/C remounted Successfully as rw!!"'
alias mount_ntfs_kill_hibernate_D='sudo umount /mnt/D || sudo mount -t ntfs-3g -o remove_hiberfile /dev/nvme0n1p9 /mnt/D && echo "/mnt/D remounted Successfully as rw!!"'

alias mount_C_ro='sudo mount -o ro /dev/nvme0n1p3 /mnt/C'
alias mount_D_ro='sudo mount -o ro /dev/nvme0n1p9 /mnt/D'

# POSTGRES

alias dbm_autogenerate="alembic revision --autogenerate -m $msg"
alias dbm_run_postgres='docker run postgres'
alias dbm_change_db='vim /srv/kw/dbmodels/kw/automation/dbmodels/settings_local.py'

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

alias dbm_venv='source /srv/kw/dbmodels/venv3_test/bin/activate'

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

# sound
alias sound_restart="pulseaudio -k && sudo alsa force-reload"


alias samsung_mount="sudo jmtpfs /media/samsungS8; ls /media/samsungS8"
alias samsung_unmount="fusermount -u /media/myphone"

swag_validate () {
    swag_file="${1?swagger file}"
    swagger-cli validate $swag_file
}

test_auto_db () {
    echo python -c "import psycopg2;try:;psycopg2.connect('$KIWI_AUTOMATION_DB_FULL_URL');except:print('does not work'); print('works')"
}



