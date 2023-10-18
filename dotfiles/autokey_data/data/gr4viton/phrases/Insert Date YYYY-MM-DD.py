# output = system.exec_command("date")

from datetime import datetime


def to_iso_date_str(date, iso):
    return datetime.strftime(date, iso)

now = datetime.utcnow()
iso = "%Y-%m-%d"
txt = to_iso_date_str(now, iso)
keyboard.send_keys(txt)