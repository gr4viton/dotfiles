
echo "### Going to install neovim from source and python bindings"

udo apt-get -y install git
sudo apt-get -y install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

sudo apt-get install python-neovim
sudo apt-get install python3-neovim


# for the plugins to work

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install --user neovim

# install plugins
#nvim
#:PlugInstall
#:UpdateRemotePlugins
#:q!


# set locale
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure locales
