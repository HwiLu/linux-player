 ## cache_drop
 
 ```vim
 sync;
 sleep 6;
 echo 3 >/proc/sys/vm/drop_caches
 ```
 that is "sync data from cache to disk before drop."
## 永久开启某项服务
```vim 
service cgroups start   #开启cgroups服务
chkconfig cgroups on   #开启启动
```
## 统计每个目录瞎文件所占空间的大小，并由大到小排序

```vim 
du -s -h /* | sort -n
```

## 一次性杀掉带某关键字的所有进程
For example:
**一次杀掉所有带有ambari关键字的进程**
```vim
ps -ef  | grep ambari| grep -v grep  | awk '{print $2}' | xargs  kill -9
```
or
```vim
ps -ef  | grep ambari| grep -v grep  | awk '{print $2}' -exec rm -f {} \;
```
## nfs 挂载
```vim
#nfs挂载

mount -t nfs -o rw,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,proto=tcp ip:/sop/fileserver /mnt/fileserver

umount /mnt/fileserver
```
