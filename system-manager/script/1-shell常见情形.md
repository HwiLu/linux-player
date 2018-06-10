 编写脚本的时候经常会用到的一些指令和结构
- 四则运算
---
加减法

整数
```
a=1
b=2
c=3.1415
d=`expr $a - $b`
expr只能用于整数运算
```
小数
```
f=`echo "scale=4;$d - $a" | bc` #小数是几位，scale就等于几
```
- 比较大小

整数
```
if [ $var1 -gt $var2];then
  echo
fi
```

小数
```
a=12
b=23.1111
c=`echo "scale=4;$b - $a" | bc` #小数是几位，scale就等于几

if [ `echo "$b> $a"| bc` -eq 1 ];then

        echo "b大于a" 
        
elif [ `echo "$c > 10"| bc` -eq 1 ];then

        echo "b比a大10以上"
        
else
        echo
fi
```

科学计算法
```
echo "1e3" |awk '{print $0*1}'
1000
awk中对$0进行乘以1计算（也可以加0或减0），强制将输入当成数值，不然它会认为是文本，原样输出
```

- if结构
---
```
if [ ];then
  echo
fi
```
```
if [];then
  echo
 else
  echo
 fi
 ```
 ```
 if [];then
  echo
 elif
  echo
 else
 fi
 ```
 ```
     if ((  $?==0  ))
    then
            echo
    else
            echo 
    fi
 ```

 - while 结构
---
 ```
 while  [ 0 ]
 do
  echo
 done
 ```
 ```
#/bin/bash
i=0
while :    :等价为true
do
        echo "$i"
        ((i++))
        sleep 0.3
        if ((  i==200  ))  -->输出的只有1-199
        then
                break      -->当i=200时，跳出整个while循环
        fi
done
```

 - for结构
 ---
 ```
 for i in {0..10}
 do
 done
 ```
 ```
 for i in `cat file.txt `
 ```
 ```
 for i in 1 2 3 4   i在1、2、3、4中循环4次
 ```
 ```
 for i in `seq 10`  i循环10次
 ```
 ```
 for i in /etc/*.conf
 ```
 ```
 for i in $(seq -w 10) 等宽的01-10
 ```
 ```
 j=$1
 for ((i=1; i<=j; i++))
 do
    touch file$i && echo file $i is ok
 done
 ```
 - 变量自增
 ---
 ```
 num=0
  num=$(($num+1))  或
  ((num++))
 ```
 - 打印随机数
 ---
输出0-9以内的随机数
```
echo $((RANDOM%10)) 
```
输出1-10以内的随机数
```
echo $((RANDOM%10+1))
```
输出任意大小的随机数
```
for i in {0..9};do echo $RANDOM;done
```
 - 行列转换
 ---
 - 打印file文件的倒数第5行
 ```
 tail -n  5 file | head -n 1
 ```
 - 找出两个文件中不同的行，只显示file2比file1多的行
 ---
 
 ```vim
 for i in `cat file2`
 do
  match=`grep i file1`
  if [ -n match];then
   echo $i
  else
   echo
  fi
 done
 ```
 - 字符串比较
 ---
判断两个字符串是否相等
```vim
变量与字符串
if [ "$test"x = "test"x ]; then
```
```vim
两个变量
if [ "$a"x = "$b"x ]; then
```
大于小于
```vim
大于,在ASCII字母顺序下.如: 
if [[ "$a" > "$b" ]];then
if [ "$a" \> "$b" ] ;then
```

- 重定向
**Here Document**

Here Document 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序。
它的基本的形式如下：
command << delimiter
    document
delimiter
它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command。

**注意：
结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。
开始的delimiter前后的空格会被忽略掉。**
将一段内容作为输入传递给命令；示例：
```vim
$wc -l << EOF
>hehe
>haha
>heihei
>EOF
$3
$
```
**标准错误和标准输出分别存放**
```
ls /root/tmp 1>find.out 2>find.err ，这里会将 STDOUT 与 STDERR 分别存放至 find.out 和 find.err 中
```
**标准错误和标准输出全部重定向到文件**
```vim
ls /root/tmp &>find.all
```
& 是一个描述符，*如果1或2前不加&，会被当成一个普通文件。*

**标准错误和标准输出重定向至回收站**
```vim
command >dev/null 2>&1 
```
 
 - 数组的使用
 ---
 
