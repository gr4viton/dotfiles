#!/bin/bash
# __monitor__


# monitor brightness __monitor __display

set_second_monitor_to_first_monitor_brightness () {
    #  DOES NOT WORK - reads only 0.50 brightness all the time - Kubuntu KDE
    #  only for 2023-06-04 station at home
    # https://askubuntu.com/a/1150409
    # OR:  sudo pip3 install screen-brightness-control
    # xrandr -q | grep " connected"
    # xrandr --output VGA1 --brightness 0.63
    #
    MON="eDP-1" # laptop inner

    LaptopBrightness=$( xrandr --verbose --current | grep ^"$MON" -A5 | tail -n1 )
    LaptopBrightness="${LaptopBrightness##* }"  # Get brightness level with decimal place
    echo "$LaptopBrightness"

    xrandr --output "DP-3" --brightness $LaptopBrightness
    # at home DP3 connected
}

monitors_all_brightness_set () {
    monitors_list_connected | while read line ; do xrandr --output $line --brightness "$1"; done
}

monitors_all_dim () {
    monitors_all_brightness_set 0.4
}
monitors_all_bright () {
    monitors_all_brightness_set 1.0
}

monitors_list_connected () {
    xrandr --verbose --current | grep " connected" | awk '{print $1;}'
}

