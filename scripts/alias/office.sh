#!/bin/bash

alias vimo='vim -O'

# alias mux='tmuxinator'
alias mux='tmuxp'
alias muxl='tmuxp load'
muxe() {
    vim ~/.tmuxp/$1.yml
}

# ag-silversearcher
alias agp='ag --py '
# find all non-get dicts value accesses via str key (=dict_['something'])

agp_dict() { 
    agp "\[['|\"][^,]*?['|\"]\]";
}

viag() {
    vimo $(ag -l $@)
}

viagp() {
    vimo $(agp -l $@)
}

gr4_folderize() {
    # ${param:?word} writes word to stdout when param is unset or null
    local abbrev="${1:?No abbreviation alias.}"
    local folder="${2:?No directory to folderize.}"

    export dir${abbrev}="$folder"
    which > /dev/null 2>&1 cd${abbrev} || alias cd${abbrev}="cd $folder"
    which > /dev/null 2>&1 ls${abbrev} || alias lll${abbrev}o="lla $folder"
}

gr4_folderize "das_film" "/media/dd/datasss/FILM/"
gr4_folderize "nas_film" "/media/nas/video/film"
gr4_folderize "nas_serial" "/media/nas/video/serial"
gr4_folderize "nas_serial_man_inHighCastle" "/media/nas/video/serial/alternazi"
gr4_folderize "xnas_stuff" "/media/nas/video/video/meme/trailery/old"


gr4_mkdir_move() {
    local what="${1:?No files.}"
    local new_dir="${2:?No directory to move to.}"
    mkdir -p $new_dir
    mv $what $new_dir
}

alias mvc=gr4_mkdir_move

alias rename_make_lowercase="rename 'y/A-Z/a-z/' *"
