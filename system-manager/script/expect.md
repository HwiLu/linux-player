




```sh

#!/usr/bin/expect

set ip [lindex $argv 0]
set password [lindex $argv 1]
set timeout 10
spawn ssh root@ip
expect {
    "password" {send "$password\r";}
    "yes/no" {send "yes\r";exp_continue}
}
expect "root" {send "mkdir test1\r"}
send "exit\r"
expect eof
exit
```




**example**
```sh
#! /bin/bash

destIp=$1
userName=$2
passWd=$3
command=$4

expect -c "
        set timeout 3
        spawn ssh -o StrictHostKeyChecking=no $userName@$destIp
        expect {
        \"?assword*\" {
                send \"$passWd\r\"
                expect {
                        \"node*\" {       #使用通配符，遇到node开头的主机名便执行下面语句
                                send \"$command\r\"
                                expect \"node*\" {
                                                send \"exit\r\"
                                        }
                                }
                        \"*expired*{ #当遇到密码过期时，啥也不做
                                }
                        }
                }

        \"node*\" {send \"$command\r\";expect \"node*\";send \"exit\r\"}

        }"
 ```
