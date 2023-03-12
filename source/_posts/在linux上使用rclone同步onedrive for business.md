---
title: 在linux上使用rclone同步onedrive for business
date: 2019-03-15 09:49:49
---
# 前言
之前一直在寻找onedrive business版本在linux上的客户端，无奈github上大部分程序都支持不完整，或者因为年代久远无法使用。后来看到了一篇[介绍rclone的文章](https://shui.azurewebsites.net/2017/07/07/onedrive-for-business-cli/)，在里面找到了rclone这一个神器。
# 安装
通过网络搜索，得到了rclone的项目地址[https://github.com/ncw/rclone](https://github.com/ncw/rclone)，根据里面的说明安装即可，不再赘述。
我偶然发现 archlinuxcn 源里面有这个软件，安装之。
 # 配置
 根据github上的说明，首先`rclone config`，然后根据提示操作。值得一说的是，rclone支持绝大部分国外的网盘，功能强大。

 ```shell
 % rclone config                                                                                                                                       ~
2019/03/15 09:07:48 NOTICE: Config file "/home/jack/.config/rclone/rclone.conf" not found - using defaults
No remotes found - make a new one
n) New remote
s) Set configuration password
q) Quit config
n/s/q> n
name> onedrive
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / A stackable unification remote, which can appear to merge the contents of several remotes
   \ "union"
 2 / Alias for a existing remote
   \ "alias"
 3 / Amazon Drive
   \ "amazon cloud drive"
 4 / Amazon S3 Compliant Storage Provider (AWS, Alibaba, Ceph, Digital Ocean, Dreamhost, IBM COS, Minio, etc)
   \ "s3"
 5 / Backblaze B2
   \ "b2"
 6 / Box
   \ "box"
 7 / Cache a remote
   \ "cache"
 8 / Dropbox
   \ "dropbox"
 9 / Encrypt/Decrypt a remote
   \ "crypt"
10 / FTP Connection
   \ "ftp"
11 / Google Cloud Storage (this is not Google Drive)
   \ "google cloud storage"
12 / Google Drive
   \ "drive"
13 / Hubic
   \ "hubic"
14 / JottaCloud
   \ "jottacloud"
15 / Local Disk
   \ "local"
16 / Mega
   \ "mega"
17 / Microsoft Azure Blob Storage
   \ "azureblob"
18 / Microsoft OneDrive
   \ "onedrive"
19 / OpenDrive
   \ "opendrive"
20 / Openstack Swift (Rackspace Cloud Files, Memset Memstore, OVH)
   \ "swift"
21 / Pcloud
   \ "pcloud"
22 / QingCloud Object Storage
   \ "qingstor"
23 / SSH/SFTP Connection
   \ "sftp"
24 / Webdav
   \ "webdav"
25 / Yandex Disk
   \ "yandex"
26 / http Connection
   \ "http"
Storage> 18
** See help for onedrive backend at: https://rclone.org/onedrive/ **

Microsoft App Client Id
Leave blank normally.
Enter a string value. Press Enter for the default ("").
client_id> 
Microsoft App Client Secret
Leave blank normally.
Enter a string value. Press Enter for the default ("").
client_secret> 
Edit advanced config? (y/n)
y) Yes
n) No
y/n> n
Remote config
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine
y) Yes
n) No
y/n> y
If your browser doesn't open automatically go to the following link: http://127.0.0.1:53682/auth
Log in and authorize rclone for access
Waiting for code...
Got code
Choose a number from below, or type in an existing value
 1 / OneDrive Personal or Business
   \ "onedrive"
 2 / Root Sharepoint site
   \ "sharepoint"
 3 / Type in driveID
   \ "driveid"
 4 / Type in SiteID
   \ "siteid"
 5 / Search a Sharepoint site
   \ "search"
Your choice> 1
Found 1 drives, please select the one you want to use:
0: OneDrive (business) id=b!RmQbk3CnDEmlCXzTauIX
Chose drive to use:> 0
Found drive 'root' of type 'business', URL: https://vxxxxx.sharepoint.com/personal/xxxxxx_vlity_com/Documents
Is that okay?
y) Yes
n) No
y/n> y
--------------------
[onedrive] // 此处有删减
type = onedrive
token = {"access_token":"eyJ0eXAiOiJKCJub25jZSI6IkFRQUJBQUF","token_type":"Bearer","refresh_token":"OAQABAAAAAACEfexXxjamQ","expiry":"2019-03-15T10:09:38.262653506+08:00"}
drive_id = b!RmQbk3CnDEmlCXzTauIQb9
drive_type = business
--------------------
y) Yes this is OK
e) Edit this remote
d) Delete this remote
y/e/d> y
Current remotes:

Name                 Type
====                 ====
onedrive             onedrive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q
```

 # 常见命令
 `rclone sync srcpath destpath`
 其中如果是远程目录，可以用`remotename:/remotepath`代替
 同步本地目录到远程目录，支持增量备份，但会删除src中不存在的文件。我监控过网速，上传是满速的

 `rclone copy srcpath destpath`
 其中如果是远程目录，可以用`remotename:/remotepath`代替
 将srcpath复制到destpath，可以都是远程目录

 `rclone mount remotename:/remoutpath destpath`
 可以将远程目录映射为本地磁盘

 `nohup rclone mount remotename:/remoutpath destpath & ; exit`
 将远程目录映射为本地磁盘，后台运行

 `rclone lsl remote:path [flags]`
 列举远程目录的文件

 输入`rclone help`可以得到下面的信息，我顺便翻译了一下。 输入`rclone help xxx`可以获得进一步的用法

 `shell
 about           Get quota information from the remote. 从远程获取配额信息。
 authorize       Remote authorization. 远程授权。
 cachestats      Print cache stats for a  remote打印远程服务器的缓存状态
 cat             Concatenates any files and sends them to stdout. 连接所有文件并将其发送到stdout。
 check           Checks the files in the source and destination match. 检查源和目标中的文件是否匹配。
 cleanup         Clean up the remote if  possible如果可能，清理遥控器
 config          Enter an interactive configuration session. 输入交互式配置会话。
 copy            Copy files from source to dest, skipping already  copied将文件从源复制到目标，跳过已复制的文件
 copyto          Copy files from source to dest, skipping already  copied将文件从源复制到目标，跳过已复制的文件
 copyurl         Copy url content to dest. 将URL内容复制到目标。
 cryptcheck      Cryptcheck checks the integrity of a crypted remote. 加密检查检查加密远程的完整性。
 cryptdecode     Cryptdecode returns unencrypted file names. cryptdecode返回未加密的文件名。
 dbhashsum       Produces a Dropbox hash file for all the objects in the path. 为路径中的所有对象生成Dropbox哈希文件。
 dedupe          Interactively find duplicate files and delete/rename them.以交互方式查找重复文件并删除/ 重命名它们。
 delete          Remove the contents of path. 删除路径的内容。
 deletefile      Remove a single file from remote. 从远程删除单个文件。
 genautocomplete Output completion script for a given shell. 给定shell的输出完成脚本。
 gendocs         Output markdown docs for rclone to the directory supplied. 将rclone的降价文档输出到提供的目录。
 hashsum         Produces an hashsum file for all the objects in the path. 为路径中的所有对象生成hashsum文件。
 help            Show help for rclone commands, flags and backends. 显示rclone命令、标志和后端的帮助。
 link            Generate public link to file/folder.生成到文件/ 文件夹的公共链接。
 listremotes     List all the remotes in the config file. 列出配置文件中的所有远程设备。
 ls              List the objects in the path with size and path. 列出路径中具有大小和路径的对象。
 lsd             List all directories/containers/buckets in the path.列出路径中的所有目录/容器/ 存储桶。
 lsf             List directories and objects in remote:path formatted for  parsing列出远程目录和对象：为解析格式化的路径
 lsjson          List directories and objects in the path in JSON format. 以JSON格式列出路径中的目录和对象。
 lsl             List the objects in path with modification time, size and path. 列出路径中的对象，包括修改时间、大小和路径。
 md5sum          Produces an md5sum file for all the objects in the path. 为路径中的所有对象生成MD5SUM文件。
 mkdir           Make the path if it does not already exist. 如果路径不存在，则创建该路径。
 mount           Mount the remote as file system on a mountpoint. 将远程作为文件系统安装到安装点上。
 move            Move files from source to dest. 将文件从源移动到目标。
 moveto          Move file or directory from source to dest. 将文件或目录从源移动到目标。
 ncdu            Explore a remote with a text based user interface. 使用基于文本的用户界面浏览远程。
 obscure         Obscure password for use in the rclone.conf在rclone. conf中使用的密码模糊
 purge           Remove the path and all of its contents. 删除路径及其所有内容。
 rc              Run a command against a running rclone. 对正在运行的rclone运行命令。
 rcat            Copies standard input to file on remote. 将标准输入复制到远程文件。
 rcd             Run rclone listening to remote control commands only. 运行rclone，仅收听遥控命令。
 rmdir           Remove the path if empty. 如果路径为空，则删除该路径。
 rmdirs          Remove empty directories under the path. 删除路径下的空目录。
 serve           Serve a remote over a protocol. 通过协议提供远程服务。
 settier         Changes storage class/tier of objects in remote.更改远程对象的存储类/ 层。
 sha1sum         Produces an sha1sum file for all the objects in the path. 为路径中的所有对象生成sha1sum文件。
 size            Prints the total size and number of objects in remote:path.打印remote: path中对象的总大小和数目。
 sync            Make source and dest identical, modifying destination only. 使源和目标相同，仅修改目标。
 touch           Create new file or change file modification time. 创建新文件或更改文件修改时间。
 tree            List the contents of the remote in a tree like fashion. 以树形方式列出遥控器的内容。
 version         Show the version number. 显示版本号。
```
