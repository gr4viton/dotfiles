#!/bin/bash
# __office__


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

monitors_brightness_set () {
    xrandr --output "eDP-1" --brightness "$1"
    xrandr --output "DP-3" --brightness "$1"
}

monitors_dim () {
    monitors_brightness_set 0.4
}
monitors_bright () {
    monitors_brightness_set 1.0
}
