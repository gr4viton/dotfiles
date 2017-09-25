#!/bin/sh
# instal multitude of apps

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
