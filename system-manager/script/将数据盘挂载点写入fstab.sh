#!/bin/bash
sed -i "/data[0-9]/d" /etc/fstab
for i in `egrep "/data[0-9]" /etc/mtab |awk {'print $1'}`
do
  uuid=`blkid $i |awk -F\" '{print $2}'`
  data=`grep $i /etc/mtab |awk {'print $2'}`
  echo "UUID=$uuid $data ext4 defaults 0 0" >> /etc/fstab
done
