#!/bin/bash

#配合monitor_api.sh一起使用

function submitJob(){
	usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples-2.8.2-bc1.4.0.jar pi 10 1000 >jobStatus.log 2>&1 &	
	submitJobId=`cat jobStatus.log | grep -a "Running job: job_" | awk '{print $NF}' | sort | uniq | sed 's/job/application/g' | tail -n 1`
	
	echo "SubmitJobID:  $submitJobId"
}

function getJobId(){

        cat jobStatus.log | grep -a "Running job: job_" | awk '{print $NF}' | sort | uniq | sed 's/job/application/g' > jobID.txt

        for job in `cat jobID.txt`
        do
                match=`grep  $job appID.log`
                if [ -z "$match" ];then
                        
                echo $job >> jobID2.txt
                
                fi
        done
        jobId=`grep -v ^#  jobID2.txt | grep -v '^$' | tail -n 20 | head -n 1`
        echo $jobId >> appID.log
        echo  $jobId

}

function killJob(){

	appId=$(getJobId)
	
        echo $appId >> appID.log

        if [ -n  "$appId" ];then

                echo "Kill job: "$appId

                yarn application -kill $appId  >> stability.log 2>&1 &

	#	sed  -i 's/'$appId'/#'$appId'/g' jobID.txt

		#sed -i 's/'$appId'/\n/g' jobID.txt
        else
                echo 'No Job To Kill'
        fi
}

function checkThreshold(){
        ratio=`tail -n 1 monitor_data |awk '{print $6}' | sed 's/%//g'`
        return $ratio

}

threshold=$1
interval=$2
#numJob=1

current=`/bin/date +"%Y/%m/%d %H:%M:%S"`
while [ 0 ]
do
        usage=`tail -n 1 monitor_data |awk '{print $4}'`

        echo "Current Memory Usage: "$usage", Threshold: "$threshold

        if [ `echo "$usage > $threshold" | bc` -eq 1 ];then
                        killJob
			sleep 10
        else
                        submitJob

		threshold_usage=`echo "scale=4;$threshold - $usage" | bc`
		if [ `echo "$threshold_usage > 15" | bc` -eq 1 ];then
			submitJob
		else
			echo 
		fi
			echo ----------------------------------
        fi
        sleep  $interval

done

