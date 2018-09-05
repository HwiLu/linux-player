#!/bin/bash
for ip in `cat ip_list`
do
	sshpass -p password scp -o StrictHostKeyChecking=no 文件 root@$ip:/目录
	
	sshpass -p password ssh -o StrictHostKeyChecking=no username@$ip  "command"
	
	scp -r root@$ip:远程目录文件 /本地目录/      #远程主机下载文件到本地 不需要远程主机与本地主机之间有信任关系
done


