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
