import datetime

def is_weekday():
	week_index = datetime.datetime.today().weekday()
	if week_index < 5:
		return True
	return False

def lambda_handler(event, context):
	allow = False
	error_msg = "You are not allowed to connect on a weekend day."
	if is_weekday():
		allow = True
	return {
		"allow": allow,
		"error-msg-on-failed-posture-compliance": error_msg,
		"posture-compliance-statuses": [],
		"schema-version": "v1"
	}
