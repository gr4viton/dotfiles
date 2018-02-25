
echo "### Going to install neovim from source and python bindings"

udo apt-get -y install git
sudo apt-get -y install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

sudo apt-get install python-neovim
sudo apt-get install python3-neovim
