# MySQL
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

## 允许所有远程机器连接 
```
update user set host='%' where user='root'; 
```


# Oracle

- 命令行操作
使用命令行可以轻松的操作监听的配置。请注意，务必在服务端使用命令行。

查看监听的状态:
```
lsnrctl status
```
开启监听:
```
lsnrctl start
```
停止监听:
```
lsnrctl stop
```
所谓监听，[解释](https://www.jianshu.com/p/abb6ee3c5e7f)

## login

方式一：使用默认方式用sys账户登录Oracle
使用默认方式用sys账户登录Oracle
```
sqlplus / as sysdba;
```
方式二：使用标准方式加密账户登录Oracle
```
sqlplus
输入用户名
输入密码
```
ps：请注意密码的格式，如果登录角色是sysdba，密码是你的密码[空格]as[空格]sysdba；如果登录的角色是一般角色，只需要输入密码即可
方式三：使用明码方式用账户登录Oracle
```
sqlplus 用户/密码;
```
## 数据库管理

查看当前数据库的状态
```sql
SQL> select status from v$instance;
```
查看当前数据库的名称
```sql
SQL> select name from v$database;
```
执行一个SQL文件
```sql
SQL> start [file_name] 
SQL> @ [file_name]
```

关闭当前连接
```sql
SQL> disconn;
```
打开新的连接
```SQL
SQL> conn 用户/密码
```

开启数据库
```sql
SQL> startup;
```

关闭数据库

正常关闭数据库
```sql
SQL> shutdown normal;
```


