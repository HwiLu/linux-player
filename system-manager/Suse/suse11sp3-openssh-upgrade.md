
## 开启telnet

1. 检查telnet服务是否安装
```sh
chkconfig -list|grep telnet
```       

2.安装telnet服务

```sh 
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
