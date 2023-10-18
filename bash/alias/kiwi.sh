alias do_login="docker login $KIWI_DOCKER_REGISTRY_URL"

# alias bag_copy_test_env_from_keybase="cp /run/user/1000/keybase/kbfs/team/kiwi_autobaggage/* /srv/kw/autobaggage/"

pip_compile_reqs () {
    path="${1?path to requirements file without suffix}"
    out="${path}.txt"
    in="${path}.in"

    pypi_username=$2
    pypi_password=$3

    pypi_username_redacted="<pypi_username>"
    pypi_password_redacted="<pypi_password>"

    extra_index_url_arg=""

    if [[ ! -z "$pypi_username" ]]; then
        # get extra-index-url line from requirements in file
        extra_index_url_from_in=$(cat $in | grep "extra-index-url")
        extra_index_url_arg=$(
            echo $extra_index_url_from_in | sed "s|//|//${pypi_username}:${pypi_password}@|"
        )
        extra_index_url_arg_safe=$(
            echo $extra_index_url_from_in | sed "s|//|//${pypi_username_redacted}:${pypi_password_redacted}@|"
        )
    fi

    echo "> running"
    echo "pipenv run pip-compile --output-file $out $in $extra_index_url_arg_safe"
    pipenv run pip-compile --output-file $out $in $extra_index_url_arg

    # redact the pypi username and password
    sed -i "s|${pypi_username}|${pypi_username_redacted}|" $out
    sed -i "s|${pypi_password}|${pypi_password_redacted}|" $out
    sed -i "s|$extra_index_url_arg_safe||" $out

    # the first line in requirements.txt with --extra-index-url should be also deleted
    # as it should either contain real pypi credentials or they should be left blank!
    # --extra-index-url https://<pypi_username>:<pypi_password>@pypi.skypicker.com/pypi

    echo ">>> calling git diff to see what new packages were compiled"
    git diff -- $out
    echo "!!! check that you are not gonna push your pypi_password to git !!!"
}

pip_bump_reqs () {

echo <<EOF
running:
$ pip_bump_reqs $@

Usage:
  python 3 with requirements/base.in + requirements/test.in
  $ pip_bump_reqs --three requirements/base requirements/test

  python 2.7 with requirements.in
  $ pip_bump_reqs 2.7 requirements

EOF
    python_version_pipenv="$1"
    echo "Python version: $1"
    shift  # in $@ are now all but the $1 arguments
    # all other arguments are used as requirement_files - passed without suffixes

    if [ -f .env ]; then
        echo "> loading PYPI variables from '.env' file"
        export $(cat .env | grep 'PYPI' | grep -v '#' | awk '/=/ {print $1}')
    fi

echo <<EOF
Setup
    > you have to have 'pipenv' installed
        pipenv: $(which pipenv)
    > you have to have PIPY_USERNAME and PIPY_PASSWORD in '.env' file
        PYPI_USERNAME: $pypi_username
    > you have to run the script from repostory root
        current working directory: $(pwd)

> creating python venv via 'pipenv $python_version_pipenv'
EOF
    PIPENV_DEFAULT_PYTHON_VERSION=$python_version_pipenv pipenv update
    pipenv run pip install pip-tools
    for reqs_stub in "$@"
    do
        echo "> running pip_compile_reqs for $reqs_stub"
        pip_compile_reqs $reqs_stub $PYPI_USERNAME $PYPI_PASSWORD
    done
}

pip_bump_reqs_kiwi () {
    URL=$PIP_EXTRA
    pip_bump_reqs $@ --extra-index-url $URL
}

pip_bump_reqs_bb () {
    pip_bump_reqs 3.8 requirements/base
}

dir_pip_conf="$HOME/.config/pip/pip.conf"

pip_conf_virc () {
    vim $dir_pip_conf
}

pc_reqs_bump () {
    pip_bump_reqs "requirements"
    pip_bump_reqs "test-requirements"
}

# black box

do_ext_build () {
    extension=${1:?extension with a dot, eg. .yaml or .dev.yaml}
    _do_build "docker-compose${extension}"
}


do_ext_up () {
    extension=${1:?extension with a dot, eg. .yaml or .dev.yaml}
    do_up "docker-compose${extension}"
}


# __bb_up () {
#     category=$1

# python - <<EOF
# import argparse
# dc_files = dict(
#     dev='docker-compose.dev.yml',
#     pudb='dev/docker-compose.pudb.yml',
# )
# parser = sysargparse.ArgumentParser
# parser.add_argument("category", type=str)
# args = parser.parse_args()
# key = args.category
# return dc_files[key]
# EOF
# $1
# }

