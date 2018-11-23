alias load_usb_to_uart_cp210x_modules='sudo modprobe usbserial # load this kernel module; sudo modprobe cp210x # load this kernel module'


alias audio_restart='pulseaudio -k && sudo alsa force-reload'


# Post-install
# These commands should be run after the first boot.

alias power_tlp_start='sudo tlp start'
alias powertop_default='sudo powertop --auto-tune'

# Switch from one graphic card to the other
# Intel:
alias graphics_intel='sudo prime-select intel'
# Nvidia:
alias graphics_nvidia='sudo prime-select nvidia'

