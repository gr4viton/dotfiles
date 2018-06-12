alias load_usb_to_uart_cp210x_modules='sudo modprobe usbserial # load this kernel module; sudo modprobe cp210x # load this kernel module'


alias audio_restart='pulseaudio -k && sudo alsa force-reload'
