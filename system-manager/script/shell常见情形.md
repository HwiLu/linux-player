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
 - 数组的使用
 ---
 
