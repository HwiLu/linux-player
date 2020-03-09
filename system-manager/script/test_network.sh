#!/bin/bash

#IP列表

list="12.28.19.47 12.28.19.50"

for ip in $list
do
        nc -z $ip 8000 >/dev/null
        if [ $? -eq 0 ];then
                echo "`hostname -i `  -->   $ip is ok " >> tmp_result
        else

                echo "`hostname -i `  -->   $ip is bad " >>tmp_result
        fi
		
done

# 发现nc在centos7上并没有z参数，可使用以下命令替代。

echo ']' | telent $ip 8000 
