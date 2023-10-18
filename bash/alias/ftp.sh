# __ftp__
# ftp + ftpfs
endora_me () {
    echo "Input user gr4viton, and pwd"
    echo
    ftp sasanka.endora.cz
}


gr4_folderize endora_gr4viton "/media/ftp/gr4viton.cz/"


mount_ftp_endora_gr4viton () {
    password="${1:?password}"
    mount_ftp sasanka.endora.cz $direndora_gr4viton gr4viton $password

}
