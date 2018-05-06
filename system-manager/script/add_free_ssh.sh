
#!/bin/sh
#配置免密登陆集群所有节点

ssh-keygen -t rsa

for node in `cat nodes | grep -v ^# | awk '{print $1}'`

do

    echo $node
    sshpass -p yourpassword ssh-copy-id root@$node 
   
done
