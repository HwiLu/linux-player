在bash shell脚本中不直接支持浮点数的比较，比如
```a=7.2
b=8
if [ $a -lt $b ] ; then
echo  "a less than b "
else
echo "b less than a "
fi
```
会报错 `integer expression expected`

**有两种解决办法**
- bc 方法
```
if [ `echo "$a < $b"|bc` -eq 1 ] ; then
```
- awk 方法
```
if [ `echo "$a $b" | awk '{if($1<$2) {print 0} else {print 1}}'`  -eq 0 ] ; then
```
