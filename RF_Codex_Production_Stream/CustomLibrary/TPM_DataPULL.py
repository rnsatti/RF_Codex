import pandas as pd
import requests
import json
import csv 
import io
import os
import robot
from jsonpath_rw import jsonpath
from jsonpath_rw_ext import parse
import jsonpath_rw_ext as jp

testexeckey = 'QAD-50031'

execution_url = "http://172.24.245.181:8282/rest/api/2/issue/%s"%(testexeckey)
header = {
    "content-type":"application/json"

}
response=requests.get(execution_url,headers=header,auth=("shambu","Cogni@28"))
response_data = response.json()
print(response_data)
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
for testcase in jp.match("$..key", json_data):
    print(" {}".format(testcase))
testcase = testcase

ar = []
for values in range(len(response_data1)):
    keys = response_data1[values]['key']
    ar.append(keys)
    
    cwd = os.getcwd()
    path = cwd.strip('\CustomLibrary')
    Replace_Slash = path.replace('\\','/')
    CSV_path = str(''+Replace_Slash+'/APP/'+Application+'/Inputdata/'+keys+'.csv')
        
#write to .csv
    f = open(CSV_path, "w")
    f.write(response.text)
    f.close()
    
size = len(ar)
print(size)

Add_i = [" -i " + ar for ar in ar]

joined_string = ",".join(Add_i)
print(joined_string)

cwd = os.getcwd()
path = cwd.strip('\CustomLibrary')
Replace_Slash = path.replace('\\','/')
Appsuite_path = str(''+Replace_Slash+'/APP/'+Application+'/Suite')
Inputdata_path = str(''+Replace_Slash+'/APP/'+Application+'/Inputdata')
os.chdir(Appsuite_path)
list = os.listdir(Inputdata_path)

number_files = len(list)
csv_files = number_files - 3    
print(csv_files)

if (csv_files == size):
    print("TPM DataPULL Succesfully completed")
else:
    print("TPM DataPULL failed due to some issue")
