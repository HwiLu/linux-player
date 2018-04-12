#!/bin/bash

#Guide：使用普通账号运行，运行结果输出相应的hostname代表该主机root密码正确

for ip in `cat nodes | grep -v "#" | awk '{print $1}'`
do
       echo $ip
       sshpass -p "Your_Passwd" ssh -o StrictHostKeyChecking=no root@$ip "hostname" | tee yanzheng.log

done

