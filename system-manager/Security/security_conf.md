针对Redhat5.x以上

# 口令策略
##  口令锁定策略
 用户连续认证失败次数设置为5则合规，否则不合规。
（1）执行备份：
```
  #cp -p /etc/pam.d/system-auth  /etc/pam.d/system-auth_bak
```

（2）修改配置（vi /etc/pam.d/system-auth）
```
auth	required	pam_tally2.so deny=5 unlock_time=300 even_deny_root root_unlock_time=10
account	required	pam_tally2.so
```
## 口令生存期

1、文件备份：

```
#cp -p /etc/login.defs /etc/login.defs_bak
```
2、修改策略设置，编辑文件/etc/login.defs(vi /etc/login.defs)，在文件中加入如下内容(如果存在则修改，不存在则添加)：
```
PASS_MAX_DAYS   90        #新建用户的密码最长使用天数不大于90
PASS_MIN_DAYS    10        #新建用户的密码最短使用天数为10
PASS_WARN_AGE   7         #新建用户的密码到期提前提醒天数为7
```
## 口令复杂度
密码需大小写特殊字符数字且8位以上
编辑文件`/etc/pam.d/system-auth`，在文件中找到如下内容：`password requisite  pam_cracklib.so`，将其修改为：

``` 
password requisite  pam_cracklib.so try_first_pass retry=3 dcredit=-1 lcredit=-1 ucredit=-1 ocredit=-1 minlen=8
```
## 口令重复次数限制

