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


# setup synclient touchpad
# doc = ftp://www.x.org/pub/X11R7.5/doc/man/man4/synaptics.4.html
if [[ $(apt_installed synclient) ]]; then
synclient "TapButton3"=2
synclient "PalmDetect"=1
synclient "LockedDrags"=1
## circ scrolling

synclient "CircularScrolling"=1
synclient "CircScrollTrigger"=4
fi


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
