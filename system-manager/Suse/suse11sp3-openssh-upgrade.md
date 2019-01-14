# 将suse11 sp3 openssh版本从6.6升级到7.9
## 开启telnet

1. 检查telnet服务是否安装
```sh
chkconfig -list|grep telnet
```       
2. 安装telnet服务

```sh 
zypper refresh
zypper in telnet-server
```
zypper源配置请见[zypper源配置](./zypper_confugurate.md)

3. 修改/etc/xinetd.d/telnet文件
```sh
vi /etc/xinetd.d/telnet
```
将disable的值设置为no
 

4. 重启xinetd服务
```sh
     service xinetd restart
     
     rcxinetd start     
```
5. 若要开放root登录权限，则配置/etc/pam.d/login文件
```sh
vi /etc/pam.d/login
```
将auth    required       pam_securetty.so这一行注释掉即可；

## 安装依赖包

```sh
zypper  in gcc* 
zypper in pam_ssh
```
### 安装zlib

需提前下载好zlib-1.2.11.tar.gz包zlib

```sh
tar -zxvf zlib-1.2.11.tar.gz  -C /usr/local/zlib
cd /usr/local/zlib/ ; ./configure --shared ; make && make install
```

### 安装openssl

```sh
tar zxvf /tmp/openssl-1.0.2o.tar.gz ; cd openssl-1.0.2o/; ./config shared ; make && make install 

mv /usr/bin/openssl /usr/bin/openssl.old

ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl 
ln -s /usr/local/ssl/include/openssl /usr/include/openssl 

echo "/usr/local/ssl/lib" >> /etc/ld.so.conf 

ldconfig 
/sbin/ldconfig -v
openssl version -a
```

### 安装openssh

```sh
tar zxvf openssh-7.5p1.tar.gz ;cd openssh-7.9p1;./configure --prefix=/usr/ --sysconfdir=/etc/ssh -with-zlib -with-ssl-dir=/usr/local/ssl -with-md5-passwords mandir=/usr/share/man ; make && make install 

cp -p contrib/suse/rc.sshd /etc/init.d/sshd 
chmod +x /etc/init.d/sshd 
chkconfig --add sshd
cp sshd_config /etc/ssh/

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config #如果原本就是yes，则不需要执行

mv /usr/sbin/sshd{,.old}
mv /usr/bin/ssh{,.old}

cp sshd /usr/sbin/sshd
cp ssh /usr/bin/ssh

/etc/init.d/sshd restart
ssh -V

```
