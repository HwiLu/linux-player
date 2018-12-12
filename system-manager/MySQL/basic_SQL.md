## update root user passwor

mysql更改密码

```vim
mysqladmin -uroot -p原密码 password "新密码"
mysqladmin -uroot -p原密码 password ""  #将mysql的root用户密码修改为空，即登录时无需密码
mysqladmin -uroot  password "新密码" 	#将原本不需要密码登入的root用户，设置为使用新密码登录
 ```
忘记密码咋办
1. 进入安全模式
2. 修改
##　允许所有远程机器连接 
```
update user set host='%' where user='root'; 
```
