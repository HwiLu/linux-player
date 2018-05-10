awk -F':' '{if($3+0>500) print $1}' /etc/passwd
#$3+0把uid从字符串转换为整数, $3 > 500 亦可
awk -F':' '{if($3>500) print $1}' /etc/passwd

#!/bin/bash
for node in `cat nodes | awk '{print $1}'`
do
  echo $node
  echo -----------------------------------------
  ssh root@$node "awk -F':' '{if(\$3+0>500) print \$1}' /etc/passwd"
  echo -----------------------------------------
done
