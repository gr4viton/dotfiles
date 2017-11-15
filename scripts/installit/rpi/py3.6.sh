#!/bin/bash
# install python 3.6 on rpi 
# https://gist.github.com/dschep/24aa61672a2092246eaca2824400d37f

# latest version string 
# edit yourself - find it here https://www.python.org/downloads/source/
ver="3.6.2"
ver_str="3.6"
python_str="python"$ver_str
py_dir=/srv/python$ver_str

# if installed - exit
command -v $python_str >/dev/null 2>&1 && echo "Already installed";  exit || echo ">>>Installing "$python_str

sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev

mkdir $py_dir
cd $py_dir

wget https://www.python.org/ftp/python/$ver/Python-$ver.tar.xz
tar xf Python-$ver.tar.xz
cd Python-$ver
./configure
make -j 4
sudo make altinstall

# clean
sudo apt-get -y autoremove
