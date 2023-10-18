# __esp32__

esp_info () {
    echo @@eof
    out=$(cat <<-EOF
ota = over the air
# device
## esp8266
- ota via websocket
## wipy
- ota via telnet
## esp32
- ota??

# program
## webrepl
https://github.com/micropython/webrepl
- old outdated
- uses websocket
- master version micrpython/webrepl
  - has only repl via web http page
  - has webrepl_cli = transfer files cli
### @HermannSW/webrepl
https://github.com/Hermann-SW/webrepl
- fork of webrepl
  - has webrepl_client = repl
  - - telnet using websockets
## rshell
- nice
- connect
  - serial
  - telnet - wipy
  - does not have websockets like webrepl :(
- rsync to sync files
  - OP!!!
## mpfshell
https://github.com/wendlers/mpfshell
- serial
  - esp8266 + wipy
- websocket
  - webrepl = esp8266 only
- telnet
  - wipy only
- file transfer
  - regex
  - full cmd list
  - tab completion
EOF
)

}

gr4_folderize "upy" "/srv/dd/micropython"
gr4_folderize "esp8" "/srv/dd/micropython/esp8266"
gr4_folderize "esp32" "/srv/dd/micropython/esp32"
gr4_folderize "esp32upyl" $diresp32"/upyl"

# alias esp_upyl_front="cdesp32upyl; pipenv run python $diresp32upyl/main.py"
esp_upyl () {
    ## PyQT5 gui for transferring files to and from esp8266
    # https://github.com/BetaRavener/uPyLoader
    #cdesp32upyl
    #pipenv run python main.py
    cdesp32upyl
    pipenv run python main.py
    # venv_path=$(pipenv --venv)
    # cdesp32
    # source "$venv_path/bin/activate" &

    echo "THIS"
    # python $esp32upyl"/main.py"
}

# alias esp_upyl="esp_upyl_front 2>/dev/null &"

export ESP_DEVICE="/dev/ttyUSB0"

alias esp_read_flash_info="esptool.py -p $ESP_DEVICE flash_id"
alias esp_read_mac="esptool.py -p $ESP_DEVICE read_mac"

alias esp_connect_miniterm="miniterm.py --raw $ESP_DEVICE 115200"

# rshell!
alias esp_connect_rshell_usb="rshell --port=$ESP_DEVICE"

esp_connect_rshell_wifi_wipy () {
    echo "you cannot rshell rsync nor connect to esp8266"
    # via telnet - telnet != webrepl ??
    rshell connect telnet 192.168.4.1 --port 8266  --wait 10
}

alias rsh="rshell --port=$ESP_DEVICE"

esp_rsync_src () {
    rsh rsync $diresp8/try_rshell/src/flash/ /flash
}
esp_rsync () {
    board_name="esp8"  # from board.py - name - or "pyboard" or "wipy"
    # viz https://pypi.org/project/rshell/ File System
    rsh rsync $diresp8/try_rshell/src/ /$board_name/
}

dirwebrepl="/srv/dd/micropython/esp8266/webrepl/"
gr4_folderize "webrepl" "$dirwebrepl"

alias webrepl_cli="${dirwebrepl}webrepl_cli.py"
alias webrepl="${dirwebrepl}webrepl_client.py"

ESP_WEBREPL_IP="192.168.4.1"
ESP_WEBREPL_PORT="8266"
ESP_WEBREPL_PWD="ESPESPESP"

esp_connect_webrepl_wifi_install () {
    pip install websocket websocket-client
}

esp_connect_webrepl_wifi () {
    pass=$ESP_WEBREPL_PWD
    ip=$ESP_WEBREPL_IP
    webrepl -p $pass $ip
}

esp_webrepl_cp_to_esp () {
    esp_ip=$ESP_WEBREPL_IP
    esp_pwd=$ESP_WEBREPL_PWD
    local_fname=$1
    local_path="$diresp8/try_rshell/src/flash/$local_fname"
    remote_path="$esp_ip:/flash/$fname"
    set -x
    webrepl_cli $local_path $remote_path -p $esp_pwd
    set +x
}

esp_webrepl_cp_from_esp () {
    esp_ip=$ESP_WEBREPL_IP
    esp_pwd=$ESP_WEBREPL_PWD
    local_fname=$1
    local_path="$diresp8/try_rshell/src/flash/$local_fname"
    remote_path="$esp_ip:/flash/$fname"
    set -x
    webrepl_cli $remote_path $local_path -p $esp_pwd
    set +x
}

esp_mpfsh () {
    pyt="/home/dd/venvs/mpfshell-0NS5kyKG/bin/python3"
    $pyt -m mp.mpfshell $@
}

esp_connect_mpf_wifi () {
    cmd="open ws:$ESP_WEBREPL_IP,$ESP_WEBREPL_PWD"
    esp_mpfsh -c $cmd
}


esp_connect () {

    esp_connect_mpf_wifi
    # esp_connect_rshell_usb
    # esp_connect_webrepl_wifi
    # esp_connect_mpf_wifi
}

rsync_esp () {
    esp_rsync
}

rsh_repl () {
    rsh repl
}



# ampy used for remote filesystem managing on the esp / adafruit boards
export AMPY_DELAY=1  # number of seconds before entering RAW repl
export AMPY_PORT=$ESP_DEVICE

alias esp_ls="ampy -p $ESP_DEVICE ls"
alias esp_lsr="ampy -p $ESP_DEVICE ls -r"

alias esp_cat="ampy -p $ESP_DEVICE get "
alias esp_put_file="ampy -p $ESP_DEVICE put "
alias esp_mkdir="ampy -p $ESP_DEVICE mkdir "
alias esp_rm="ampy -p $ESP_DEVICE rm "
alias esp_rmdir="ampy -p $ESP_DEVICE rmdir "
alias esp_run="ampy -p $ESP_DEVICE run "
alias esp_get="ampy -p $ESP_DEVICE get "

esp_erase_flash () {
    if $(ask_yes "Do you really want to erase_flash of [$ESP_DEVICE]?")
    then
        echo "Erasing flash on [$ESP_DEVICE] (run esp_flash to flash it again)"
        countdown_5
        esptool.py --chip esp32 -p $ESP_DEVICE erase_flash
    fi
}

_esp_flash_esp32 () {
    bin_path=$1
    set -x
    esptool.py --chip esp32 -p $ESP_DEVICE write_flash -z 0x1000 $bin_path
    set +x
}

_esp_flash_esp8266 () {
    bin_path=$1
    node_mcu=$2

    node_mcu_arg=""
    if $node_mcu; then
        node_mcu_arg="-fm dio 0"
    fi
    set -x
    esptool.py --port $ESP_DEVICE --baud 115200 write_flash --flash_size=detect $nod_mcu_arg 0 $bin_path
    set +x
}

esp_flash_specific () {
    esp_board=$1
    bin_path=$2
    if $(ask_yes "Do you really want to flash ($esp_board) connected to [$ESP_DEVICE] with this bin [$bin_path]")
    then
        echo "Re-flash flash on [$ESP_DEVICE] with bin [$bin_path]"
        if [[ "${esp_board}" == "esp32" ]]; then
            _esp_flash_esp32 $bin_path
        elif [[ "${esp_board}" == "esp8266" ]]; then
            _esp_flash_esp8266 $bin_path
        elif [[ "${esp_board}" == "esp8266_node_mcu" ]]; then
            _esp_flash_esp8266 $bin_path "node_mcu"
        else
            echo "$esp_board not known"
        fi
    fi
}

esp_flash_esp32 () {
    bin_path="$dirupy/build/esp32-20181010-v1.9.4-631-g338635ccc.bin"
    esp_flash_specific "esp32" $bin_path
}

esp_flash_esp8266_nodemcu () {
    # i have this one as module with micro usb port
    bin_path="$dirupy/build/esp8266-20191220-v1.12.bin"
    esp_flash_specific "esp8266_node_mcu" $bin_path
}
