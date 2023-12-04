from datetime import date, timedelta, datetime
import time

def logging(status, message):
    print(('{0} - {1}:{2}').format(datetime.now(),status, message))

def get_response(status,message):
    response = {
        "status":"",
        "message":""
    }
    response['status'] = status
    response['message'] = message
    return response