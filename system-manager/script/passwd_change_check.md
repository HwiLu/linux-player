
## 将之前主机一致的密码改成随机产生的密码

```vim
#!/bin/sh
#nodes means all of host you want to operate

for node in `cat nodes | grep -v ^# | grep -v ^$ | awk '{print $1}'`
do
    password=`mkpasswd` #随机生成密码
    echo $node:$password 
    echo $node:$password >> password.txt
    sshpass -p 原始密码 ssh root@$node "echo root:$password | chpasswd"
done
```

## 检查root密码是否正确脚本

```vim
#!/bin/bash
#Guide：使用普通账号运行，运行结果输出相应的hostname代表该主机root密码正确
for ip in `cat nodes | grep -v "#" | awk '{print $1}'`
do
       echo $ip
       sshpass -p "Your_Passwd" ssh -o StrictHostKeyChecking=no root@$ip "hostname" | tee yanzheng.log

done

```

## read old passwd and change to the new one

```vim

#!/bin/sh

for node in `cat nodes | grep -v ^# | awk '{print $1}'`
do
    old_password=`grep -w $node password.txt | cut -d: -f2`
    #password=`mkpasswd | sed  's/\W/%/g'`
	
    new_password='Cqqq%2018'
    echo $node:$old_password:$new_password

    sshpass -p $old_password ssh root@$node "echo root:$new_password | chpasswd"
done
```
