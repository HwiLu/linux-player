
#!/bin/bash
#配合monitor_linux.sh一起使用
function submitJob(){
         /usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples-2.8.2-bc1.4.0.jar pi 10 1000 >/dev/null 2>&1 &
}

function killJob(){
        appId=`yarn application -list | grep hdfs | head -n 1 |awk '{print $1}'`

        if [ -n  "$appId" ];then
                echo "Kill job: "$appId
                yarn application -kill $appId  >> stability.log 2>&1 &

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
while [ 0 ]
do
        usage=`tail -n 1 monitor_data |awk '{print $6}' | sed 's/%//g'`

        echo "Current Memory Usage: "$usage", Threshold: "$threshold

        if [ `echo "$usage > $threshold" | bc` -eq 1 ];then
               killJob
        else
               submitJob
        fi
        sleep  $interval

done
