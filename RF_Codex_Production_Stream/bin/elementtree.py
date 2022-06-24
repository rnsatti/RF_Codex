import os, csv
from datetime import datetime
from xml.etree import ElementTree as ET

print("CURRENT WORKING DIR >>>"+os.getcwd())

file_name = 'output.xml'
full_file = os.path.abspath(os.path.join('/RF_Codex/RF_Codex_Production_Stream/ResultFile/Result', file_name))
dom = ET.parse(full_file)


ENV=os.environ.get('ENV')
APP=os.environ.get('APP')
JOB_NAME=os.environ.get('JOB_NAME')

print(JOB_NAME)
print(ENV)
print(APP)


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
            L.append('{}{}{},{},{},{},{},{},{}{}{}'.format(robotdefaultcontent,openbrace,env,tc_tag,scena,step,result,specresult,scenarioresult,closebrace,valuemilliseconds))
        writer.writerow(['\n'.join(L)])
       