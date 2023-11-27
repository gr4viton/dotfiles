alias load_usb_to_uart_cp210x_modules='sudo modprobe usbserial # load this kernel module; sudo modprobe cp210x # load this kernel module'


alias audio_restart='pulseaudio -k && sudo alsa force-reload'
alias audio_restore_better='alsactl restore'

# Post-install
# These commands should be run after the first boot.

alias power_tlp_start='sudo tlp start'
alias powertop_default='sudo powertop --auto-tune'

# Switch from one graphic card to the other
# Intel:
alias graphics_intel='sudo prime-select intel'
# Nvidia:
alias graphics_nvidia='sudo prime-select nvidia'


alias bluetooth_restart="sudo /etc/init.d/bluetooth restart"

unity () {
    /usr/bin/unity3d -force-glcore -noUpm
}


dd_flash () {
    file="2020-08-20-raspios-buster-armhf.img"
    device="/dev/sdX"
    file=$1
    device=$2
    echo "flashing file $file to $device"
    sudo dd bs=4M if="$file" of="$device" status=progress conv=fsync
}

# keyboard

keyboard_setup () {

    # make short-pressed Ctrl behave like Escape:
    # only start once
    xcape_is_running=$(pgrep xcape)
    if [[ -z $xcape_is_running ]]; then
        # so slow
        if [[ $(apt_installed xcape) ]]; then
            xcape -e 'Control_L=Escape'
        fi
    fi
    # make CapsLock behave like Ctrl:
    setxkbmap -option ctrl:nocaps
}


plasma_start () {
    kstart5 plasmashell
}
plasma_stop () {
    kquitapp5 plasmashell
}
plasma_restart () {
    kquitapp5 plasmashell && kstart5 plasmashell
}


# switch es-2024 zyxel
# https://unix.stackexchange.com/a/65362
zyxel_es2024_connect () {
    echo "sudo apt install -y screen lrzsz"
    echo "# for the tty setup"
    echo "sudo stty -F /dev/ttyUSB0 -a"
    echo "power cycle restart"
    echo "press any key"
    echo "> atlc"
    echo "control-A :"
    echo "exec !! sx binary.bin"
    echo "> atgo"
    # screen /dev/ttyUSB0 9600
    screen /dev/ttyUSB0 9600,-parenb,-parodd,-cmspar,cs8,-hupcl,-cstopb
}

zyxel_tty_info () {
    sudo stty -F /dev/ttyUSB0 -a
}

# zyxel_text () {

# }
