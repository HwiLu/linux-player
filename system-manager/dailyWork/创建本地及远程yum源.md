## 下载源镜像或压缩文件

## 挂载或解压到某个目录
```
mount -o loop rhel-server-6.6-x86_64.rpm /mnt 
```
## 配置本地源yum.repo/ 配置文件
vim /etc/yum.repos.d/
```
[rhel-server-6.6]
name=CentOS-$releasever - Media	#自定义名称
baseurl=file:///mnt/cdrom	#本地光盘挂载路径
gpgcheck=0	#检查GPG-KEY，0为不检查，1为检查
enabled=1	#启用YUM源，0为不启用，1为启用

```
```
## 安装httpd或者ftp软件
```
yum install httpd
service httpd start
```
## 配置远程yum源

将/mnt下文件拷贝至/var/www/html之下
将file:///mnt/cdrom 改为http://ip/


[参考链接](https://www.jianshu.com/p/57f22e371e46)
