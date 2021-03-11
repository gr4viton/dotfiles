#!/bin/bash


# watch
gr4_folderize "das_film" "/media/dd/datasss/FILM/"
gr4_folderize "nas_film" "/media/nas/video/film"
gr4_folderize "nas_serial" "/media/nas/video/serial"
gr4_folderize "nas_serial_man_inHighCastle" "/media/nas/video/serial/alternazi"
gr4_folderize "xnas_stuff" "/media/nas/video/video/meme/trailery/old"


# kiwi folders

gr4_folderize "da" "/srv/kw"
gr4_folderize "kw" "/srv/kw"
gr4_folderize "kiwi" "/srv/kiwi"

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
        gr4_folderize $abbrev"sab" "$repo_path_kw/$folder_each/sabre"
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

# kw.gds-observer
gr4_folderize_kiwi $dirda "go" "gds-observer" "" "" "docker-compose.yml" "" "kw/gds_observer"
# kw.gds-viewer
gr4_folderize_kiwi $dirda "gv" "gds-viewer" "" "" "docker-compose.yml" "" "kw/gds_viewer"

# kw.autobaggage
gr4_folderize_kiwi $dirda "bag" "autobaggage" "modules" "tests/unit" "docker-compose.yml" "docker-compose.dev.yml"
dirbag_log=$dirbag'logs/data/'

gr4_folderize "baggds" "${dirbagkw}/modules/gds"
gr4_folderize "baglogfreeze" "${dirbag}/logs/freeze"

alias vipbag='cd '$dirbagmod'; vim amadeus.py'
alias vipamad='cdauto; vim '$dirbook$amad

# kw.faust-lib
gr4_folderize_kiwi $dirda "faust" "faust-lib" "" "" "" "" "kw/faust_client"

# kw.provider-clients
gr4_folderize_kiwi $dirda "pc" "provider-clients" "client" "" "" "" "kw/provider"
gr4_folderize "pcgds" "${dirpckw}/client/gds"
gr4_folderize "pcpro" "${dirpckw}/proton"

dirwsdl='/srv/kw/wsdl/tport/system_v32_0'
alias cdwsdl='cd '$dirwsdl

# kw.black-box
gr4_folderize_kiwi $dirda "bb" "black-box" "" "" "" "" "kw/black_box"
# gr4_folderize "bb" "${dirbb}/proton"

# kw.cronos
gr4_folderize_kiwi $dirda "cron" "cronos" "" "" "" "" "kw/cronos"
# gr4_folderize "bb" "${dirbb}/proton"

# kw.refunderino
gr4_folderize_kiwi $dirda "refr" "refunderino" "" "" "" "" "kw/crefunderino"

# kw.configuru
gr4_folderize_kiwi $dirda "conf" "configuru" "" "" "" "" "kw/configuru"

# kw.autobooking - backbone
gr4_folderize_kiwi $dirda "back" "backbone" "" "" "" "" "kw/autobooking"

# wiki - handbook
gr4_folderize "wik" "$dirda/handbook"
gr4_folderize "wiki" "$dirwik/src/docs/autobooking/gds"

# kw.dbmodels
gr4_folderize_kiwi $dirda "dbmodels" "dbmodels"
alias venv_dbmodels='cd_dbmodels; source venv3/bin/activate'

# kw.automation
gr4_folderize "aut" "$dirda/automation"
# gr4_folderize "anskw" "$dirbag/kw/autobaggage"
gr4_folderize "autbook" "$diraut/booking"
gr4_folderize "autair" "$diraut/booking/airlines"
gr4_folderize "autgds" "$diraut/booking/airlines/gds"
gr4_folderize "autama" "$diraut/booking/airlines/gds/amadeus"
gr4_folderize "auttra" "$diraut/booking/airlines/gds/travelport"
gr4_folderize "autsab" "$diraut/booking/airlines/gds/sabre"
# gr4_folderize "autobs" "$dirautbook/gds_observer"
# gr4_folderize "autque" "$dirautobs/queues_observer"
# gr4_folderize "antage" "$dirautobs/agent_performance"

autama="$dirautair/amadeus_partner.py"
auttra="$dirautair/travelport_partner.py"

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


gr4_folderize "roms_local" "/media/dd/datasss/GAMESY/roms/"

gr4_folderize "bkp" "/srv/_all/"
gr4_folderize "bkp_dd" "/srv/_all/home/dd/"
gr4_folderize "bkp_ddused" "/srv/_all/home/dd/used"

gr4_folderize "dd" "/srv/dd/"
gr4_folderize "web" "/srv/dd/component/web_blog/gr4viton.gitlab.io"
viweb () {
    cd $dirweb/content/posts
    vim to-write.md
}

gr4_folderize "kodi" "/srv/dd/component/kodi/hello_world/dd-addon-brutall"
gr4_folderize "kodirc" "$HOME/.kodi"

kodilog () {
    cat $dirkodirc/temp/kodi.log | less -t
}

# nas ds218
gr4_folderize "nas" "/media/nas/"
gr4_folderize "nasvideo" "${dirnas}video/"
gr4_folderize "nashomes" "${dirnas}homes/"


# projects
gr4_folderize "component" "/srv/dd/component/"
gr4_folderize "songiton" "${dcomponent}/songiton/fastapi"

# project songinator
dirsonginator='/srv/songinator/'
alias cdsonginator='cd $dirsonginator'


# project centroid
dir_datagrab='/srv/centroid/datagrab/'
alias cd_datagrab='cd '$dir_datagrab
alias venv_datagrab='source '$dir_datagrab'/venv_data_py36/bin/activate'


# ele
## log analyzers
export SIGROK_FIRMWARE_DIR='/home/dd/DATA/dev/log_analyzer/fw'

# mount windows C, D
alias cdC='cd /mnt/C'
alias cdD='cd /mnt/D'


# sweethome3d
folderize "sh3d" "/home/dd/DATA/barak/model/sweethome3d/"

sh3d_to_endora () {
    # not tested on creation
    echo "> mounting ftp endora"
    mount_ftp_endora_gr4viton
    folder="${1?:subfolder in export folder}"
    ls $folder
    whole_path="~/DATA/barak/model/sweethome3d/export/$folder/krajni/"
    mounted_ftp_path="/media/ftp/gr4viton.cz/gr4viton.cz/web/ALL/barak/export"
    echo "> gonna copy export from $whole_path to $mounted_ftp_path"
    cp $whole_path $mounted_ftp_path
}


# gr4log
# logs
logAutomateMe=$dirgr4log'LOG/dev/logAutomateMe.vim'
dirkiwilog=$dirgr4log'LOG/work/kiwi/'

