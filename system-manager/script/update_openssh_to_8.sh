[localhost]# cat up.sh 
#!/bin/bash
hn=`hostname`
#ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl
tar -zvxf /root/openssh-8.0p1.tar.gz
cd /root/openssh-8.0p1/
./configure --prefix=/usr/ --sysconfdir=/etc/ssh --with-pam --with-zlib=/usr/local/zlib/ --with-ssl-dir=/usr/local/
make && make install 
echo "${hn} result: $?"


[localhost]#  cat updateOpensshTo8.sh 
#!/bin/bash
nodes=$1
for node in `cat $nodes | grep -v ^# | grep -v ^$ | awk '{print $1}'`
do
        echo "__________${node}___________"
        #scp /root/openssh-8.0p1.tar.gz root@$node:/root

        ssh root@$node bash -s < up.sh
        ssh root@$node "ssh -V"


don
