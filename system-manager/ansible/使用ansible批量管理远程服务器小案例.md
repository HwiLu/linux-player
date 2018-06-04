# First command
- ping
```
ansible all -m ping
```
# copy
- copy模块

使用copy模块，可以将本地文件一键复制到远程服务器； 
-a后跟上参数，参数中指定本地文件和远端路径；
```
ansible all -m copy -a "src=/tmp/test.file dest=~/"
```
**ansible模块登录远程主机后不会加载远程主机的环境变量，所以copy时需要写远程主机的绝对路径**
# 远程批量命令
使用ansible将命令发至远程主机上执行
远程执行命令的模块有command、shell、scripts、以及raw模块
- command模块

command模块为ansible默认模块，不指定-m参数时，使用的就是command模块；m即代表module
comand模块比较简单，其命令的执行不是通过shell执行的，所以，像这些 "<", ">", "|", and "&"操作都不可以，并且，**不支持管道符**

- raw模块

类似于command模块、支持管道传递
```vim
ansible all -m raw -a "ifconfig eth0 |sed -n 2p |awk '{print \$2}' |awk -F: '{print \$2}'"
#特殊符号需要使用\进行转义
```

- shell模块

shell模块默认不加载远程主机的环境变量，如果要使用自定义的环境变量，就需要在最开始，执行加载自定义脚本的语句。
```
ansible all  -a ". .bash_profile;ps -ef |grep root" -m shell
```
shell模块可执行远程主机上的shell/python脚本
```
ansible all -m shell -a 'bash /root/test.sh'
```
- script 模块

使用script模块去执行本地的脚本：
```
ansible all  -m script -a "/opt/app/target.sh"
```
