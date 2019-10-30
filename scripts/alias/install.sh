#!/bin/sh
# instal multitude of apps

loadit_script "alias/install/screensaver.sh"

inst_kivy_apk () {

    inst python-pip python3-pip build-essential git python python3 python-dev python3-dev libsdl2-dev  libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev libportmidi-dev libswscale-dev libavformat-dev libavcodec-dev zlib1g-dev ffmpeg gstreamer-1.0
}

inst_kivy_whole () {
    echo "from https://github.com/eabps/Kivy-Environment"
	inst_kivy_apk

    sudo pip install pipenv
    pipenv --three
    pipenv install Cython==0.25
    pipenv install kivy
}

install_popcorn() {
echo "creating directories"
mkdir /srv/centroid/
mkdir /srv/centroid/popcorn
cd /srv/centroid/popcorn

echo "Download popcorntime"
wget https://get.popcorntime.sh/build/Popcorn-Time-0.3.10-Linux-64.tar.xz
mkdir bin
echo "unzip"
tar -xf Popcorn-Time-*.tar.xz -C bin
cd bin
echo "install"
sudo ./install

}

installit() {
case $1 in
        "popcorn")
            install_popcorn
            ;;
esac
}

install_it () {
    echo "> apt installing $@"
    sudo apt install $@
}
alias inst='install_it'

inst_npm () {
    sudo npm i $@ -g
}
instsnap () {
    echo "> snap installing $@"
    sudo snap install $@
}


inst_add_repo () {
  # args are apt repo names without "ppa:" prefix
  # runs apt-get update if any new ppa added
  some_added=0
  echo ">>> Adding multiple ppa"
  for i in "$@"; do
    grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
      echo "> Adding ppa:$i"
      sudo add-apt-repository -y ppa:$i
      some_added=1
    else
      echo "> ppa:$i already exists"
    fi
  done
  if [[ "$some_added" = "1" ]]; then
      sudo apt-get update
  fi
}


setup_gnome () {
    echo ">>> setup gnome"
    echo "> show calendar weekdays"
    gsettings set org.gnome.desktop.calendar show-weekdate true
inst gnome-tweak-tool
}

backup_all_root () {
echo $(cat << EOF
/etc/hosts
/etc/default/grub
/etc/fstab
/etc/crypttab

EOF
)
}

