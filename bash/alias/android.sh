# termux executable

dtermux_shortcuts="/data/data/com.termux/files/home/.shortcuts/"
dtermux_tasks="${dtermux_shortcuts}tasks"

termux_create_widget_script_dirs () {
	mkdir -p $dtermux_shortcuts
	mkdir -p $dtermux_tasks
}

termux_initial_setup_android () {
    pkg update
    pkg install git openssh neovim
    mkdir $HOME/dd
    cd dd
    git clone https://github.com/gr4viton/dotfiles
    export DIR_DD="$pwd"
}

termux_vi_url_opener () {
    echo "youtube-dl $1"
    vim ~/bin/termux-url-opener
}
