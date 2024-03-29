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

# 上面这个只能执行单条命令
# 2.0
#!/bin/bash
QUEUE=`ls ./*.sql`              # 任务队列
THREAD=50                       #声明并发线程并发个数，这个是此应用的关键，也就是设置管道的最大任务数
TMPFIFO=/tmp/$$.fifo			         #声明管道名称，'$$'表示脚本当前运行的进程PID
mkfifo $TMPFIFO                 #创建管道
exec 5<>${TMPFIFO}              #创建文件标示符“5”，这个数字可以为除“0”、“1”、“2”之外的所有未声明过的字符，以读写模式操作管道文件；系统调用exec是以新的进程去代替原来的进程，但进程的PID保持不变，换句话说就是在调用进程内部执行一个可执行文件
rm -rf ${TMPFIFO}               #清除创建的管道文件

#为并发线程创建同样个数的占位
for((i=1;i<=$THREAD;i++))
do
   echo ;                       #借用read命令一次读取一行的特性，使用一个echo默认输出一个换行符，来确保每一行只有一个线程占位；这里让人联想到生产者&消费者模型，管道文件充当消息队列，来记录消费者的需求，然后由生产者去领任务，并完成任务，这里运用了异步解耦的思想。
done >&5                        #将占位信息写入管道

for sqlFile in $QUEUE           #从任务队列中依次读取任务
do
        read -u5        
 #从文件描述符管道中，获取一个管道的线程占位然后开始执行操作；read中 -u 后面跟fd，表示从文件描述符中读入，该文件描述符可以是exec新开启的。
        {
				
			dt=`date +'%F %T'`
			echo $dt $sqlFile "importing"
			mysql -hxxxx -uxxxx  -pxxxx  --database=metastore < ./$sqlFile
			dtend=`date +'%F %T'`
			echo $dtend $sqlFile "imported";echo
			
            echo "" >&5  
 #任务执行完后在fd5中写入一个占位符，以保证这个线程执行完后，线程继续保持占位，继而维持管道中永远是50个线程数，&表示该部分命令/任务放入后台不占当前的bash，实现并行处理
        } &
done
wait                #等待父进程的子进程都执行结束后再结束父进程          
exec 5>&-           #关闭fd5的管道
exit 0