设置口令重复次数限制
`#vi /etc/pam.d/system-auth`((SUSE9:/etc/pam.d/passwd、SUSE10以上/etc/pam.d/common-password)在类似`password  sufficient pam_unix.so`所在行末尾增加remember=5，中间以空格隔开.如果没有则新增。

# 认证授权

## 使用PAM认证模块禁止wheel组之外的用户su为root

只允许wheel组的用户可以su到root
编辑文件(vi /etc/pam.d/su)
```vim
auth            sufficient      pam_rootok.so
auth            required        pam_wheel.so use_uid
```
或者
```
auth sufficient pam_rootok.so  
auth required pam_wheel.so group=wheel
```
将用户加入wheel组usermod -G wheel username      #username为需要添加至wheel组的账户名称。

# 系统服务

## 限制root 用户ssh登陆

禁止root用户远程登录系统
（1）、编辑文件`/etc/ssh/sshd_config(vi /etc/ssh/sshd_config)`，修改`PermitRootLogin`值为`no`并去掉注释。

```
PermitRootLogin no                      #则禁止了root从ssh登录。
```
（2）、重启SSH服务
```
#/etc/init.d/sshd restart
```
## 修改SSH的Banner信息

参考配置操作
1、修改文件/etc/motd的内容，如没有该文件，则创建它：
``` 
#touch /etc/motd
```
2、使用如下命令在文件/etc/motd中添加banner信息。

```
#echo " Authorized users only. All activity may be monitored and reported " > /etc/motd
```
可根据实际需要修改该文件的内容
## 修改SSH的Banner警告信息
```
#touch /etc/ssh_banner
#chown bin:bin /etc/ssh_banner
#chmod 644 /etc/ssh_banner
#echo " Authorized only. All activity will be monitored and reported " > /etc/ssh_banner
```
## 配置NFS服务限制
检查是否启用nfs

```
#chkconfig --list |grep nfs
nfs             0:off   1:off   2:off   3:off   4:off   5:off   6:off
nfslock         0:off   1:off   2:off   3:on    4:on    5:on    6:off
```
检查如果启用nfs，查看是否对nfs服务做访问限制
```
#more /etc/hosts.allow
#more /etc/hosts.deny
```
参考配置操作
1、杀掉如下NFS进程：rpc.lockd， rpc.nfsd， rpc.statd， rpc.mountd
2、禁用NFS
```
#chkconfig --level 235 nfs off
```
3、如需要nfs服务,设置限制能够访问NFS服务的IP范围：
编辑文件/etc/hosts.allow增加一行：
`nfs:允许访问的IP`
编辑文件/etc/hosts.deny增加一行：
`nfs:all或者all:all`

## 配置NTP
Redhat5/6和SUSE9/10/11系统
文件备份：
```
#cp /etc/ntp.conf /etc/ntp.conf.bak
```
编辑`/etc/ntp.conf`文件
```
#vi /etc/ntp.conf
```
添加内容：
```
server [时间服务器域名或IP]
```
## 修改FTP的Banner信息
设置vsftpd.conf内把ftp_banner配置项配置为Authorized users only. All activity may be monitored and reported.

## 用户FTP访问安全配置
修改/etc/vsftpd.conf(或者为/etc/vsftpd/vsftpd.conf)，确保以下行未被注释掉，如果没有该行，请添加:
```
    ls_recurse_enable=YES
    local_umask=022        //设置用户上传文件的属性为755
    anon_umask=022       //匿名用户上传文件(包括目录)的 umask
```
## 禁止root用户登陆ftp



参考配置操作
1、vsftp
    （1）、修改ftpusers文件，增加不能通过FTP登录的用户
        1）、首先需确定ftpusers文件位置，可以通过以下命令知道
            ```
            #cat /etc/pam.d/vsftpd
            auth       required     pam_listfile.so item=user sense=deny file=/etc/vsftpd.ftpusers onerr=succeed
           
            #其中file=/etc/vsftpd/ftpusers即为当前系统上的ftpusers文件.
            ```
        2）、修改file对应的文件在文件中增加以下用户，则该用户均不允许通过FTP登录(每隔用户占一行):
        ```
            root
            daemon
            bin
            sys
            adm
            lp
            uucp
            nuucp
            listen
            nobody
            noaccess
            nobody4
            ```
    （2）、配置vsftpd.conf文件，设定只允许特定用户通过FTP登录:
        1）、vsftpd.conf文件路径一般为/etc/vsftpd.conf或者/etc/vsftpd/vsftpd.conf。
            修改其中内容：
            ```
            userlist_enable=YES          #此选项被激活后，VSFTPD将读取userlist_file参数所指定的文件中的用户列表。
            userlist_deny=NO              #决定禁止还是只允许由userlist_file指定文件中的用户登录FTP服务器，YES默认值，禁止文件中的用户登录，同时也不向这些用户发出输入口令的提示，NO只允许在文件中的用户登录FTP服务器.
            userlist_file=/etc/vsftpd/user_list
            ```
        2）、编辑userlist_file对应的文件去掉root.



## 限制FTP用户登录后能访问的目录

（1）、编辑文件/etc/vsftpd.conf或/etc/vsftpd/vsftpd.conf
如果存在chroot_list_enable，去掉前面的注释符，修改其值等于YES。不存在则手工增加一行：
  chroot_list_enable=YES
注释掉`chroot_local_user`或者修改其值等于NO。
如果存在`chroot_list_file`，去掉前面的注释符，不存在则手工增加一行，例如:
```
chroot_list_file=/etc/vsftpd/chroot_list
```
（2）、创建chroot_list_file对应的文件
例如:

```
#touch /etc/vsftpd/chroot_list
#chmod 750 /etc/vsftpd/chroot_list"
```
# 文件权限

## 文件与目录缺省权限控制

编辑文件/etc/profile，在文件末尾加上如下内容：
```
umask 027
```
## 禁止ICMP重定向

参考配置操作
1、备份文件
```
#cp -p /etc/sysctl.conf /etc/sysctl.conf_bak
```
2、编辑文件 /etc/sysctl.conf，有则改之，无则添加以下内容：
```
net.ipv4.conf.all.accept_redirects=0
```
3、使配置生效
```
#sysctl  -p
```
## 日志文件安全
对于/var/log下的所有日志，权限均需小于640
# 日志审计

## 启用远程日志功能

编辑/etc/syslog.conf，在文件中加入如下内容: 
```
*.err;kern.debug;daemon.notice /var/adm/messages

```
其中/var/adm/messages为日志文件。
（1）如果该文件不存在，则创建该文件，命令为： 
```
#touch /var/adm/messages
```
（2）修改权限为666，命令为：
```
#chmod 666 /var/adm/messages
```
（3）重启日志服务： 
```
#/etc/init.d/syslog restart
```
# 网络通信

## 禁止IP源路由

运行以下脚本：
```
#for f in /proc/sys/net/ipv4/conf/*/accept_source_route
do
          echo 0 > $f
done
```

# 系统漏洞

## 系统core dump状态	

参考配置操作
1、编辑文件/etc/security/limits.conf(vi /etc/security/limits.conf)，在文件末尾加入如下两行(存在则修改，不存在则新增)：

```
* soft core 0
* hard core 0
```
2、编辑文件/etc/profile(vi /etc/profile)注释掉如下行：

```
#ulimit -S -c 0 > /dev/null 2>&1
```
## 禁止存在bash安全漏洞
升级bash到最高版本

# 其他配置

## 登陆超时时间设置

参考配置操作
1、执行备份
```
#cp -p /etc/profile /etc/profile_bak
```
2、在/etc/profile文件增加以下两行(如果存在则修改，否则手工添加)：
```
#vi /etc/profile
    TMOUT=300                                  #TMOUT按秒计算
    export TMOUT
```

## 设置关键文件的属性
```
chattr +a /var/log/messages
```
```
vim /etc/logrotate.d/syslog 
/var/log/cron
/var/log/maillog
/var/log/messages
/var/log/secure
/var/log/spooler
{
    prerotate
        /usr/bin/chattr -a /var/log/messages
    endscript
    sharedscripts
    postrotate
        /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
        /usr/bin/chattr +a /var/log/messages
    endscript
}
```
## 历史命令设置
参考配置操作
1、编辑文件/etc/profile，在文件中加入如下两行(存在则修改)：
```
    HISTFILESIZE=5
    HISTSIZE=5
```
2、执行以下命令让配置生效
```
    #source /etc/profile
```
## 对root为ls、rm设置别名

参考配置操作
`#echo $SHELL `
（1）、如果输出csh:
```
#vi ~/.cshrc 在文件末尾增加如下两行
        alias ls='ls -aol'
        alias rm='rm -i'
```
（2）、如果输出bash:
```
# vi ~/.bashrc在文件末尾增加如下两行
        alias ls='ls -aol'
        alias rm='rm -i'
```
