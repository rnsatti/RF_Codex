import requests
from requests.auth import HTTPBasicAuth
import json

url = "http://172.24.245.181:8282/rest/api/2/issue/QAD-50031/attachments"

auth = HTTPBasicAuth("shambu","Cogni@28")

headers = {
    "Accept": "application/json",
    "X-Atlassian-Token": "no-check"
}

response1 = requests.request(
    "POST",
    url,
    headers=headers,
    auth=auth,
    files={
        "file": ("log.html", open("D:/Automation_Backup_New_Framework/automation_framework/ResultFile/Result/log.html", "rb"), "application-type"),
    }
)

response2 = requests.request(
    "POST",
    url,
    headers=headers,
    auth=auth,
    files={
        "file": ("report.html", open("D:/Automation_Backup_New_Framework/automation_framework/ResultFile/Result/report.html", "rb"), "application-type"),
    }
)

#print(response1.text)
#print(response2.text)

print(response1.status_code)
print(response2.status_code)

Status = 200
if (Status == response1.status_code):
    print('Log file updated Successfully')
if (Status == response2.status_code):
    print('Report file updated Successfully')
else:
    print(response1.text)
    print(response2.text)
    print('Results upload failed. Verify the error response value')