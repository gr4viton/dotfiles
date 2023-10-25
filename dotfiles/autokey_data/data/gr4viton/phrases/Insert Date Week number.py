# output = system.exec_command("date")

from datetime import datetime

now = datetime.utcnow()
txt = datetime.strftime(now, "%W")
txt = str(int(txt) + 1)  # first week = 1 and not 0

keyboard.send_keys(txt)
