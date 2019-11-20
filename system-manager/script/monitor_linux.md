sh monitor_linux.sh [memory | cpu | network | io]; 参数为空时，所有指标均监控。
脚本中网卡名称，磁盘设备名需要自定义更改。

```
#!/bin/bash

function memory(){
        # memory usage
        echo 'memory: total total-free total-free-cache (total-free)/total (total-free-cache)/total'
        echo -n "`date +'%T'` " ;free | grep -E '^Mem' | awk '{print $2/1024/1024,($2-$4)/1024/1024, ($2-$4-$6)/1024/1024,($2-$4)/$2 *100 "%", ($2-$4-$6)/$2 * 100 "%" }' # linux7 的 free 命令的算法
}

function cpu(){
        # cpu usage
        #sar -u 1  | grep Average | awk 'BEGIN {total=0;n=0}{n++;total+=$8} END{printf("Cpu usage:%13.3f%\n", 100 - total/n)}'
        echo "cpu:      CPU     %user     %nice   %system   %iowait    %steal     %idle"
        echo -n "`date +'%T'`";sar -u 1 1 | grep Average
}

function network(){
        # network monitor , data of ens160
        echo "network:      IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s"
        echo -n "`date +'%T'` " ;sar -n DEV | grep Average | grep ens160
}

function io(){
        # i/o
        echo "Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn"
        iostat | egrep 'sda|sdb' | sed "s/^/`date +'%T'` /g" # sed 使用系统命令需使用双引号。

}

function main(){

        if [ -n "${target}" ];then # 这个双引号必须加上
                echo _____________${target}______________
                while [ 0 ]
                do 

                        $target

                        sleep 1
                done
        else
                while [ 0 ]
                do
                        echo ------------memory-------------
                        memory
                        echo ------------cpu----------------
                        cpu
                        echo ------------network------------
                        network
                        echo ------------io-----------------
                        io
                sleep 1 
        done
        fi


}

target=$1
main
```
