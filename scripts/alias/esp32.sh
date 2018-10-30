
gr4_folderize "esp32" "/srv/dd/esp32"
gr4_folderize "esp32upyl" $diresp32"/upyl"

# alias esp_upyl_front="cdesp32upyl; pipenv run python $diresp32upyl/main.py"
esp_upyl () {
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

esp_erase_flash () {
    if $(ask_yes "Do you really want to erase_flash of [$ESP_DEVICE]?")
    then
        echo "Erasing flash on [$ESP_DEVICE] (run esp_flash to flash it again)"
        countdown_5
        esptool.py --chip esp32 -p $ESP_DEVICE erase_flash
    fi
}

esp_flash () {
    bin_path=$diresp32/esp32_build/esp32-20181010-v1.9.4-631-g338635ccc.bin
    if $(ask_yes "Do you really want to flash [$ESP_DEVICE] with this bin [$bin_path]")
    then
        echo "Re-flash flash on [$ESP_DEVICE] with bin [$bin_path]"
        countdown_5
        esptool.py --chip esp32 -p $ESP_DEVICE write_flash -z 0x1000 $bin_path
    fi
}

alias esp_read_flash_info="esptool.py -p $ESP_DEVICE flash_id"
alias eps_read_mac="esptool.py -p $ESP_DEVICE read_mac"

alias esp_connect="miniterm.py --raw $ESP_DEVICE 115200"

alias esp_ls="ampy -p $ESP_DEVICE ls"

alias esp_cat="ampy -p $ESP_DEVICE get "
alias esp_put_file="ampy -p $ESP_DEVICE put "
