# to add to dd/dotfiles

# single bashrc to be sourced from any device

# will have conditions for detecting the device
# then sources only needed stuff accordingly
# - for now - only condition would be not to load bashrc_kiwi when the device is not work laptop

HOME_DD='/home/dd'

DIR_DD="$HOME_DD/dd/"


kw_bashrc="$DIR_DD/dd-kw-dotfiles/bashrc.sh"
if [ -f $kw_bashrc ]; then
    . $kw_bashrc
fi

dd_bashrc="$DIR_DD/dotfiles/bashrc.sh"
if [ -f $dd_bashrc ]; then
    . $dd_bashrc
fi
