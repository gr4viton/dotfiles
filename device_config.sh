# device configs
# ip, usernames etc

device_omatic () {
    # creates aliases and variables for a device
    #
    # $1 = abbreviation used for the device aliases
    # $2 = device username
    # $3 = device ip
    # $4 = ssh_params
    # $5 = sshfs_params
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
    shift
    shift
    shift

    export con_ip_${name}="$ip"
    export con_user_${name}="$user"

    local userip="${user}@{$ip}"
    export con_userip_${name}="$userip"

    # ssh connection
    # ssh_params="-p 8022"
    which > /dev/null 2>&1 ssh_${name} || alias ssh_${name}="ssh \"$userip\" \"$@\""

    # mosh ssh connection
    # which > /dev/null 2>&1 mosh_${name} || alias ssh_${name}="ssh \"$userip\" $ssh_params"

    #export dir${name}="$folder"
    #export d${name}="$folder"
    ##
    #which > /dev/null 2>&1 cd${name} || alias cd${name}="cd \"$folder\""
    #which > /dev/null 2>&1 ls${name} || alias lll${name}o="lla \"$folder\""
}


# retrokodi - rpi with retropie and kodi
device_omatic "retrokodi" "pi" "192.168.0.150"

# ros = rpi with ROS
device_omatic "ros" "pi" "192.168.0.190"

# nas - synology DS218
device_omatic "nas" "gr4viton" "192.168.0.118"

# dell54 - dell l5401
device_omatic "dell54" "dd" "192.168.0.199"

# smartphones
  # p 8022 default termux ssh port
  # https://wiki.termux.com/wiki/Remote_Access

## s8 = android samsung s8
device_omatic "s8" "u0_a304" "192.168.0.120" "-p 8022"
