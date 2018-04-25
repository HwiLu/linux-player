#!/bin/bash
for ip in `cat ip_list`
do
	sshpass -p PASSWD scp -o StrictHostKeyChecking=no 文件 root@$ip:/目录
	
	sshpass -p password ssh -o StrictHostKeyChecking=no username@$ip  "command"
	
	scp -r root@$:目录/heb* /本地目录
done
