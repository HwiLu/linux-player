


## 为主机设计组
```sh
[groupsname]
host1
host2
[groupsname:vars]
ansible_ssh_user=root 
ansible_ssh_pass="your_password"
```

当然你也可以不分组，如下配置：
```shell
host1 ansible_ssh_user=root  ansible_ssh_pass="your_password"
host2 ansible_ssh_user=root   ansible_ssh_pass="your_password"

```













## inventory

​	