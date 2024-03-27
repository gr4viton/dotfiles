# device configs
## __ssh__
## __device__
# ip, usernames etc

device_omatic () {
    # creates aliases and variables for a device
    #
    # $1 = abbreviation used for the device aliases
    # $2 = device username
    # $3 = device ip
    # $4 = ssh_port
    #
    # con_ip_{name}
    # con_user_{name}
    # con_userip_{name}
    # ssh_{name}
    # sshfs_{name}
    #
    #
    # devicomatic "s8" "/srv/dd/esp32"
    # creates:
    # - aliases: `cdesp32`, `lsesp32`
    # - envars: `diresp32`, `desp32`

    # ${param:?word} writes word to stdout when param is unset or null
    local name="${1:?Device name abbreviation}"
    local user="${2:?Device username}"
    local ip="${3:?Device ip address}"
    local port="${4:-}"
    shift
    shift
    shift

    export con_ip_${name}="$ip"
    export con_user_${name}="$user"

    local userip="${user}@${ip}"
    export con_userip_${name}="$userip"
    export con_sshport_${name}="$port"

    port_cmd="-p $port"
    [ -z "$port" ] && port_cmd=""

    # ssh connection
    # ssh_params example "-p 8022"
    which > /dev/null 2>&1 ssh_${name} || alias ssh_${name}="ssh \"$userip\" \"$port_cmd\" \"$@\""

    # mosh ssh connection
    # which > /dev/null 2>&1 mosh_${name} || alias ssh_${name}="ssh \"$userip\" $ssh_params"
}


# retrokodi - rpi with retropie and kodi
device_omatic "retrokodi" "pi" "192.168.0.150"

# think - lap
device_omatic "think" "dd" "192.168.0.217"

# ros = rpi with ROS
device_omatic "ros" "pi" "192.168.0.190"

# nas - synology DS218
# device_omatic "nas" "gr4viton" "192.168.0.118"
device_omatic "nas" "gr4viton" "192.168.0.220"

# dell54 - dell l5401
device_omatic "dell54" "dd" "192.168.0.199"

# smartphones
  # p 8022 default termux ssh port
  # https://wiki.termux.com/wiki/Remote_Access

## s8 = android samsung s8
# device_omatic "s8" "u0_a304" "192.168.0.120" "8022"
# in Pv
device_omatic "s8" "u0_a304" "192.168.0.110" "8022"

## s20 = android samsung s20 fe
device_omatic "s20" "u0_a396" "192.168.0.124" "8022"

# device_omatic "hass" "pi" "192.168.0.100" "8123"
device_omatic "hass" "dd" "192.168.0.100" "22"
