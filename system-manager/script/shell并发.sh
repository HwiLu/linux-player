#!/bin/bash

conNum=$1 #并发数

[ -e ./fork ] || mkfifo ./fork

exec 3<> ./fork   

rm -rf ./fork                   

 
for i in `seq 1 $conNum`;
do
   
    echo >&3                   
done


for i in `seq 1 $conNum`
do
    read -u3                    
    {
        hadoop jar xxx

    }&
done

wait

exec 3<&-                       
exec 3>&-                       
