
- 标准输入之后无参数命令
```vim 
ps -ef  | grep ambari| grep -v grep  | awk '{print $2}' | xargs  kill -9
```
- 标准数据之后带参数命令
```vim 
ps -ef | grep XXX | awk '{print $1}' | xargs -t -I '{}' jstat -gcutil {} 1000 10 
```
Other examples:
```vim
find . -mtime +7 | xargs -I '{}' mv {} /tmp/bak/

ls *.log | xargs -t -I '{}' mv {} {}.backup

ls *.log  | xargs -I '--'  mv -- --.bak
same as :
ls *.log  | xargs -i  mv {} {}.bak
```
`-t` 参数，在执行后面的命令前，先将命令打印出来。 
-i/I, 指定替代符来替代标准输入，-I必须指定, -i可不指定，默认是 {}
> -I R                         same as --replace=R (R must be specified).
>
> -i,--replace=[R]             Replace R in initial arguments with names read from standard input. If R is unspecified, assume {}.
