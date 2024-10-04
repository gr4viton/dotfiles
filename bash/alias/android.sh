# termux executable
# - widget run termux script from homescreen

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

# share to termux
# click share on video - select termux youtube-dl get's the link and does its thing
# like: https://www.reddit.com/r/Android/comments/66kehg/twoclick_downloads_of_youtube_videos_straight/

termux_ydl_config () {
	echo " -o /data/data/com.termux/files/home/storage/shared/_ALL/Download/%(title)s.%(ext)s "
	vim ~/.config/youtube-dl/config

	echo "youtube-dl $1"
	vim "~/bin/termux-url-opener"

}


#from linux-android.sh
dir_songiton="~/dd/songiton"

alias cdsongiton="cd $dir_songiton"

rsync_dcim_pack () {
	rsync -av --exclude ".thumbnails" --safe-links --ignore-existing --info=progress2 storage/dcim/packovic-let gr4viton@192.168.0.220:/volume1/video/foto/droid --rsync-path=/opt/bin/rsync
}

dirdcim="$HOME/storage/dcim/"
cddcim () { cd $dirdcim ; }

rsync_from_termux () {
	dirlocal=$1
	dirremote=$2
	echo "> syncing"
	echo "  from $dirlocal"
	echo "    to $dirremote"
	remote_url="gr4viton@192.168.0.220:$dirremote"
	set -x
	rsync -av --exclude ".thumbnails" --safe-links --ignore-existing --info=progress2 $dirlocal $remote_url --rsync-path=/opt/bin/rsync
	set +x
}

rsync_dcim () {
    dirremote="/volume1/video/foto/droid"
    dirlocal="$HOME/storage/dcim/"
    rsync_from_termux $dirlocal $dirremote
}

rsync__dnz () {
    dirremote="/volume1/video/video/dnz/vid/new"
    dirlocal="$HOME/storage/shared/_ALL/view/"
    rsync_from_termux $dirlocal $dirremote
}
