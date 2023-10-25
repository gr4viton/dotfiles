#!/bin/bash
# __dirs__


# watch
gr4_folderize "das_film" "/media/dd/datasss/FILM/"
gr4_folderize "nas_film" "/media/nas/video/film"
gr4_folderize "nas_serial" "/media/nas/video/serial"
gr4_folderize "nas_serial_man_inHighCastle" "/media/nas/video/serial/alternazi"
gr4_folderize "xnas_stuff" "/media/nas/video/video/meme/trailery/old"


alias psagent="ps -aux | grep 'cache\|probe\|eval' --color=always | sort - k11"

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
gr4_folderize "nasphoto" "${dirnas}photo/"
gr4_folderize "nasgame" "${dirnas}game/"
gr4_folderize "nashistory" "${dirnas}history/"
gr4_folderize "nasmusic" "${dirnas}music/"
gr4_folderize "naswatch" "${dirnas}watch/"


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

# freecad
folderize "fc" "/srv/dd/component/freecad/"

# sweethome3d
folderize "sh3d" "/home/dd/DATA/barak/model/sweethome3d/"

# __pyhovel
folderize "hovel" "/srv/dd/component/pyhovel"

# __aoc advent of code
folderize "aoc" "/srv/dd/component/aoc/"

sh3d_to_endora () {
    # not tested on creation

    # only_copy=${3?:insert any value to skip the ftp mounting}
    only_copy=$3
    if [[ -z "$only_copy" ]]; then
        echo "> mounting ftp endora"
        password="${1?:password for the ftp}"
        mount_ftp_endora_gr4viton $password
    else
        echo "> skipping the ftp mounting"
    fi

    sub_folder="${2?:subfolder in export folder}"
    whole_path="/home/$USER/DATA/barak/model/sweethome3d/export/$sub_folder"

    # folder=$(dirname "$whole_path")
    folder=$whole_path
    echo "> ls $folder"
    ls $folder
    mounted_ftp_path="/media/ftp/gr4viton.cz/gr4viton.cz/web/ALL/barak/exports/krajni/"
    echo "> gonna copy export "
    echo "    from: $whole_path"
    echo "      to: $mounted_ftp_path"
    cp "$whole_path"/* "$mounted_ftp_path"
}


# gr4log
# logs
logAutomateMe=$dirgr4log'LOG/dev/logAutomateMe.vim'
dirkiwilog=$dirgr4log'LOG/work/kiwi/'

gr4_folderize "dot" "$HOME/dd/dotfiles"
gr4_folderize "dotkw" "$HOME/dd/dd-kw-dotfiles"
