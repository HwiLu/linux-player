#!/bin/bash
#配合stability_control一起使用
echo "     采样时间       | 内存总用量  总使用率  实际用量  实际使用率 | CPU使用率"

echo "-------------------   ---------- --------  --------  ----------   --------"

while [ 0 ]
do
        >cpu_data.txt
        >memory_data.txt
        current=`/bin/date +"%Y/%m/%d %H:%M:%S"`

        ansible dn -m shell  -a "free | grep -E '^Mem' | awk '{print \$2,\$2-\$4, \$2-\$4-\$6,(\$2-\$4)/\$2, (\$2-\$4-\$6)/\$2 }'" >> memory_data.txt
        ansible dn -m shell -a "sar -u 1 1" >> cpu_data.txt

        #echo end_of_ansible >>cpu_data.txt
        #echo end_of_ansible >>memory_data.txt

        cat /root/memory_data.txt | grep '263567124'  | awk -v dt="$current" 'BEGIN {total_mem_Used=0;total_used_Perc=0;n=0}{n++;total_mem_Used+=$2;total_used_Perc+=$4} END{printf("%s   %8.fGB    %.2f%", dt,total_mem_Used/n/1024/1024,100*total_used_Perc/n)}'

        cat /root/memory_data.txt | grep '263567124'  | awk 'BEGIN {app_used=0;n=0}{n++;app_mem_Perc+=$5;app_used+=$3} END{printf("%8.fGB       %.2f%", app_used/n/1024/1024, 100*app_mem_Perc/n)}'

        cat /root/cpu_data.txt | grep Average | awk 'BEGIN {total=0;n=0}{n++;total+=$8} END{printf("%13.2f%\n", 100 - total/n)}'
done


#在运行过程中发现
#ansible的性能并没有想象中的那么好，
#1000台机器以上，每次并发100，发现运行几分钟之后；
#ansible程序出现运行缓慢，甚至卡死的情况；
#初步推测可能是主机IO负载过高导致
#具体原因不详。

#所以，如果需要持续不断的采集监控信息，最好还是使用监控软件的api进行采集，比如：调用ambari的api，具体见：monitor_api.sh



