# aliases for my retropi kodi

alias mandb_fix="rm -rf /var/cache/man/hr/index.db"

install_retropie () {
  inst neovim tmux silversearcher-ag

  sudo mkdir -p /media/nas/video
}


dirfont="/usr/share/consolefonts/"

font_set_exact_terminus () {
  sudo setfont $dirfont"Lat15-TerminusBold"$1"x"$2".psf.gz"
}

alias font_show="ls $dirfont | grep Lat15-TerminusBold"
font_set_20x10 () { font_set_exact_terminus 20 10 ; }
font_set_32x16 () { font_set_exact_terminus 32 16 ; }
alias font_set_big="font_set_32x16"

alias vircfont="sudo vim /etc/default/console-setup"

alias vircon_startup="sudo vim /etc/rc.local"

dirrpy="/home/pi/RetroPie/roms/ports/_py/"
cdpy () {
	cd $dirrpy
}

vipy () {
	cdrpy
	vim -O kivent_demo.py
}

lang_en="en_US.UTF-8"
export LANGUAGE=$lang_en
export LANG=$lang_en
# export LC_ALL="en_US"

alias ll="ls -l"

dircontrols="/opt/retropie/configs/all/retroarch/autoconfig/"
alias retro_cdcontrols="cd $dircontrols"
alias retro_controls_show="ls $dircontrols"
alias retro_controls_test_js0="jstest /dev/input/js0"
alias retro_controls_test_js1="jstest /dev/input/js1"

dirconf="/opt/retropie/configs/"
alias retro_config_all="vim $dirconf/all/retroarch.cfg"

alias nas_mount="sudo /sbin/mount.nfs 192.168.0.118:/volume1/video /media/nas/video/"
alias nas_ssh="sudo ssh gr4viton@192.168.0.118"
alias nas_ssh_shutdown="sudo ssh -t gr4viton@192.168.0.118 sudo shutdown -P now \"Goodbye cruel world! Turned of via ssh from rpi\""
alias killnas="nas_ssh_shutdown"

killme ()      {
	sudo shutdown -P now "So long, Suckeeeeers!"
}
suicide () {
    killnas
    killme
}

on_startup () {
  touch /home/pi/i_ran
}


virc_qjoypad_startup="vim ~/.config/qjoypad.desktop"

inst_despotify () {
    # from http://despotify.sourceforge.net/
    # dependencies
    #aptitude install libssl-dev zlib1g-dev libvorbis-dev libtool
    #aptitude install libpulse-dev # For pulseaudio backend
    #aptitude install libgstreamer-plugins-base0.10-0 libgstreamer0.10-dev # For GStreamer backend
    #aptitude install libao-dev # For libao backend

    # mobidy
    # from  https://www.inpimation.com/installing-mopidy-raspberry-pi-2/

    wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -

    sudo wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list

    sudo apt-get update
    sudo apt-get install mopidy
    sudo apt-get install mopidy-spotify


}

config_locale () {
	echo "/etc/locale.gen"
	sudo locale-gen en_US.UTF-8 UTF-8
	export LANGUAGE="en_US.UTF-8"
	export LC_ALL="en_US.UTF-8"
	sudo update-locale en_US.UTF-8 UTF-8
	locale
}
