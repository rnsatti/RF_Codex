#!/bin/bash
echo $(date)
echo $CASES   #QAD-11111 ESHOP/Test_Case/ESHOP_Production_Suite.robot   : Which suite we have to execute (Regression or sanity) 
echo $ENV     # Production, Preview, Regression
echo $METRIC_COMPL # Application name (ESHOP, Selfcare)
#echo b4 robot command run ******************************************************************************************code downloaded ****************************************************************************
#cd /ngt-codex-qa/ngt-codex-qa && git pull
#echo ******************************************************************************************code downloaded ****************************************************************************
#echo ******************************************************************************************code downloaded ****************************************************************************
#echo ******************************************************************************************code downloaded ****************************************************************************
#echo ******************************************************************************************code downloaded ****************************************************************************

#cd /ngt-codex-qa/ngt-codex-qa && mvn clean
#cd /ngt-codex-qa/ngt-codex-qa && mvn package -DskipTests 
#cd /ngt-codex-qa/ngt-codex-qa && mvn gauge:execute -DspecsDir=specs/$CASES -Denv=$ENV

echo the command is $EXE_RESULTS $SELECTED $METRIC_COMPL'_'$ENV'_'$CASES.robot

cd /robot/RF_Codex/RF_Codex_Prod_Stream/APP/ESHOP/Test_Case && robot $EXE_RESULTS $SELECTED $METRIC_COMPL'_'$ENV'_'$CASES.robot

#/ESHOP/Test_Case/ESHOP_Production_Suite.robot

#docker run -v "C:\du\Projects\QMS\TAM\2022\Codex\RF_Codex":"/results" -it --rm rfcodex  --outputdir /results/ResultFile/Result --include QAD-11111 ESHOP/Test_Case/ESHOP_Production_Suite.robot

#docker run  -v HttpShared:/root/ngt-codex-qa/HttpShared -e PUSH_GATE=http://192.168.0.16:9091 -e CASES=eshop_direct_links -e ENV=eshop_prd -e METRIC_COMPL=eshop -e JOB_NAME=eshop_prd --name meshoprobot4 robot:4.0

#docker run -v "C:\du\Projects\QMS\TAM\2022\Codex\RF_Codex":"/results" -e PUSH_GATE=http://192.168.0.16:9091 -e CASES=Suite -e EXE_RESULTS="--outputdir /results/ResultFile/Result" -e SELECTED="--include QAD-11111" -e ENV=Production -e METRIC_COMPL=ESHOP -e JOB_NAME=ESHOP_Production --name rf_test rf_codex:1.0


sh /ngt-codex-qa/ngt-codex-qa/bin/prometrics.sh
#sh /ngt-codex-qa/ngt-codex-qa/bin/checkiotenv.sh



#docker run -v "C:\du\Projects\QMS\TAM\2022\Codex\RF_Codex":"/results" -e PUSH_GATE=http://192.168.0.16:9091 -e CASES=Suite -e EXE_RESULTS="--outputdir /results/RF_Codex/RF_Codex_Prod_Stream/ResultFile/Result" -e SELECTED="--include QAD-11111" -e ENV=Production -e METRIC_COMPL=ESHOP -e JOB_NAME=ESHOP_Production --name rf_test rf_codex:2.0

#docker run -v "C:\nomi\GitHubLocalRepo":"/results" -e PUSH_GATE=http://192.168.0.16:9091 -e CASES=Suite -e EXE_RESULTS="--outputdir /results/RF_Codex/RF_Codex_Prod_Stream/ResultFile/Result" -e SELECTED="--include QAD-11111" -e ENV=Production -e METRIC_COMPL=ESHOP -e JOB_NAME=ESHOP_Production --name rf_test rf_codex:2.0