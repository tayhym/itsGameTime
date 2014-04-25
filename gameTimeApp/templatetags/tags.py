from django import template
from datetime import datetime, timedelta
import re


register = template.Library()
@register.filter
def time_until_now(value):
	td_pattern = r"(\d+\sdays?,\s)?(\d+):(\d+):(\d+\.\d+)"
	now = datetime.utcnow()
	delta = now - value.replace(tzinfo=None)
	td_matches = re.match(td_pattern, str(delta))
	if td_matches.group(1):
		(day, hours, minutes) = (int(td_matches.group(1).split(' ')[0]), int(td_matches.group(2)), int(td_matches.group(3)))
	else:
		(day, hours, minutes) = (None, int(td_matches.group(2)), int(td_matches.group(3)))
	if day:
		if day > 1:
			return '%d days ago' % day
		if day == 1:
			return '1 day, %d hours ago' % (hours)
	else:
		if hours >= 1:
			return '%s hours ago' % hours
		else:
			if minutes < 5:
				return 'new'
			else:
				return '%s minutes ago' % (minutes) 


