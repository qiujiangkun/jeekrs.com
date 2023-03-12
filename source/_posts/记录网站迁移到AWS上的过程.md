---
title: 记录网站迁移到AWS上的过程
date: 2021-02-17 13:41:27
---
自从服务器前端无法访问，后台无法登录，我已经准备好了服务器的全部备份，打算从xrea迁移到AWS。

选用的操作系统是RHEL 8, LEMP架构。（注明：RHEL在AWS上收费极高，比服务器本身费用高很多，慎重。现已经换到了Ubuntu）

在此记录一下迁移中遇到的困难和解决方法。

## 设置数据库
需要提前分配好用户和数据库

`GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';`或者
`GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'%';`

导出数据库用 `mysqldump`
然后用命令完成恢复

`mysql -u username -p < backup.sql`

## 设置 nginx和php
需要注意设置合适的用户，php插件需要用`dnf install php-*`这样的命令安装，但无须修改配置文件

## 其他
记得修改防火墙`firewalld`规则，和关闭selinux

## 关于Ubuntu
Ubuntu作为个人服务器体验非常好，而且没有额外的费用，程序较新
在后续迁移到Ubuntu的过程中，我主要参考了https://www.journaldev.com/25670/install-wordpress-nginx-ubuntu 和 https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04, 针对配置文件，我尽量不做改动，很快就迁移成功


