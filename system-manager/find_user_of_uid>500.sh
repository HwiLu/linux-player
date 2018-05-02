awk -F':' '{if($3+0>1000) print $1}' /etc/passwd
#$3+0把uid从字符串转换为整数
