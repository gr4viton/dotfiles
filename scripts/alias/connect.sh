#!/bin/bash


### gr4viton
alias dalek_me='ssh pi@192.168.0.198'

# octopi
alias octopi_me='ssh pi@192.168.0.111'
#alias centroid_me='ssh pi@192.168.0.199'
alias centroid_me='ssh pi@10.8.0.39'

# nas ds218j
alias tapa_me='ssh gr4viton@192.168.0.118'
alias nas_ssh='ssh gr4viton@192.168.0.118'

# rpi3b+ retropie
alias retropie_me='ssh pi@192.168.0.105'
# 164 = old rpi1
# 163 = rpi3b+

endora_me () {
    echo "Input user gr4viton, and pwd"
    echo
    ftp sasanka.endora.cz
}


mount_ftp () {
    local server="${1:?ftp server must be specified}"
    local mount_dir="${1:?ftp mount directory must be specified}"
    local user="${1:?user must be specified}"
    curlftpfs $server $mount_dir -o user=$user
}

gr4_folderize endora_gr4viton "/media/ftp/gr4viton.cz/"
alias mount_ftp_endora_gr4viton="mount_ftp sasanka.endora.cz $direndora_gr4viton gr4viton"
