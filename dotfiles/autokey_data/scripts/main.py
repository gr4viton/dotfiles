import time

def send_xdotool_key(system, key):
    """Key eg XF86AudioNext"""

    #import time
    time.sleep(.5)
    # .2 needed on mint cinnamon

    system.exec_command(f"xdotool key {key}", getOutput=False)
    # works but needs delay 0.5

def send_audio_key(system, cmd):
    """Pass Next for XF86AudioNext."""
    send_xdotool_key(system, f"XF86Audio{cmd}")
    
def send_xf86_key(system, cmd):
    """Pass AudioNext for XF86AudioNext."""
    send_xdotool_key(system, f"XF86{cmd}")

"""
# options
system.exec_command("xdotool key XF86AudioRaiseVolume", getOutput=False)
keyboard.send_keys("<code172>")  # sends an `XF86AudioPlay` key press.
system.exec_command("xdotool key 172", getOutput=False)
system.exec_command("xdotool key XF86AudioNext")
system.exec_command("pactl -- set-sink-volume 0 -5%", getOutput=False)  # nope
"""

def convert_percent_to_cli_arg(percent):
    sign = "-" if percent < 0 else "+"
    return f"{abs(percent)}%{sign}"

def amixer_mic_volume(system, value, device="Dmic0"):
    """Set microphon capture volume via amixer.
    
    https://askubuntu.com/a/27032
    """
    value = convert_percent_to_cli_arg(value)
    cmd = f"amixer -c 0 set {device} {value}"
    system.exec_command(cmd, getOutput=False)


def amixer_mic_mute_toggle(system, device="Dmic0"):
    """Toggle microphone volume muting via amixer.
    
    Not tested (amixer command works, just this method was not called..)
    https://askubuntu.com/a/27032
    """

    cmd = f"amixer -c 0 set {device} toggle"
    system.exec_command(cmd, getOutput=False)


def amixer_volume(system, value, device="Master"):
    """Set volume via amixer.

    https://unix.stackexchange.com/questions/342554/how-to-enable-my-keyboards-volume-keys-in-xfce/342555
    https://unix.stackexchange.com/a/354144
    """
    value = convert_percent_to_cli_arg(value)
    cmd = f"amixer -D pulse set {device} {value}"
    system.exec_command(cmd, getOutput=False)



def amixer_volume_mute_toggle(system, device="Master"):
    """Toggle volume muting via amixer.

    https://unix.stackexchange.com/questions/342554/how-to-enable-my-keyboards-volume-keys-in-xfce/342555
    https://unix.stackexchange.com/a/354144
    """
    cmd = f"amixer -D pulse set {device} toggle"
    system.exec_command(cmd, getOutput=False)
    
    
def brightnessctl_set(system, device, value):
    """Eg intel_backlight, -20."""
    value = convert_percent_to_cli_arg(value)
    cmd = f"brightnessctl -d \"{device}\" s {value}"
    system.exec_command(cmd, getOutput=False)
    
    
def xrandr_bright_all_set(system, value):
    """Set value of brightness for all connected monitors. 
    
    Value 0.0 - 1.0.
    """
    cmd = "xrandr --verbose --current | grep \" connected\" | awk '{print $1;}' | while read line ; do xrandr --output $line --brightness " + str(value) + "; done"
    system.exec_command(cmd, getOutput=False)