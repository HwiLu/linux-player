# Method1:   使用mysql-5.6.33.tar.gz编译安装

## 先安装mysql需要的依赖包

安装openssl
```sh
yum install -y openssl-devel ncurses-devel gcc-c++ cmake bison make perl 
```
## 安装mysql
```sh 
tar -zvxf mysql-5.6.33.tar.gz -C /usr/local/mysql
echo "以下过程要很久"
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1　-DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_TCP_PORT=3306
```


**重新运行配置，需要删除CMakeCache.txt文件**
```sh
#rm -f CMakeCache.txt
```
**参数说明**
```xml
#-DCMAKE_INSTALL_PREFIX=/usr/local/mysql 安装位置
#-DMYSQL_UNIX_ADDR=/tmp/mysql.sock 指定 socket （套接字）文件位置
#-DEXTRA_CHARSETS=all 扩展字符支持
#-DDEFAULT_CHARSET=utf8 默认字符集
#-DDEFAULT_COLLATION=utf8_general_ci 默认字符校对
#-DWITH_MYISAM_STORAGE_ENGINE=1 安装 myisam 存储引擎
#-DWITH_INNOBASE_STORAGE_ENGINE=1 安装 innodb 存储引擎
#-DWITH_MEMORY_STORAGE_ENGINE=1 安装 memory存储引擎
#-DWITH_READLINE=1 支持 readline 库
#-DENABLED_LOCAL_INFILE=1 启用加载本地数据
#-DMYSQL_USER=mysql 指定 mysql 运行用户
#-DMYSQL_TCP_PORT=3306 指定 mysql 端口
```
```sh

make
make install
cd /usr/local/mysql/

chown -R mysql .
chgrp-R mysql .

```
## 初始化数据库
```sh
#/usr/local/mysql/scripts/mysql_install_db --user=mysql
#------如果上面初始化失败，并且出现...ERROR: Could not find /fill_help_tables.sql 
#------是因为没有将/usr/local/mysql/下的文件改变为mysql用户；执行以下命令：
#chown -R mysql .
#chgrp -R mysql .
```

## 复制 mysql 配置文件
```sh
cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf 
#提示是否覆盖时，输入y，将其覆盖
 ```
## 再一次初始化数据库
```sh
/usr/local/mysql/scripts/mysql_install_db --user=mysql
```
## 用原本源代码的方式去使用和启动 mysql
```
/usr/local/mysql/bin/mysqld_safe --user=mysql & # & 符号和之间的字符不要最好只隔一个空格，要不然会有问题
netstat -tulnp | grep 3306

#如果找不到mysql进程，检查防火墙是否关闭或者有没有添加网络策略

cp support-files/mysql.server /etc/init.d/mysqld
```
## 设置开机自启动
```sh
chkconfig mysqld on 或者 echo "/usr/local/mysql/bin/myql" >> /etc/rc.local
#将/usr/local/mysql/bin/mysql 复制到/bin下，之后便可以直接使用mysql进入mysql了
cp /usr/local/mysql/bin/mysql /usr/bin/
```
## 登入试试
`mysql`
应该可以直接进去，不需要输入密码。

---
# Method2:使用mysql-5.7.24-el7-x86_64.tar编译安装

创建用户
useradd -s /bin/false -d /usr/local/mysql/ mysql
创建数据目录
mkdir -p /usr/local/mysql/data
赋权给mysql用户
chown -R mysql.mysql /usr/local/mysql
安装
```sh
yum -y install libaio gcc make
tar -zvxf mysql-5.7.24-el7-x86_64.tar -C  /usr/local/mysql
 
mv /usr/local/mysql/mysql-5.7.24-el7-x86_64/* /usr/local/mysql

```
编辑MySQL配置文件
```vim
# cat /etc/my.cnf
[mysqld]
datadir=/usr/local/mysql/data
basedir=/usr/local/mysql
socket=/tmp/mysql.sock
pid-file=/usr/local/mysql/mysql.pid
log-error=/var/log/mariadb.log
port=3306
character_set_server=utf8
user=mysql
max_connections=1500

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
# Settings user and group are ignored when systemd is used.
# If you need to run mysqld under a different user or group,
# customize your systemd unit file for mariadb according to the
# instructions in http://fedoraproject.org/wiki/Systemd
[mysqld_safe]
log-error=/var/log/mariadb.log
pid-file=/usr/local/mysql/mysq.pid
#
# include all files from the config directory
#
!includedir /etc/my.cnf.d
```

## 初始化数据库
```sh
bin/mysqld --initialize --user=mysql  # << MySQL 5.7.6 更高版本执行
# 初始化过程会生成一个mysql root初始密码
```
## 启动

```sh
cp support-files/mysql.server /etc/init.d/mysqld
cp /usr/local/mysql/bin/mysql /usr/bin/
service mysqld start
```
## 登陆
使用初始化时生成的密码登陆
```sh
mysql -uroot -p
```
## 修改root密码
```sql
mysql>grant all privileges on *.* to 'root'@'%' identified by 'root';
mysql>flush privileges;
```

### **Some Bug**

1. *MySql server startup error 'The server quit without updating PID file'*

[MySql server startup error 'The server quit without updating PID file ](https://stackoverflow.com/questions/4963171/mysql-server-startup-error-the-server-quit-without-updating-pid-file)