# install ALLLAALALALALALALLAL
install_all () {

    echo "install ansible"
    inst ansible

    progs=$(cat << EOF
insomnia pycharm
EOF
)
echo ">>> DEV"
inst neovim tmux htop chromium-browser
inst xclip  # for system buffer tmux copy
inst git make
inst exuberant-ctags  # vim ctags


echo $(cat << EOF
>>> docker-ce

comuninty edition - you want that
install docker from deb https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/"
download containerd.io, docker-ce-cli, docker-ce

# if you want to store containers elswhere you can create symlink
# so i have /srv/docker as a storage now
$ sudo ln -s /srv/docker/ /var/lib/docker

$ inst /srv/_all/DATA/deb/docker/*
or this
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
# after install you need to add your user to docker user group
$ sudo usermod -aG docker your-user

to remove
$ sudo apt-get purge docker-ce
$ sudo rm -rf /var/lib/docker
EOF
)

echo $(cat << EOF
>>> install docker-compose

info =
https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04

EOF
)

sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

inst tldr

inst autokey-gtk

echo ">>> compiz"
inst compiz compiz-plugins compiz-plugins-default compizconfig-settings-manager

echo $(cat << EOF
on init ubuntu 18.04
* install nvidia drivers, reboot, install compiz, reboot, install unity, reboot, install cairo-dock, reboot : works, can log into the cairo-dock (gnome) desktop environment"
echo "https://askubuntu.com/questions/1065866/ubuntu-18-04-compiz-cairo-dock-hard-to-install-harder-to-keep-in-working-or"
echo "installing the video driver, compiz, ubuntu-unity-desktop (and selecting lightdm as your window manager!)"
reboot

install cairo-dock

use ccsm (compiz config settings manager) to enable the 'enhanced zoom desktop' and the 'opacity, brightness and saturation' plugins, setting the settings for 'enhanced desktop zoom' with special note to that plugin's 'focus tracking' tab page, where it's best to uncheck the top option ('enable focus tracking')

run cairo-dock as an app, because if you'd boot into the cairo-dock option at the ubuntu login screen (click on the ubuntu logo of the login input window in lightdm, which should be the default startup login window now), and change the ccsm settings for cairo-dock then, that entire desktop environment crashes to the ubuntu login screen and refuses to start up again, the moment you turn off 'focus tracking' in ccsm (with the 2 mentioned ccsm plugins enabled). solution : just don't change the ubuntu login screen's ubuntu-icon menu-option at all. you'll be booting into unity lightdm and running cairo-dock as an app. you can turn on autohide at least for the default ubuntu taskbar if you like, which gives you that windows-key start-menu along with cairo-dock.
EOF
)

inst silversearcher-ag

inst rxvt-unicode
echo "In your home there must be .Xresources or .Xdefaults for settings"
ls ~ | grep .Xresources
ls ~ | grep .Xdefaults

# inst $progs
# sudo ansible-playbook ~/gr4log/scripts/playbook.yml

inst steam

pips=$(cat << EOF
attrs pipenv
EOF
)



# inst snapd
# sudo snap install slack --classic
echo "install slack from https://slack.com/downloads/linux"

echo "VPN kiwi"
echo $(cat << EOF
from confluence comment from baptiste.darthenay@kiwi.com here:
https://confluence.kiwi.com/display/ICT/VPN+Setup+how-to?utm_source=grossmann+VPN&utm_campaign=ae6369c106-EMAIL_CAMPAIGN_2018_09_24_07_21_COPY_02&utm_medium=email&utm_term=0_4321084e62-ae6369c106-66087249

EOF
)


sudo apt-get install openfortivpn network-manager-fortisslvpn-gnome

# sudo tail -f /var/log/syslog
# vpn-connection[...kiwi_vpn",0]: Started the VPN service, PID 16151
# vpn-connection[...kiwi_vpn",0]: Saw the service appear; activating connection
# vpn-connection[...kiwi_vpn",0]: VPN connection: (ConnectInteractive) reply received
# vpn-connection[...kiwi_vpn",0]: VPN connection: failed to connect: 'Failed to create file “/var/lib/NetworkManager-fortisslvpn/....config.RHNEUZ”: No such
# vpn-connection[...kiwi_vpn",0]: VPN plugin: state changed: stopped (6)
# vpn-connection[...kiwi_vpn",0]: VPN service disappeared

sudo mkdir /var/lib/NetworkManager-fortisslvpn/
sudo chown dd:dd /var/lib/NetworkManager-fortisslvpn/

echo ">>> dev"

echo "> pip tools"
sudo pip install pip-tools

echo ">>> office"
inst mc

inst curlftpfs  # ftp filesystem
inst_screensaver

echo ">>> syntax checkers"  # not coala - coala is docker
inst flake8
inst libxml2-utils  # xmllint

echo ">>> nvidia drivers"
# sudo add-apt-repository ppa:graphics-drivers/ppa
# sudo apt-get update
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

echo ">>> sound"
sudo apt-add-repository ppa:yktooo/ppa

sudo apt update && inst indicator-sound-switcher


echo ">>> insomnia"

echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list

# Add public key used to verify code signature
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

# Refresh repository sources and install Insomnia
sudo apt-get update
inst insomnia


inst gimp
inst xchat

echo ">>> keybase"
curl -O https://prerelease.keybase.io/keybase_amd64.deb
# if you see an error about missing `libappindicator1`
# from the next command, you can ignore it, as the
# subsequent command corrects it
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
run_keybase

inst kazam

# desktop manager installer
inst taskel

## snaps
echo "# SNAPS"
echo ">>> spotify"
sudo snap install spotify


setup_gnome
setup_ssh

}

inst_npm_packages () {
    echo "# npm pcakages"
    inst_npm swagger-cli  # swag_validate

    inst npm
    echo ">>> documentation"
    inst_npm docsify-cli
    # npm i docsify-cli -g
}

install_arx_liberatis () {
    echo ">>> arx liberatis"
    # from http://wiki.arx-libertatis.org/Linux_packages#Debian
    cd /tmp
    wget http://launchpadlibrarian.net/161405671/libglew1.10_1.10.0-3_amd64.deb
    sudo dpkg -i libglew1.10_1.10.0-3_amd64.deb

    wget https://download.opensuse.org/repositories/home:/dscharrer/Debian_8.0/amd64/arx-libertatis_1.1.2-0.1_amd64.deb -O arx_fatalis.deb
    sudo apt install ./arx_fatalis.deb
}

setup_ssh () {
    echo ">>> add ServerAliveInterval 10 into /etc/ssh/ssh_config"
    echo '    ServerAliveInterval 10' >> /etc/ssh/ssh_config
    # keeps the connection open on unstable hosts (devserver and ams)
}


gr4_copy_configs () {
    source $dirgr4log/dotfiles/config_update.sh
    copy_configs
}

inst_py_dependencies () {
    echo ">>> pycurl dependencies"
    inst libcurl4-openssl-dev libssl-dev
    echo ">>> psycopg2 dependencies"
    inst postgresql libpq-dev postgresql-client postgresql-client-common
}


inst_cron_vim () {

    echo "Plz add the following lines to crontab -e"
    echo "10 * * * * ctags -R -o /srv/da/tags/tags /srv/da/ --options=/home/dd/.ctags"
}
inst_dev () {
    inst_dev_tools_bash
    instsnap pycharm-professional --classic
}

inst_dev_tools_bash () {
    inst_jqyq
}

inst_jqyq () {
    echo ">>> installing json and yaml parsing scripts usable from bash (jq, yq)"
    inst jq
    sudo pip install yq
}

inst_fuck () {
    sudo pip3 install thefuck
}

inst_blender () {
    echo "Used info from: https://vitux.com/how-to-install-blender-3d-on-ubuntu/"
    echo installing from Thomas Schiex PPA repository
	inst_add_repo thomas-schiex/blender
	inst blender
}

inst_ydiff () {
    # usage `diff -u a b | ydiff -`
    python3 -m pip install --user ydiff
}


inst_qutebrowser () {
    inst qutebrowser
}

