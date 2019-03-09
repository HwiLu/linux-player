#!/bin/bash
#关闭防火墙：service iptables stop
#永久关闭selinux：sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
#以上指令需要reboot系统；再使用setenforce=0临时关闭，临时关闭和永久都关闭了，那就是永久关闭

yum -y install make gcc gcc-c++ zlib-devel libtool libtool-ltdllibtool-ltdl-devel 
yum install -y bison ncurses-devel libaio gcc* python-devel curl-devel net-snmp-devel lib*-devel libxml-devel gd-devel

#安装依赖库：
#安装libxml2:
cd /usr/local/LAMP
tar -zxvf libxml2-2.9.0.tar.gz
cd ./libxml2-2.9.0
./configure --prefix=/usr/local/libxml2/
make
make install

#安装libmcrypt
#注：libmcrypt是加密算法扩展库。支持DES, 3DES, RIJNDAEL, Twofish, IDEA, GOST, CAST-256, ARCFOUR,SERPENT, SAFER+等算法。

cd /usr/local/LAMP
tar -zxvf libmcrypt-2.5.7.tar.gz
cd ./libmcrypt-2.5.7
./configure --prefix=/usr/local/libmcrypt/
make && make install

#安装mhash
Mhash是基于离散数学原理的不可逆向的php加密方式扩展库，其在默认情况下不开启。mhash的可以用于创建校验数值，消息摘要，消息认证码，以及无需原文的关键信息保存（如密码）等。
tar -zvxf mhash-0.9.9.9.tar.gz
cd /lamp/mhash-0.9.9.9
./configure
make
make install

#mcrypt未装

tar -zvxf mcrypt-2.6.8.tar.gz 
LD_LIBRARY_PATH=/usr/local/libmcrypt/lib:/usr/local/lib ./configure --with-libmcrypt-prefix=/usr/local/libmcrypt
make && make install
#安装zlib
注：zlib是提供数据压缩用的函式库
cd /usr/local/LAMP
tar -zxvf zlib-1.2.3.tar.gz
cd ./zlib-1.2.3
./configure --prefix=/usr/local/zlib/
#CFLAGS="-O3 -fPIC" ./configure --prefix=/usr/local/zlib/

#***************************************************
#{如果后面装apache或者php报zlib的错,回到这里这样编译:
#CFLAGS="-O3 -fPIC" ./configure --prefix=/usr/local/zlib/（用64位元的方法进行编译）
#}
make && make install

#编译安装libpng
cd /usr/local/LAMP
tar -zxvf libpng-1.2.31.tar.gz
cd ./libpng-1.2.31
./configure --prefix=/usr/local/libpng/ --enable-shared
make && make install
#如果报错:configure: error: ZLib not installed(没有请跳过)
#这样解决 :
#进入zlib的源文件目录，执行命令make clean,清除zlib；
#重新配置./configure,后面不要接--prefix参数；
#make && make instal
#进入libpng目录，执行命令./configure --prefix=/usr/local/libpng;
#make && make install
#如果安装成功将会在/usr/local/libpng目录下生成bin,include,lib和share四个目录。在安装GD2库配置时，通过在configure命令选项中加上“--with-png=/usr/local/libpng”选项，指定libpng库文件的位置。

#安装jpeg
tar -zxvf jpegsrc.v9a.tar.gz
cd ./jpeg-9a/
mkdir /usr/local/jpeg/ #（创建jpeg软件的安装目录）
mkdir /usr/local/jpeg/bin/ #（创建存放命令的目录）
mkdir /usr/local/jpeg/lib/ #(创建jpeg库文件所在目录）
mkdir /usr/local/jpeg/include/ #（创建存放头文件目录）
mkdir -p /usr/local/jpeg/man/man1#（建立存放手册的目录）
./configure --prefix=/usr/local/jpeg/ --enable-shared --enable-static #（建立共享库使用的GNU的libtool和静态库使用的GNU的libtool）
make && make install


#安装freetype
cd /usr/local/LAMP
tar -zxvf freetype-2.5.3.tar.gz
cd ./freetype-2.5.3
./configure --prefix=/usr/local/freetype/ --enable-shared
 make && make instal
 
#安装autoconf
cd /usr/local/LAMP
tar -zxvf autoconf-2.69.tar.gz
cd ./autoconf-2.69
./configure
make && make install

cd /usr/local/LAMP
tar -zxvf libgd-2.1.0.tar.gz
cd ./libgd-2.1.0
./configure --prefix=/usr/local/gd2 --with-jpeg=/usr/local/jpeg/ --with-png=/usr/local/libpng/ --with-zlib=/usr/local/zlib/ --with-freetype=/usr/local/freetype/
 make && make instal