bb_dcf_dev='docker-compose.dev.yml'
bb_dcf_pudb='docker-compose.pudb.yml'

bb_do_dev_build () { _do_build $bb_dcf_dev ; }
bb_do_dev_up () { do_up $bb_dcf_dev ; }
bb_do_pudb_build () { _do_build $bb_dcf_pudb ; }
bb_do_pudb_up () { do_up $bb_dcf_pudb ; }

do_pudb_yml_build () { do_ext_build ".pudb.yml" ; }
do_pudb_yml_up () { do_ext_up ".pudb.yml" ; }

do_dev_yml_build () { do_ext_build ".dev.yml" ; }
do_dev_yml_up () { do_ext_up ".dev.yml" ; }

do_pudb_yaml_build () { do_ext_build ".pudb.yaml" ; }
do_pudb_yaml_up () { do_ext_up ".pudb.yaml" ; }

do_dev_yaml_build () { do_ext_build ".dev.yaml" ; }
do_dev_yaml_up () { do_ext_up ".dev.yaml" ; }

alias bb_build="do_pudb_yaml_build"
alias bb_up="do_cat_up pudb"
# unalias bb_up

# bb_up () { do_cat_up pudb; }

bb_up_sh () {
    dc_option='shell' bb_up
}


bb_reqs_bump () {
    set -x
    pip_bump_reqs "requirements/base"
    pip_bump_reqs "requirements/test"
    set +x
}

bb_swag () {
    swag_validate $dirbbkw/swagger/black_box.yaml
}

bb_run () {
    do_run black-box_app "$@"
}

bb_run_sh () {
    do_run black-box_app /bin/sh "$@"
}

bb_run_test () {
    bb_run python test.py
}

# bb_run_root () {
#     do_run_root black-box_app $@
# }

# bag

bag_update_dev_from_keybase () {

    cd /srv/kw/abag_dev
    gpull_rebase

    cdbag
    no_unstaged="git diff --exit-code"
    if [ -z no_unstaged ]; then
        find . -name '*.py' | cpio -pdm $dirbag
    fi
}

_bag_test () {
    cdbag
    no_unstaged=$(git diff --exit-code)

    if [ -z $no_unstaged ]; then
        echo "has no unstaged"
    else
        echo 'has some'
    fi
}

# bag

alias bag_container_config_connect='docker exec -it srv_da_autobaggage_dev_config-api_1 bash -c "tmux a"'

bag_check_vault () {
    export VAULT_ADDR=$KIWI_VAULT_ADDR
    bash $dirbag/dev/dev-start.sh vault_check
}

bag_tmux () {
    if [[ "$(pwd)" != "$dirbag" ]]; then
        if $(ask_yes "Do you want to cd into $dirbag?"); then

            cdbag
        else
            echo "skipping bag_tmux"
            return
        fi
    fi

    make tmux-start
}
alias bag_build="make build-dev"
alias bag_run="make run-dev-tmux"
alias vibag="cdpcama; ..; vimo travelport/api.py $dirbagtra/base.py $dirbagtra/step.py $dirbagtra/../baggage_model.py"

step_frozen_show () {
    # opens egrep filtered files in vim
    # run like
    # step_frozen_show <egrep_regex>
    # eg.
    # step_frozen_show "service.*order.*res"

    step_frozen_run_command "ls" "Do_you_want_to_ls_the_displayed_files?" "" $@
}

step_frozen_open () {
    # opens egrep filtered files in vim
    # run like
    # step_frozen_open <egrep_regex>
    # eg.
    # step_frozen_open "service.*order.*res"

    step_frozen_run_command "vimo" "Do_you_want_to_open_the_displayed_files in vim?" "" $@
}

step_frozen_rm () {
    # removes egrep filtered files
    # run like
    # step_frozen_rm <egrep_regex>
    # eg.
    # step_frozen_rm "service.*order.*res"

    step_frozen_run_command "rm" "Do_you_want_to_remove_the_displayed_files?" "" $@
}

