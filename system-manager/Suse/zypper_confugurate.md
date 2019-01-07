1. 先将源的镜像文件.iso文件拷贝到服务器
2. 挂载到指定目录
```vim
mkdir /mnt
mount -o loop SLE-11-SP3-SDK-DVD-x86_64-GM-DVD1 /mnt
```
3. 配置
```vim
zypper ar file:///mnt/ susezypper
```
4. zypper的几个重要选项：
```vim
选项  	说明
repos, lr	列出库
sl  	列出库（目的是与rug兼容）
addrepo, ar	添加库
sa	添加库（目的是与rug兼容）
renamerepo, nr	重命名指定的安装源
modifyrepo, mr	修改指定的安装源
refresh, ref	刷新所有安装源
clean	清除本地缓存
```
5. zypper软件管理：
```vim
选项	说明
install, in	安装软件包
remove, rm	删除软件包
verify, ve	检验软件包依赖关系的完整性
update, up	更新已安装的软件包到新的版本
dist-upgrade, dup	整个系统的升级
source-install, si	安装源代码软件包和它们的编译依赖
```
6. zypper的查询选项：
```vim
选项	            说明
search, se           安装软件包
packages, pa	列出所有可用的软件包
patterns, pt	列出所有可用的模式
products, pd	列出所有可用的产品
what-provides, wp	列出能够提供指定功能的软件包
```
