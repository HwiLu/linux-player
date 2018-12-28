 # raid
## RAID 0
- 优点：使用 n 颗硬盘，即可拥有将近 n 倍的读写效能。
- 缺点：数据安全性较低，同组数组中任一硬盘发生问题就会造成数据遗失。
- 硬盘数量：最少 2 个。
![raid0](https://pic2.zhimg.com/80/0ab608c6eef8e74f926f9c1e89753a99_hd.png) 

![raid0](https://pic4.zhimg.com/80/v2-29d439a5d1a24127bc48d41e42b093af_hd.jpg)


## RAID1
- 优点：安全性依照数组里的实体硬盘数量倍数成长。
- 缺点：空间利用率是所有 RAID 中最没有效率的。
- 硬盘数量：最少 2 个。
![raid1](https://pic4.zhimg.com/80/595a2d853196c5b38ceee5d98032baeb_hd.png) 

![raid1](https://pic3.zhimg.com/80/v2-731c286299fee461a9e0c87ca231df16_hd.jpg)
 

RAID1 称为镜像，它将数据完全一致地分别写到工作磁盘和镜像 磁盘，它的磁盘空间利用率为 50% 。 RAID1 在数据写入时，响应时间会有所影响，但是读数据的时候没有影响。 RAID1 提供了最佳的数据保护，一旦工作磁盘发生故障，系统自动从镜像磁盘读取数据，不会影响用户工作。RAID1 与 RAID0 刚好相反，是为了增强数据安全性使两块 磁盘数据呈现完全镜像，从而达到安全性好、技术简单、管理方便。 RAID1 拥有完全容错的能力，但实现成本高。 RAID1 应用于对顺序读写性能要求高以及对数据保护极为重视的应用，如对邮件系统的数据保护。[reference](https://www.zhihu.com/question/20131784/answer/90235520)

## RAID5
- 优点：兼顾空间利用率与安全性。
- 缺点：需要额外的运算资源，仅能忍受 1 个硬盘损毁。
- 硬盘数量：至少 3 个。

![raid5](https://pic4.zhimg.com/80/8ff9b2beeaf295dd1f41d98af50d1ebf_hd.png) 

![raid5](https://pic2.zhimg.com/80/v2-2a1d0b4b5db928cd2b8df7f5c50f8455_hd.jpg)


## RAID 10

即raid1+0，先做raid1，然后两组raid1做raid0.

![raid10](https://pic3.zhimg.com/v2-7e66afc48d899d307db0328ca2c70a8e_r.jpg)

[reference](https://www.zhihu.com/question/20131784)
