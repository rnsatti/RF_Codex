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
    
else
   echo "File $FILE does not exist."
fi

#we have to change the working directory