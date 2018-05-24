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

        cat /root/luhw/memory_data.txt |grep '65750'  | awk -v dt="$current" 'BEGIN {total_mem_Used=0;total_used_Perc=0;n=0}{n++;total_mem_Used+=$2;total_used_Perc+=$4} END{printf("%s   %8.fGB    %.2f%", dt,total_mem_Used/n/1024/1024,100*total_used_Perc/n)}'

        cat /root/luhw/memory_data.txt | grep '65750'  | awk 'BEGIN {app_used=0;n=0}{n++;app_mem_Perc+=$5;app_used+=$3} END{printf("%8.fGB       %.2f%", app_used/n/1024/1024, 100*app_mem_Perc/n)}'

        cat /root/luhw/cpu_data.txt | grep Average | awk 'BEGIN {total=0;n=0}{n++;total+=$8} END{printf("%13.2f%\n", 100 - total/n)}'
done
