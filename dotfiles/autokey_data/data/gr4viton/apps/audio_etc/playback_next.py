#from main import send_audio_key

# playback_next = shift-super-w
# playback_prev = shift-super-q
# playback_stop = shift-super-s
# playback_toggle = shift-super-a
# mic_volume_up = alt-shift-super-e
# mic_volume_down = alt-shift-super-d
# mic_mute = shift-super-x
# volume_down = shift-super-d
# volume_up = shift-super-e
# volume_mute = shift-super-c
# display_brightness_up = super-alt-e
# display_brightness_down = super-alt-d

#import time
#time.sleep(.2)
from main import send_audio_key
send_audio_key(system, "Next")
#from main import send_xdotool_key
#send_xdotool_key(system, "XF86AudioNext")

#system.exec_command("xdotool key XF86AudioNext", getOutput=False)
