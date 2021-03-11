# they are mad
from time import sleep

value = 200  # mm

keyboard.send_keys("<alt>+p")
sleep(0.02)
keyboard.send_keys("<alt>+b")  # modify background
sleep(0.2)
keyboard.send_keys("<alt>+c")  # continue
sleep(0.25)
keyboard.send_keys("<alt>+c")  # continue
sleep(0.25)
keyboard.send_keys("<right>")  # cursor to the end of the X-position text box  
keyboard.send_keys("-" + str(value))   # add "value" mm to x
keyboard.send_keys("<alt>+f")  # finish