step_frozen_mv () {
    # moves egrep filtered files to the folder specified as the last argument
    # run like
    # step_frozen_mv <egrep_regex> <dir_to_move_files_to>
    # eg.
    # step_frozen_mv "service.*order.*res" "/tmp/output/files/"

    mv_dir=${@:$#} # last parameter
    other=${*%${!#}} # all parameters except the last
    step_frozen_run_command "mv" "Do_you_want_to_move_the_displayed_files to $mv_dir?" $mv_dir $other
}

step_frozen_cp () {
    # copies egrep filtered files to the folder specified as the last argument
    # run like
    # step_frozen_mv <egrep_regex> <dir_to_move_files_to>
    # eg.
    # step_frozen_mv "service.*order.*res" "/tmp/output/files/"

    cp_dir=${@:$#} # last parameter
    other=${*%${!#}} # all parameters except the last
    step_frozen_run_command "cp" "Do_you_want_to_copy_the_displayed_files to $cp_dir?" $cp_dir $other
}

step_frozen_run_command () {
    # run command over egrep filtered files
    # run like
    # step_frozen_run_command "mv" "question" "where_to_move" "service.*order.*res"

    local the_command="${1:?Command to run over the filtered files}"
    local the_question="${2:?Question to ask before the command is ran}"
    local the_command_suffix="${3}"
    # rest from arg 4  is passed to the egrep

    # only from current directory (ls -A1)
    # files=$(ls -A1 | egrep "${@:3}")
    if [[ $the_command = "rm" ]]; then
        files=$(ls -A1 | egrep "${@:4}")
    else
        files=$(ls -A1 | egrep "${@:4}" | tr '\n' ' ')
    fi
    if [[ -z "$files" ]]; then
        echo ">>> No files matches your regex"
    else
        echo $files | tr ' ' '\n'
        if $(ask_yes ">>> $the_question")
        then
            echo ">>> Running the following command"
            echo "$the_command ${files} ${the_command_suffix}"
            $the_command ${files} $the_command_suffix
        fi
    fi
}


alias vpn_connect_openfortivpn="sudo openfortivpn -v"

# you have to define ams_login_usr_at_ip to use ams aliases
if [[ -z ${ams_login_usr_at_ip} ]]; then
    echo 'Not found env var `ams_login_usr_at_ip` - not defining ams functions'
else
    # echo "Found ams_login_usr_at_ip"

    export ams_login=$ams_login_usr_at_ip

    export tmux_suffix=' -t "LANG=en_US.utf8 bash -c \"tmux a -t DD || tmux new DD\""'
    ams_login_tmux=$ams_login$tmux_suffix

    alias ams_warning="for n in {1..42}; do echo $'CAREFULL! YOU ARE ON A PRODUCTION AMS SERVER !!! YOU MUST KNOW WHAT YOU ARE DOING !!! !!! !!!'; done"

    ssh_ams () {
        ams_warning
        ssh $ams_login
    }

    # alias ams_ssh='ssh_ams'
    alias ssh_amst='ams_warning; ssh '$ams_login_tmux

    ams_cp_one () {
        scp "$ams_login:$1" $2
    }

    ams_logs_fname () {
        bid=$1
        echo "/tmp/logs_for_bid_$bid.txt"
    }
    ams_json_local_path () {
        json_full_path=$1
        base=$(basename $json_full_path)
        echo "/tmp/$base"
    }

    ams_open_local_logs() {
        bid=$1
        echo ">>> open local logs file bid=$bid"
        vim $(ams_logs_fname $bid)
    }
    ams_log2="/srv/automation/tools/log_v2.py"

    ams_get_bid_logs_force () {
        bid=$1
        logs_fname=$(ams_logs_fname $bid)
        echo ">>> generating the logs file on ams"
        ams_warning; ssh -t $ams_login "$ams_log2 $bid -p > $logs_fname; ls $logs_fname; exit"
        echo ">>> copy logs file from ams to local [ssh_ams:$logs_fname -> $logs_fname]"
        ams_cp_one $logs_fname $logs_fname
    }

    ams_get_bid_logs () {
        bid=$1
        logs_fname=$(ams_logs_fname $bid)
        if [[ -f $(ams_logs_fname $bid) ]]; then
            echo ">>> skipping logs getting from ams, log file already exist - to force run ams_get_bid_logs_force"
            echo "> using logs file: $logs_fname"
        else
            ams_get_bid_logs_force $bid
        fi
    }

    ams_get_bid_logs_open () {
        bid=$1
        ams_get_bid_logs $bid
        ams_open_local_logs $bid
    }

    ams_get_bid_logs_get_json_fnames () {
        bid=$1
        ams_get_bid_logs $bid
        fnames=$(ams_local_get_json_fnames $@ -j)
        export ams_last_fnames=$fnames
        if [[ -z $fnames ]]; then
            echo "No fnames found - skipping"
        fi
        # call again to print info
        echo ">>> getting json filenames"
        ams_local_get_json_fnames $@ -V
    }

    ams_get_bid_logs_get_json_cmds () {
        bid=$1
        ams_get_bid_logs $bid
        fnames=$(ams_local_get_json_fnames $@)
        export ams_last_fnames=$fnames
        if [[ -z $fnames ]]; then
            echo "No fnames found - skipping"
        fi
        # call again to print info
        echo ">>> getting json filenames"
        ams_local_get_json_fnames $@ -V
    }

    ams_copy_jsons_to_local () {
        ams_get_bid_logs_get_json_fnames $@
        cnt=$(echo -n "$fnames" | grep -c '^')
        echo ">>> copying $cnt json files from ams"
        for fname in $fnames
        do
            local_fname=$(ams_json_local_path $fname)
            if [[ -z $local_fname ]]; then
                echo "> getting json file from ams [$local_fname]"
                ams_cp_one $fname $local_fname
            else
                echo "> already exist - skipping get json file from ams [$local_file]"
            fi
        done

    }

    ams_dev_run_call () {

        # get the filenames
        ams_get_bid_logs_get_json_fnames $@
        fnames=$ams_last_fnames
        if [[ -z $fnames ]]; then
            echo "ams_last_fnames env var not set - try debug ams_get_bid_and_jsons manually"
        fi
        for fname in $fnames
        do
            echo ">>> $fname"
        done

        bid=$1
        logs_fname=$(ams_logs_fname $bid)

        echo ">>> generating the logs file on ams"
        ams_warning; ssh -t $ams_login "$ams_log2 $bid -p > $logs_fname; ls $logs_fname; exit"

        echo ">>> copy logs file from ams to local"
        ams_cp_one $logs_fname $logs_fname

    }


    ams_local_get_json_fnames () {
        bid=$1
        logs_fname=$(ams_logs_fname $bid)

        python /srv/kw/automation/tools/logs_json_parser.py $logs_fname "${@:2}"
        # ${@:2}  # = all args skipping the first
    }


alias devserver1='warning; ssh -t '$ams_login' "for n in {1..12}; do echo \"Logging into '$dev_name' server! - '$dev_ip'\"; done; ssh unseen@'$dev_ip' -t bash"'

    kw_open_devserver() {

        dev_format=$1
        dev_num=$2
        dev_ip=$3
        dev_name=$dev_format$dev_num

        #ams_cmd='"for n in {1..12}; do echo \"Logging into '$dev_name' server! - '$dev_ip'\"; done; ssh unseen@'$dev_ip' -t bash"'

        # ams_dev_ip=10.2.42.156
        ams_dev_ip=10.2.42.207
        ams_dev_call $ams_dev_ip "bash"
    }

    ams_dev_call () {
        ams_dev_ip=$1
        ams_cmd=$2
        if [[ -z $ams_cmd ]]; then
            ams_cmd="bash; echo exited"
        fi
        ssh $ams_login -t "echo '>>> CONNECTED TO AMS'; ssh unseen@$ams_dev_ip -t $ams_cmd"
    }
    alias ams_dev_11="kw_open_devserver $dev_format 11 '10.2.42.156'"


    _kw_open_devserver() {

        dev_format=$1
        dev_num=$2
        dev_ip=$3
        dev_name=$dev_format$dev_num
        warning; ssh -t $ams_login "for n in {1..12}; do echo \"Logging into $dev_name server! - '$dev_ip\"; done; ssh unseen@$dev_ip -t \"LANG=en_US.utf8 bash -c \"tmux a -t DD || tmux new DD\"\" "

    }

    alias dev11="kw_open_devserver $dev_format 11 '10.2.42.150'"
    dev5_ip="10.2.42.207"
    alias dev5="kw_open_devserver $dev_format 11 $dev5_ip"

fi

# sabre

sabre_create_token () {
    client_id="${1:?Client id starting V1}"
    client_secret="${1:?Client id}"
    echo -n `echo -n $client_id | base64`:`echo -n $client_secret | base64` |base64
}

kw_rogue_info () {
    echo "$(cat <<EOF
Inside the pipenv shell
pip install -r reqs/base.txt  # installs rogue dependecies
pip install -e .  # installs rogue from source as local package via setup.py

source .env  # source the precreated .env file
cd /srv/rogue/examples

# check you are on dev-ethernet / vpn - otherwise the vault is unaccessible
python get_exact_provider.py  # run the rogue
# should give you the output of provider data
EOF
    )"
}



okta_gitlab_login () {
    xdg-open $KIWI_OKTA_LOGIN_URL
}

pip_search_versions_kiwi () {
    pip_search_versions $KW_PYPI_URL $@
}
pip_search_versions_pc () {
    pip_search_versions_kiwi kw.provider-clients $@
}
pip_search_versions_pc_10 () {
    pip_search_versions_pc 10
}
