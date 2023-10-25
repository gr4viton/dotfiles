# output = system.exec_command("date")

from datetime import datetime


def to_iso_date_str(date, iso):
    return datetime.strftime(date, iso)

now = datetime.now()
iso = "%Y-%m-%d %H:%M"
txt = to_iso_date_str(now, iso)
keyboard.send_keys(txt)
