
wifi_device='wlp2s0'

alias wifi_get='ifconfig'
alias wifi_iw_connect_dhclient="sudo dhclient $wifi_device"
alias wifi_iw_selected_device="echo $wifi_device; echo 'set other wifi_device env var'"

wifi_connect_iwconfig () {
    echo "wifi_connect wifi_name password"

    sudo iwconfig $wifi_device essid $1 key $2

    wifi_connect_dhclient
}

wifi_devices () {
    nmcli d wifi
}
wifi_devices_all () {
    nmcli d
}
wifi_list () {
    nmcli d wifi list
}

wifi_tunr_on () {
    nmcli r wifi on
}
wifi_tunr_off () {
    nmcli r wifi off
}

wifi_connect () {
    # https://docs.ubuntu.com/core/en/stacks/network/network-manager/docs/configure-wifi-connections
    # hidden:
    # nmcli c add type wifi con-name <name> ifname wlan0 ssid <ssid>
    # nmcli c modify <name> wifi-sec.key-mgmt wpa-psk wifi-sec.psk <password>
    # normal:
    # nmcli d wifi connect my_wifi password <password>
    wifi_name="${1:?wifi name}"
    password="${2:?wifi password}"
    wifi_device="${3:-}"
    wifi_device_option=""

    if [[ ! -z "$wifi_device" ]]; then
        wifi_device_option="ifname $wifi_device"
    fi
    nmcli d wifi connect $wifi_name password $password $wifi_device_option
}

wifi_connect_via_dongle () {
    wifi_name="${1:?wifi name}"
    password="${2:?wifi password}"
    wifi_device="wlx74da387faa12"
    wifi_connect $wifi_name $password $wifi_device
}

esp_wifi_connect () {
    pwd=$1
    wifi_name="esp8"
    wifi_connect_via_dongle $wifi_name $pwd
}



