alias load_usb_to_uart_cp210x_modules='sudo modprobe usbserial # load this kernel module; sudo modprobe cp210x # load this kernel module'



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


plasma_start () {
    kstart5 plasmashell
}
plasma_stop () {
    kquitapp5 plasmashell
}
plasma_restart () {
    kquitapp5 plasmashell && kstart5 plasmashell
}


# __router__
# __switch__
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


# __audio__
audio_restart () {
    pulseaudio --kill && sudo alsa force-reload
    pulseaudio --start
}
audio_restore_alsa () {
    alsactl restore
}

inst_be_bluetooth_speaker () {
  # allow laptop to be paired via bluetooth and serve as an audio drain - bluetooth speaker
  # 2024-01-10
  # https://dev.to/bukanspot/use-my-linux-laptop-as-bluetooth-speaker-4549

sudo apt install pulseaudio-module-bluetooth

bluetooth_lines=$(cat <<-EOF
### Adding bluetooth audio streaming on Linux ###
load-module module-bluetooth-policy
load-module module-bluetooth-discover

EOF
)

# Step 3 – How to configure Linux to send sound through Bluetooth
sudo su -c "mkdir /etc/pulse/system.pa.d/ &
echo -e ${bluetooth_lines} >> /etc/pulse/system.pa.d/be-bluetooth-speaker.pa
"
# Step 4 – Restarting the Bluetooth service on Linux

exit

## Kill a running daemon on Linux ##
pulseaudio --kill
## Start the daemon if it is not running ##
pulseaudio --start

# Step 5 – Pair your Android / iOS mobile phone with your computer
# - now make your laptop bluetooth discoverable, meaning not hidden
# - and search on the phone or on other client, and pair with it


}
