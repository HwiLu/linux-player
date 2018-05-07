
#!/bin/bash

threshold=$1
interval=$2
declare ratio=0

function submitJob(){
         /usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples-2.8.2-bc1.4.0.jar pi 10 1000  >dev/null 2>&1 
}

function killJob(){
        appId=`yarn application -list | grep root.hdfs | head -n 1 |awk '{print $1}'`
        if [ -n $appId ];then
                yarn application -kill $appId
        else
                echo "No Job To Kill"
        fi
}

function checkThreshold(){
        ratio=`tail -n 1 monitor_data |awk '{print $6}' | sed 's/%//g'`
        echo $ratio

}

ratio=`tail -n 1 monitor_data |awk '{print $6}' | sed 's/%//g'`

if [ `echo "$ratio < $threshold" | bc` -eq 1 ];then
        killJob
else
        submitJob
fi
#sleep(`expr $interval * 1`)
