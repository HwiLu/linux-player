#!/bin/bash

#网管机IP列表

list="192.168.119.147 192.168.119.150"

for ip in $list
do
        nc -z $ip 7789 >/dev/null
        if [ $? -eq 0 ];then
                echo "`hostname -i `  -->   $ip is ok " >> tmp_result
        else

                echo "`hostname -i `  -->   $ip is bad " >>tmp_result
        fi
		
done
