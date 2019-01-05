#!/bin/bash

# files
## configs
alias virctmuxp="vim -O ~/.confix/tmuxp/*.yml"

alias cdtmuxp="cd ~/.tmuxp/"

# watch
gr4_folderize "das_film" "/media/dd/datasss/FILM/"
gr4_folderize "nas_film" "/media/nas/video/film"
gr4_folderize "nas_serial" "/media/nas/video/serial"
gr4_folderize "nas_serial_man_inHighCastle" "/media/nas/video/serial/alternazi"
gr4_folderize "xnas_stuff" "/media/nas/video/video/meme/trailery/old"


# kiwi folders

gr4_folderize "da" "/srv/da"

gr4_folderize_kiwi () {

    local repo_base="${1:?No all repos base folder!}"
    local abbrev="${2:?No abbreviation base alias.}"
    local repo_name="${3:?No base directory to folderize.}"
    
    local repo_path="$repo_base/$repo_name"

    local folder_each="${4}" # provider each directory to folderize 
    local folder_test="${5}"
    local docker_file_path="${6}"
    local docker_file_path_dev="${7}"
    local specific_kw_path="${8}"

    gr4_folderize $abbrev "$repo_path"
    if [[ -n "$specific_kw_path" ]]; then
        repo_path_kw="$repo_path/$specific_kw_path"
    else
        repo_path_kw="$repo_path/kw/$repo_name"
    fi
    gr4_folderize $abbrev"kw" "$repo_path_kw"

    if [[ -n "$folder_each" ]]; then
        gr4_folderize $abbrev"each" "$repo_path_kw/$folder_each"
        gr4_folderize $abbrev"ama" "$repo_path_kw/$folder_each/amadeus"
        gr4_folderize $abbrev"tra" "$repo_path_kw/$folder_each/travelport"
    fi

    if [[ -n "$folder_test" ]]; then
        gr4_folderize $abbrev"test" "$repo_path/$folder_test"
    fi

    # docker files
    if [[ -n "$docker_file_path" ]]; then
        export ${abbrev}doco="$repo_path/$docker_file_path"
    fi

    if [[ -n "$docker_file_path_dev" ]]; then
        export ${abbrev}doco_dev="$repo_path/$docker_file_path_dev"
    fi

    if [[ -n "$docker_file_path" ]] || [[ -n "$docker_file_path_dev" ]]; then
        local doco=(${abbrev}"doco")
        local docot=(${abbrev}"doco_dev")
        local do="$repo_path/Dockerfile"
        which > /dev/null 2>&1 "vido${abbrev}" || alias vido${abbrev}="vim -O ${!doco} ${!docot} ${do}"
    fi

}

# kw.autobaggage
gr4_folderize_kiwi $dirda "bag" "autobaggage" "modules" "tests/unit" "docker-compose.yml" "docker-compose.dev.yml"
dirbag_log=$dirbag'logs/data/'
alias vipbag='cd '$dirbagmod'; vim amadeus.py'
alias vipamad='cdauto; vim '$dirbook$amad

# kw.provider-clients
gr4_folderize_kiwi $dirda "pc" "provider-clients" "client" "" "" "" "kw/provider"
dirwsdl='/srv/da/wsdl/tport/system_v32_0'
alias cdwsdl='cd '$dirwsdl

# kw.dbmodels
gr4_folderize_kiwi $dirda "dbmodels" "dbmodels"
alias venv_dbmodels='cd_dbmodels; source venv3/bin/activate'

# kw.automation
gr4_folderize "aut" "$dirda/automation"
# gr4_folderize "anskw" "$dirbag/kw/autobaggage"
gr4_folderize "autbook" "$diraut/booking"
gr4_folderize "autobs" "$dirautbook/gds_observer"
gr4_folderize "autque" "$dirautobs/queues_observer"
gr4_folderize "antage" "$dirautobs/agent_performance"

alias psagent="ps -aux | grep 'cache\|probe\|eval' --color=always | sort - k11"

# kw.gds-observer
dirgdsobs=$da_dir'gds-observer/'
alias vigdsobs='cdgdsobs; vim -O amadeus.py base.py store.py'


# kw.rogue
gr4_folderize_kiwi $dirda "rogue" "rogue" "provider"
alias virogue='cdrogue; vim -O amadeus.py base.py store.py'

# kw .. others
gr4_folderize_kiwi $dirda "ans" "ancillary_servants" "providers"
gr4_folderize_kiwi $dirda "anc" "ancillaries" "providers"
gr4_folderize_kiwi $dirda "chef" "chef"
gr4_folderize_kiwi $dirda "thief" "thief"
gr4_folderize_kiwi $dirda "proton" "proton"

dircc=$da_dir'conveyor-client/'
alias cdcc='cd $dircc'



