# they are mad
from time import sleep


def move_it(value, direction, waits):
    
    if direction == "left":
        is_x = True
        sign = "+"
    elif direction == "right":
        is_x = True
        sign = "-"
    elif direction == "down":
        is_x = False
        sign = "-"
    elif direction == "up":
        is_x = False
        sign = "+"
        
    str_value = sign + str(value) 
    
    keyboard.send_keys("<alt>+p")
    sleep(waits[0])
    keyboard.send_keys("<alt>+b")  # modify background
    sleep(waits[1])
    keyboard.send_keys("<alt>+c")  # continue
    sleep(waits[2])
    keyboard.send_keys("<alt>+c")  # continue
    sleep(waits[3])
    if is_x:  # x position
        keyboard.send_keys("<right>")  # cursor to the end of the X-position text box  
        keyboard.send_keys(str_value)   # add "value" mm to x
        keyboard.send_keys("<alt>+f")  # finish
    else:  # y position
        keyboard.send_keys("<tab>")  # select Y-position text box
        keyboard.send_keys("<right>")  # cursor to the end of the Y-position text box  
        keyboard.send_keys(str_value)   # add "value" mm to y
        keyboard.send_keys("<alt>+f")  # finish


value = 200  # mm
direction = "down"
waits = [0.02, 0.6, 0.6, 0.6]
move_it(value, direction, waits)