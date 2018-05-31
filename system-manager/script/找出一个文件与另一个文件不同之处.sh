
[root@hdp1 ca]# cat file1
aa
bb
cc
dd
[root@hdp1 ca]# cat file2
cc
aa
cc
[root@hdp1 ca]# grep -v "`cat file2`" file1
bb
dd
