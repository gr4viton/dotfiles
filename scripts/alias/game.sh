
# - https://www.reddit.com/r/Steam/comments/99fjzw/steam_proton_for_non_steam_applications/
# - https://github.com/ValveSoftware/Proton/issues/260

proton () {
    dir_compat=/fun/GAME/STEAM/steamapps/compatdata/
    proton_file=~/.steam/steam/steamapps/common/Proton\ 5.0/proton
    set -x
    STEAM_COMPAT_DATA_PATH=$dir_compat "$proton_file" $@
    set +x
}

proton_run () {
    game_exe=$1
    dir_compat=/fun/GAME/STEAM/steamapps/compatdata/
    proton_file=~/.steam/steam/steamapps/common/Proton\ 5.0/proton
    set -x
    STEAM_COMPAT_DATA_PATH=$dir_compat "$proton_file" run "$game_exe"
    set +x
}

proton_witcher1 () {
    proton_run "/fun/GAME/witcher1/witcher1/The\ Witcher\ Enhanced\ Edition/launcher.exe"
    proton_run "/fun/GAME/witcher1/witcher1/The\ Witcher\ Enhanced\ Edition/System/watcher.exe"
}

gr4_folderize "game_witcher1_save" "/fun/GAME/STEAM/steamapps/compatdata/20900/pfx/drive_c/users/steamuser/My Documents/The Witcher/saves"

gr4_folderize "game_witcher2_save" "/home/dd/.local/share/cdprojektred/witcher2/GameDocuments/The Witcher/saves"

