---
title: 在linux上面使用Photoshop教程——安装、中文和显卡配置
date: 2018-12-27 23:13:11
---
最近几天调了PS CS6，感觉使用起来还不错，解决了几个大坑，分享之。
## 第一步是配置wine环境。
我推荐使用playonlinux，这可以认为是crossover的开源版本，上面甚至有qq 8.9版本（没有测试过）。
```shell
yaourt -S playonlinux
```

## 下载PS CS6安装包
在网上下载PS CS6的安装包，还有破解补丁。实际上绿色版的也可以，不过按照playonlinux的知道，用原版安装包是最好的。解压备用

## 安装和配置
打开playonlinux的页面，安装，搜索photoshop。第一次会比较慢，要耐心等待。然后根据提示安装即可。要手动破解。
它会给你安装上wine 3.4（这个会很慢，视网速）和其他一些库，不过是只能用在自己的wine中的，大概有gecko mono ... 记录下来，后续会用到（如果你需要用独立显卡）
之后会给系统打一些补丁，都是自动的。

### 关于中文
#### 黑框
参考这篇： http://www.linuxdiyf.com/linux/23474.html
不过似乎只需要做以下的就可以了。然后拷贝一份宋体字体，到wine的相应目录中

搜索： FontSubstitutes
找到的行应该是：[Software\\Microsoft\\Windows NT\\CurrentVersion\\FontSubstitutes]
将其中的：
“MS Shell Dlg”=”Tahoma”
“MS Shell Dlg 2″=”Tahoma”
改为：
“MS Shell Dlg”=”SimSun”
“MS Shell Dlg 2″=”SimSun”

#### 输入法
中文输入法的解决方法是通用的。如果是搜狗输入法，在启动脚本里添加以下内容。启动脚本在设置的最后一页，或者那个shotcut里的都可以：`~/.PlayOnLinux/shotcuts/Adobe Photoshop CS6`。
```shell
export XMODIFIERS=&quot;@im=fcitx&quot;
export GTK_IM_MODULE=&quot;fcitx&quot;
export QT_IM_MODULE=&quot;fcitx&quot;
```

### 关于独立显卡
独立显卡需要手动开启。找到`~/.PlayOnLinux/shotcuts/Adobe Photoshop CS6`，把最后一行换成 `optirun wine Photoshop.exe "$@"`。因为原有的POL_wine可能有问题，所以需要自己再安装一个wine。
我用的是aur里的`wine-staging 4.0` ，别的版本按理说也可以。然后安装好之前记忆的一些gecko mono...。
如果不想这么麻烦，可以安装某个游戏版本的wine，这个在aur里面有很多，关键词是`wine game`。

某些系统（如manjaro）可能会出现winebus.sys的错误，参考 https://forum.manjaro.org/t/playonlinux-help/20558 解决。
> 需要安装 `lib32-libldap`库

