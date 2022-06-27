import os, csv
from datetime import datetime
from xml.etree import ElementTree as ET

print("CURRENT WORKING DIR >>>"+os.getcwd())
ENV=os.environ.get('ENV')
APP=os.environ.get('APP')
JOB_NAME=os.environ.get('JOB_NAME')
FOLDER_PATH= '/RF_Codex/RF_Codex_'+str(ENV)+'_Stream/ResultFile/Result'

print("the path for output file >>"+FOLDER_PATH)
print(JOB_NAME)
print(ENV)
print(APP)


file_name = 'output.xml'
full_file = os.path.abspath(os.path.join(FOLDER_PATH, file_name))
dom = ET.parse(full_file)




with open('verify.csv', 'w', newline='') as f:
    writer = csv.writer(f,delimiter='|',quoting=csv.QUOTE_NONE,quotechar='',escapechar='\\')

    for d in dom.findall(".//test"):
        part = d.attrib['name']
        tag = d.find('tag').text  
        seperator="/"
        tc_tag = "tc_tag=" +'"'+ str(tag) +'"'
        #scena = "scenario=" + str(part)    
        scena = "scenario=" +'"'+ str(part) +'"'               
        robotdefaultcontent="robot_qa"+'_'+str(APP)
        openbrace="{"
        closebrace="}"
        env = "env=" +'"'+ str(ENV) +'"'
        app = "app=" +'"'+ str(APP) +'"'
        search=".//kw[@library='ESHOP_Keyword']"
        L = [] 
        for a in d.findall(str(search)):
            name = a.attrib['name'] 
            step = "step=" +'"'+ str(name) +'"' 
            status = a.find('.//status').attrib['status'] 
            result = "result=" +'"'+ str(status) +'"' 
            specresult="spec_result=" +'"'+ str(status) +'"' 
            scenarioresult="scenario_result=" +'"'+ str(status) +'"'
            date_format_str = '%Y%m%d %H:%M:%S.%f'           
            stime = a.find('.//status').attrib['starttime'] 
            #print(stime)
            start = datetime.strptime(stime, date_format_str)
            #print(start)
            etime = a.find('.//status').attrib['endtime'] 
            #print(etime)  
            end =   datetime.strptime(etime, date_format_str)
            #print(end)
            # Get the interval between two datetimes as timedelta object
            diff = end - start 
            #print(diff)
            spacedelimiter=' '
            # Get the interval in milliseconds
            diff_in_milli_secs = diff.total_seconds() * 1000
            #print(diff_in_milli_secs)
            valuemilliseconds=spacedelimiter+str(diff_in_milli_secs)
            #print(valuemilliseconds)
            L.append('{}{}{},{},{},{},{},{},{},{}{}{}'.format(robotdefaultcontent,openbrace,env,app,tc_tag,scena,step,result,specresult,scenarioresult,closebrace,valuemilliseconds))
        writer.writerow(['\n'.join(L)])
       