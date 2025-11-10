# __local__ __main__
# to add to dd/dotfiles

# single bashrc to be sourced from any device

# will have conditions for detecting the device
# then sources only needed stuff accordingly

HOME_DD='/home/dd'

DIR_DD="$HOME_DD/dd/"

dd_bashrc="$DIR_DD/dotfiles/bashrc.sh"
if [ -f $dd_bashrc ]; then
    . $dd_bashrc
fi

# poetry
export PATH="/home/dd/.local/bin:$PATH"

# lenovo thinkpad x1 - disable touchscreen by defaul
# I was getting random clicks
# think_touchscreen_disable
