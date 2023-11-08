#from main import send_xf86_key
from main import brightnessctl_set

#send_xf86_key(system, "MonBrightnessDown")

# laptop
brightnessctl_set(system, "intel_backlight", -20)
