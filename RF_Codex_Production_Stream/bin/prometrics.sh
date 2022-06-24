#!/bin/bash
REPORT=/RF_Codex/RF_Codex_Production_Stream/ResultFile/Result
FILE=$REPORT/output.xml
DATE=$(date +"%F-%H-%M-%S")
# Validate & push the metrics
if [ -f $FILE ]; then
    echo "File $FILE exists."
    #cp -r /ngt-codex-qa/ngt-codex-qa/reports/html-report/*  /root/ngt-codex-qa/HttpShared/
    #cp -r /ngt-codex-qa/ngt-codex-qa/reports/html-report /root/ngt-codex-qa/HttpShared/$METRIC_COMPL/html-report.$DATE.$METRIC_COMPL
    #cp -r /ngt-codex-qa/ngt-codex-qa/reports/html-report/* /root/ngt-codex-qa/HttpShared/$JOB_NAME/html-report.latest
    # Extract a nice json from last report
    #jq -r '.projectName as $project |.environment as $env | .specResults[] |"ngt_codex_qa {env=\"\($env)\", spec=\"\(.specHeading|gsub("\"";"\\\""))\", result=\"\(.executionStatus)\"} \(.executionTime)"' | \
    #jq -r '.projectName as $project |.environment as $env | .specResults[] |.specHeading as $spec| .scenarios[] |.scenarioHeading as $scen|.items[]| select(.itemType=="step") |.stepText as $step|"ngt_codex_qa_'$METRIC_COMPL'{env=\"\($env)\", project=\"\($project|gsub("\"";"\\\""))\", operation=\"du\", spec=\"\($spec|gsub("\"";"\\\""))\", scenario=\"\($scen|gsub("\"";"\\\""))\", step=\"\($step|gsub("\"";"\\\""))\", result=\"\(.result.status)\"}  \(.result.executionTime)"' | \   
    #ALL THE STEPS
    ##{ cat $REPORT/result.json | \
    #jq -r '.projectName as $project |.environment as $env | .specResults[] |.specHeading as $spec | .executionStatus as $spec_result | .scenarios[] |.scenarioHeading as $scen | .executionStatus as $scenario_result | .items[],.teardowns[],.contexts[]| select(.itemType=="step") |.stepText as $step|"ngt_codex_qa_'$METRIC_COMPL'{env=\"\($env)\", project=\"\($project|gsub("\"";"\\\""))\", operation=\"du\", type=\"step\", spec=\"\($spec|gsub("\"";"\\\""))\", scenario=\"\($scen|gsub("\"";"\\\""))\", step=\"\($step|gsub("\"";"\\\""))\", result=\"\(.result.status)\", spec_result=\"\($spec_result)\", scenario_result=\"\($scenario_result)\" }  \(.result.executionTime)"' ; \
    #ALL THE CONCEPTS STEPS
    #cat $REPORT/result.json | \
    #jq -r '.projectName as $project |.environment as $env | .specResults[] |.specHeading as $spec | .executionStatus as $spec_result | .scenarios[] |.scenarioHeading as $scen | .executionStatus as $scenario_result |  .items[],.teardowns[],.contexts[]| select(.itemType=="concept") | .conceptStep |.stepText as $step|"ngt_codex_qa_'$METRIC_COMPL'{env=\"\($env)\", project=\"\($project|gsub("\"";"\\\""))\", operation=\"du\",type=\"concept_step\" , spec=\"\($spec|gsub("\"";"\\\""))\", scenario=\"\($scen|gsub("\"";"\\\""))\", step=\"\($step|gsub("\"";"\\\""))\", result=\"\(.result.status)\", spec_result=\"\($spec_result)\", scenario_result=\"\($scenario_result)\" }  \(.result.executionTime)"' ; } | \
    # Send to the metric server
    #curl --data-binary "@/tmp/report.out" -k https://172.20.243.241:9091/metrics/job/robot_qa_$JOB_NAME
    python /robot/bin/codexrun.py
    
    curl --insecure -v --data-binary "@/robot/bin/output.csv" $PUSH_GATE/metrics/job/robot_$JOB_NAME
    
    #name=`uname -n`
    #timestamp=`date +%s`
    #result=`jq -r '.executionStatus' $REPORT/result.json`
    #echo "prometrics_exec_$METRIC_COMPL{name=\"$name\",env=\"$ENV\", result=\"$result\"} $timestamp" | curl --insecure --data-binary @- $PUSH_GATE/metrics/job/ngt_prometrics_$JOB_NAME
    
    # usermod -u 101 /root/ngt-codex-qa/HttpShared/
    cd /root/ngt-codex-qa/HttpShared/ & chown 101:101 -R * 

else
   echo "File $FILE does not exist."
fi