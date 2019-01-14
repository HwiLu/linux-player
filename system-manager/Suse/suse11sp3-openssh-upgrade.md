
## 开启telnet


一、检查telnet服务是否安装
chkconfig -list|grep telnet
二、安装telnet服务

   

    上传并安装telnet-server-1.2-14.4.x86_64.rpm包，安装包见附件

 

     rpm -ivh --nodeps telnet-server-1.2-14.4.x86_64.rpm

 

三、修改/etc/xinetd.d/telnet文件

 

     vi /etc/xinetd.d/telnet

 

     将disable的值设置为no

 

四、重启xinetd服务

 

     service xinetd restart

 

五、若要开放root登录权限，则配置/etc/pam.d/login文件

 

     vi /etc/pam.d/login

 

     将auth    required       pam_securetty.so这一行注释掉即可；
