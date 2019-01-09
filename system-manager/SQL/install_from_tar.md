## 先安装mysql需要的依赖包 或者 软件

安装openssl
```sh
yum install -y openssl-devel ncurses-devel gcc-c++ cmake bison make perl 
```
## 安装mysql
```sh 
tar -zvxf mysql.xxxx.tar.gz
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
cp /usr/local/mysql/bin/mysql /bin/
```
## 登入试试
`mysql`
应该可以直接进去，不需要输入密码。
