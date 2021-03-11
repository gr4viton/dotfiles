# output = system.exec_command("date")

from datetime import datetime
from attr import attrib, attrs

@attrs
class Iso8601(object):
    _date = "%Y-%m-%d"
    _time = "%H:%M:%S"
    date = attrib(init=False)
    time = attrib(init=False)
    datetime = attrib(init=False)
    datetimezone = attrib(init=False)
    
    def __attrs_post_init__(self):
        self.date = self._date
        self.time = self._time 
        self.datetime = f"{self.date}T{self.time}"
        self.datetime = f"{self.datetime}Z"

iso8601 = Iso8601()


def to_iso_date_str(date, iso):
    return datetime.strftime(date, iso)

now = datetime.utcnow()
txt = to_iso_date_str(now, iso8601.date)
keyboard.send_keys(txt)