#安装openssl
yum install openssl-devel ncurses-devel

yum -y install gcc-c++ cmake bison make perl
#安装mysql
tar -zvxf 
echo "以下过程要很久"
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1　-DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_TCP_PORT=3306



#重新运行配置，需要删除CMakeCache.txt文件
#rm -f CMakeCache.txt

#参数说明:：
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

make
make install
cd /usr/local/mysql/

chown -R mysql .
chgrp-R mysql .
#复制 mysql 配置文件

#初始化数据库
/usr/local/mysql/scripts/mysql_install_db --user=mysql
#------如果上面初始化失败，并且出现...ERROR: Could not find /fill_help_tables.sql 
#------是因为没有将/usr/local/mysql/下的文件改变为mysql用户；执行以下命令：
#chown -R mysql .
#chgrp -R mysql .


#复制 mysql 配置文件
cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf

#再一次初始化数据库：
/usr/local/mysql/scripts/mysql_install_db --user=mysql

#用原本源代码的方式去使用和启动 mysql
/usr/local/mysql/bin/mysqld_safe --user=mysql & # & 符号和之间的字符不要最好只隔一个空格，要不然会有问题
netstat -tulnp | grep 3306
#如果找不到mysql进程，检查防火墙是否关闭或者有没有添加网络策略

cp support-files/mysql.server /etc/init.d/mysqld
#设置开机自启动：
chkconfig mysqld on 或者 echo "/usr/local/mysql/bin/myql" >> /etc/rc.local
#将/usr/local/mysql/bin/mysql 复制到/bin下，之后便可以直接使用mysql进入mysql了
cp /usr/local/mysql/bin/mysql /bin/

#登入试试
mysql
#应该可以直接进去，不需要输入密码。


#安装PHP
yum -y install libXpm-devel httpd-devel
cd /usr/local/LAMP
tar -zxvf php-5.6.30.tar.gz
cd ./php-5.6.30
echo "以下过程要很久"
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-apxs2=/usr/sbin/apxs --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock --with-pdo-mysql=/usr/local/mysql --with-libxml-dir=/usr/local/libxml2 --with-png-dir=/usr/local/libpng --with-jpeg-dir=/usr/local/jpeg --with-freetype-dir=/usr/local/freetype --with-gd=/usr/local/gd2 --with-zlib-dir=/usr/local/zlib --with-mcrypt=/usr/local/libmcrypt --with-xpm-dir=/usr/lib64 --enable-soap --enable-mbstring=all --with-gettext --enable-bcmath --enable-sockets
make
#make阶段如果出现make: *** [libphp5.la] Error 1，这是zlib没装对，要使用64位安装。
make install

#参数说明
#./configure \
#--prefix=/usr/local/php
#--with-config-file-path=/usr/local/php/etc //配置文件路径，指定php.ini位置
#--with-apxs2=/usr/local/apache249/bin/apxs // apxs功能是使用mod_so中的//LoadModule指令，加载指定模块到apache，要求apache 要打开SO模块
#--with-mysql=/usr/local/mysql //mysql安装目录，对mysql的支持
#--with-mysqli=/usr/local/mysql/bin/mysql_config //mysqli文件目录,优化支持
#--with-libxml-dir=/usr/local/libxml2 //打开libxml2库的支持
#--with-png-dir=/usr/local/libpng //打开对png图片的支持
#--with-jpeg-dir=/usr/local/jpeg //打开对jpeg图片的支持
#--with-freetype-dir=/usr/local/freetype //打开对freetype字体库的支持
#--with-gd=/usr/local/gd //打开gd库的支持
#--with-zlib-dir=/usr/local/zlib //打开zlib库的支持
#--with-mcrypt=/usr/local/libmcrypt //打开libmcrypt库的支持
#--with-xpm-dir=/usr/lib64 //打开libXpm库的支持
#--enable-soap
#--enable-mbstring=all //多字节，字符串的支持
#--enable-sockets //打开sockets 支持
#--with-gettext //打开文本支持


#拷贝PHP配置文件
cp -rf /usr/local/LAMP/php-5.6.30/php.ini-production /usr/local/php/etc/php.ini    


#
vim  /etc/httpd/conf/httpd.conf
#添加
AddType application/x-httpd-php .php .phtml.phps
LoadModule php5_module        /usr/lib64/httpd/modules/libphp5.so
#重启Apache
service httpd restart

#测试：
cd /var/www/html/
vim test.php
#添加
<?php  
echo "哈哈";  
?>  
#打开浏览器，输入：http://ip/test.php，若能显示“哈哈”，代表解析成功！B
