alias do_login="docker login $KIWI_PYPI_REGISTRY_LOGIN"

# alias bag_copy_test_env_from_keybase="cp /run/user/1000/keybase/kbfs/team/kiwi_autobaggage/* /srv/da/autobaggage/"

bag_update_dev_from_keybase () {

    cd /srv/da/abag_dev
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

bag_frozen_open () {
    bag_frozen_run_command "vimo" "Do_you_want_to_open_the_displayed_files?" "" $@
}

bag_frozen_mv () {
    bag_frozen_run_command "rm" "Do_you_want_to_remove_the_displayed_files?" "" $@
}

bag_frozen_mv () {
    mv_dir=${@:$#} # last parameter 
    other=${*%${!#}} # all parameters except the last
    bag_frozen_run_command "mv" "Do_you_want_to_move_the_displayed_files?" $mv_dir $other
}

bag_frozen_run_command () {
    local the_command="${1:?Command to run over the filtered files}"
    local the_question="${2:?Question to ask before the command is ran}"
    local the_command_suffix="${3}"
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

        python /srv/da/automation/tools/logs_json_parser.py $logs_fname "${@:2}"
        # ${@:2}  # = all args skipping the first
    }


alias devserver1='warning; ssh -t '$ams_login' "for n in {1..12}; do echo \"Logging into '$dev_name' server! - '$dev_ip'\"; done; ssh unseen@'$dev_ip' -t bash"'

    kw_open_devserver() {

        dev_format=$1
        dev_num=$2
        dev_ip=$3
        dev_name=$dev_format$dev_num

        #ams_cmd='"for n in {1..12}; do echo \"Logging into '$dev_name' server! - '$dev_ip'\"; done; ssh unseen@'$dev_ip' -t bash"'

        ams_dev_ip=10.2.42.156
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

fi

# sabre

sabre_create_token () {
    client_id="${1:?Client id starting V1}"
    client_secret="${1:?Client id}"
    echo -n `echo -n $client_id | base64`:`echo -n $client_secret | base64` |base64
}
