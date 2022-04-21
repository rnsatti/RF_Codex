from cgi import test
from subprocess import call
from unittest import suite
import pandas as pd
import requests
import json
import csv
import io
import os
import json
from jsonpath_ng.ext import parse

testexeckey = 'QAD-50030'

execution_url = "http://172.24.245.181:8282/rest/api/2/issue/%s"%(testexeckey)
header = {
    "content-type":"application/json"

}
response=requests.get(execution_url,headers=header,auth=("shambu","Cogni@28"))
response_data = response.json()
#print(response_data)
Environment = response_data['fields']['customfield_10503']['value']
print(Environment)
Application = response_data['fields']['customfield_10504']['value']
print(Application)

execution_url1 = "http://172.24.245.181:8282/rest/raven/1.0/api/testexec/%s/test"%(testexeckey)
header = {
    "content-type":"application/json"

}
response1=requests.get(execution_url1,headers=header,auth=("shambu","Cogni@28"))
response_data1 = response1.json()
print(response_data1)

json_data = response_data1

jsonpath_expression = parse("$..key")

listvalue = [match.value for  match in jsonpath_expression.find(json_data)]
robotinclude = " -i"
listvalue = ["{}{}".format(i,robotinclude) for i in listvalue]
testcases = str(listvalue)[1:-1]
testcases = testcases.replace("'","")
testcases = testcases.replace(",","")
testcases = testcases[:-2]
print(listvalue)
print(testcases)

list = os.listdir("C:/Application_Suite/Automation_Backup_New_Framework/automation_framework/App/%s/Inputdata"%(Application))
number_files = len(list)
print(number_files)

os.chdir("C:/Application_Suite/Automation_Backup_New_Framework/automation_framework/APP/%s/Suite"%(Application))

robotexecutioncommand = "pabot --testlevelsplit --outputdir C:/Application_Suite/Automation_Backup_New_Framework/automation_framework/ResultFile/Result --variable Testexeckey:"+testexeckey+" -i "+testcases+""+Application+"_Regression_Suite.robot"

#robotexecutioncommand = "robot --outputdir D:/Automation_Backup_New_Framework/automation_framework/ResultFile/Result -v Testexeckey:"+testexeckey+" -i "+testcases+""+Application+"_Regression_Suite.robot"

#print(robotexecutioncommand)

call(robotexecutioncommand)