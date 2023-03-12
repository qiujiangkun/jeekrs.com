---
title: 安装Gentoo简明教程
date: 2019-08-23 13:56:01
---
## 感想
最近为了安装Gentoo,前前后后花了几天时间,在虚拟机中装了两次,都是在同一个地方失败,后来装funtoo太慢,也放弃了.昨天在台式机上划分了100G的硬盘,直接装机,而且老老实实按照教程来做,确实成功了.

这篇文章假设你有一定的linux基础,并且能够独立按照教程安装archlinux并理解其中的每一步.为了保证在国内有最快的下载速度,本文的链接全部为清华开源软件镜像tuna的.

本文章不包括本地化的内容,这方面参阅下面的链接.

更多信息参考 https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Base/zh-cn 和 [ArchWiki: 不同发行版的比较](https://wiki.archlinux.org/index.php/Arch_compared_to_other_distributions_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87) "ArchWiki: 不同发行版的比较")
# 安装
## 进入可用的联网的Linux系统
Gentoo 和 Linux From Scratch  等类似,不需要具体的某一个本地安装盘,这里只需要随便一张CD或者现有的系统都可以.推荐 Archlinux 安装盘或者Manjaro 18.04 xfce4 LiveCD.

Archlinux 安装盘的特点是小,但包含了vim等好用的编辑器
https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/archlinux-2019.08.01-x86_64.iso

Manjaro 18.0.4 xfce4 LiveCD 的特点是好看...grub2也好看. 我记得也是有vim的
https://mirrors.tuna.tsinghua.edu.cn/osdn/storage/g/m/ma/manjaro/xfce/18.0.4/manjaro-xfce-18.0.4-stable-x86_64.iso

## 硬盘分区
用熟悉的硬盘分区工具给硬盘分区,建议分区格式为/boot ext2, swap分区swap, 别的分区ext4

如果需要给ext4分区调整大小,需要gpart,也就是需要图形界面,如果需要这个建议下载Manjaro的LiveCD

## 挂载系统
```bash
mount /dev/devx /mnt
# 如果有单独的boot分区
mkdir /mnt/boot
mount /dev/devy /mnt/boot
```

## 下载并解压stage3镜像
```bash
cd /mnt
wget https://mirrors.tuna.tsinghua.edu.cn/gentoo/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20190821T214502Z.tar.xz
tar xJpvf stage3-amd64-20190821T214502Z.tar.xz
# x 为解压, J 为tar.xz格式, p 为保留权限, v 为显示进度, f 为输入为文件而不是stdin
```

## chroot进入系统

```bash
# 复制dns服务器信息
cp /etc/resolv.conf /mnt/etc/resolv.conf
# 重新绑定dev, sys, proc等特殊文件
mount --types proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev

chroot /mnt /bin/bash
source /ext/profile
export PS1=&quot;(chroot) $PS1&quot;
```
## 配置 make.conf
添加tuna源, 在 /etc/portage/make.conf 中加入`GENTOO_MIRRORS="https://mirrors.tuna.tsinghua.edu.cn/gentoo"`

多线程编译, 在 /etc/portage/make.conf 中加入
`MAKEOPTS="-j5"`, 其中5表示5线程编译.线程推荐数目为cpu核心数+1.

## 安装必要的包

```bash
emerge-webrsync
eselect profile list
# 选择你的系统list
eselect profile set x
env-update &amp;&amp; etc-update &amp;&amp; source /etc/profile &amp;&amp; export PS1=&quot;(chroot) $PS1&quot;
emerge-webrsync
```
## 下载编译内核源码
```bash
emerge --ask sys-kernel/gentoo-sources
emerge --ask genkernel
nano -w /etc/fstab # 记得编辑fstab
genkernel --menuconfig all
emerge --ask sys-kernel/linux-firmware
```
## 配置grub2引导程序
这里有两条路可以走,一条是利用已有的grub2,免去了编译之苦,另一条是自行编译grub2.无论如何,要更新grub2的配置. 下面假设利用已有的grub2. 退回livecd
```bash
# 如果已经安装grub2
grub-update
# 否则 
grub-install /dev/sda --boot-directory=/mnt/boot
grub-mkconfig -o /mnt/boot/grub/grub.cfg
```
## 后续
至此你的系统大致上可用了,但还需要进一步的设置,比如安装工具,配置网络,本地化,图形界面等,参考
https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/System/zh-cn

