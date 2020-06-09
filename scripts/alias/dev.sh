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

# https://askubuntu.com/questions/5980/how-do-i-free-up-disk-space
alias apt_list_biggest_packages="dpkg-query -W --showformat='\$\{Installed-Size\} \$\{Package\}\n' | sort -nr | less"
alias apt_list_biggest_packages='dpkg-query -W --showformat="${Installed-Size} ${Package}\n" | sort -nr | less'





alias pipenv="python3 -m pipenv"

# alias pip_compile_basic='pip-compile --no-index --output-file requirements.txt requirements.in'
# alias pip_compile_test='pip-compile --no-index -r requirements.txt --output-file ./test-requirements.txt ./test-requirements.in'

# alias pip_compile_both='pip_compile; pip_compile_test'


# sound
alias sound_restart="pulseaudio -k && sudo alsa force-reload"


alias samsung_mount="sudo jmtpfs /media/samsungS8; ls /media/samsungS8"
alias samsung_unmount="fusermount -u /media/myphone"


alias pyc_remove_recursively='sudo find . -name "*.pyc" -exec rm -f {} \;'

function pudb_connect () {
    port="${1-6900}"

    telnet 127.0.0.1 $port
}

pudb_loop () {
    _seconds=2
    while true;
    do
        term_clear
        dat=$(date +'%Y-%m-%d_%H:%M:%S')
        echo ">>> Trying to connect to remote pudb every $_seconds seconds [$dat]"
        pudb_connect
        last=$!
        echo "last output = $last"
        if [[ "$last" == "0" ]]; then
            break
        fi
        sleep $_seconds
    done
}

swag_validate () {
    swag_file="${1?swagger file}"
    swagger-cli validate $swag_file
}

alias py="ipython"
alias ppy="python"
alias py3="ipython3"
alias ppy3="python3"


redis_flushall () {
    redis-cli FLUSHALL
}


alias pie="pipenv"
alias pier="pie run"
alias piep="pie run python"
alias pies="pie shell"
alias pie3="pie --three"

# kubectl kubernetes k8s
## alias kubectl to something sane
alias kcl='kubectl'
## alias to switch namespaces (kube switch namespace)
kcl_context_use_namespace () {
    namespace=$1
    kubectl config set-context --current --namespace=$namespace
}
## alias to switch context (kube switch context)
kcl_context_use () {
    context=$1
    set -x
    kubectl config use-context $context
    set +x
}
kcl_context_show_all () {
    kubectl config get-contexts
}

kcl_context_grep () {
    context_grep=$1
    kcl_context_show_all | grep $context_grep | awk '{print $2}'
}
kcl_context_use_grep () {
    kcl_context_use $(kcl_context_grep $@)
}

kcl_context_use_prod () {
    kcl_context_use_grep "autobooking-prod"
}

kcl_context_use_sandbox () {
    kcl_context_use_grep "autobooking-sandbox"
}

alias kcl_prod="kcl_context_use_prod"
alias kcl_sandbox="kcl_context_use_sandbox"

kcl_pod_grep () {
    kcl get pods --all-namespaces | grep $@
}
kcl_pod_all () {
    kcl get pods --all-namespaces
}

_kcl_pod_command_default="/bin/bash"

kcl_pod_exec_first () {
    name=$1
    command="${2:-$_kcl_pod_command_default}"
    pod_row=$(kcl_pod_grep $name | head -1)
    pod_namespace=$(echo $pod_row | awk '{print $1}')
    pod_name=$(echo $pod_row | awk '{print $2}')
    set -x
    kcl exec -it $pod_name -n $pod_namespace "$command"
    set +x
}


kcl_pod_exec_exact () {
    pod_name=$1
    kcl exec -it $pod_name $_kcl_pod_command
}
alias kcl_pod_exec="kcl_pod_exec_first"

kcl_in () {
    kcl_pod_exec "$1"
}

kcl_black () {
    kcl_pod_exec black-box "/bin/sh"
}
kcl_black_cmd () {
    cmd=$'\'$@\''
    kcl_pod_exec black-box '-- /bin/sh -c '"$cmd"
}

kcl_modules_staging () {
    # todo add git branch current as default
    branch="${1:-branch-dashed-name-first-9-letters}"
    cmd="/bin/sh"
    kcl_pod_exec "modules-staging-$branch"
}

kcl_gds_in_gcp () {
    kcl_pod_exec dd-gds-gc
}

kcl_pod_exec_namespace () {
    pod_name=$1  # eg black-box-7f6dc5956c-2fzmd
    name_space=$2  # eg black-box
    kcl exec -it $pod_name -n $name_space
}

# kubernetes deployments

kcl_rollout_restart_deploy () {
    name=$1
    pod_row=$(kcl_pod_grep $name | head -1)
    pod_namespace=$(echo $pod_row | awk '{print $1}')
    set -x
    kcl rollout restart deploy $pod_namespace -n $pod_namespace
    set +x
}
kcl_redeploy () {
    kcl_rollout_restart_deploy $@
}

kcl_redeploy_all_gds () {
    projects=( black-box schedule-changer configuru refundopedia gds-viewer gds-queue-handler master-switch vemark log-viewer )
    for var in "${projects[@]}"
    do
      echo "redeploy for: ${var}"
      kcl_redeploy ${var}
    done
}

kcl_deploy_undo () {
    name=$1
    kcl rollout undo deployment $name
}

kcl_deployment_history () {
    name=$1
    kcl rollout history deployment $name
}

kcl_deployment_status () {
    name=$1
    kcl rollout status -w deployment $name
}

kcl_deploy_revision () {
    name=$1
    revision_number="${2?revision number}"
    kcl rollout undo deployment --to-revision=$revision_number
}


pip_unused_packages () {
    echo "viz https://kiwi.wiki/handbook/how-to/manage-python-dependencies/"
    cat *requirements.in | grep --color=none "^[^#-][^][~=<># ]\+" -o | uniq | tr '-' '_' | xargs -I{} bash -c '! git --no-pager grep -w -q -i {} "*.py" && echo "{} not found in Python files"'
}
