#!/bin/bash
REPORT=/RF_Codex/RF_Codex_Production_Stream/ResultFile/Result
FILE=$REPORT/output.xml
DATE=$(date +"%F-%H-%M-%S")
# Validate & push the metrics
if [ -f $FILE ]; then
    echo "File $FILE exists."

    python --version

    python /robot/bin/elementtree.py

    python /robot/bin/read.py
    
    curl --insecure -v --data-binary "@/robot/RF_Codex/RF_Codex_Production_Stream/APP/ESHOP/Test_Case/output.csv" $PUSH_GATE/metrics/job/robot_$JOB_NAME
    
    
    #Below line of code is for the last execution run
    name=`uname -n`
    timestamp=`date +%s`
    result= true # this is the result of entire suite
    echo "prometrics_exec_$APP{name=\"$name\",env=\"$ENV\", result=\"$result\"} $timestamp" | curl --insecure --data-binary @- $PUSH_GATE/metrics/job/robot_latest_$JOB_NAME

    cp -r /RF_Codex/RF_Codex_Production_Stream/ResultFile/Result/* /root/robot_qa/HttpShared/$APP/$ENV/

else
   echo "File $FILE does not exist."
fi

# Action to be taken A-1: We have to change the working directory