# Linux

[Ubuntu](Ubuntu.md)
[CentOS](CentOS.md)

## Linux 文件权限

drwxrwxrwx

|      |              |
| :--- | :----------- |
| d    | 文件夹       |
| -    | 普通文件     |
| l    | 链接文件     |
| b    | 块设备文件   |
| p    | 管道文件     |
| c    | 字符设备文件 |
| s    | 套接字文件   |

## Linux 命令

1. 系统信息

    |                 |      |
    | :-------------- | :--- |
    | [uname](#uname) |      |

2. 文件目录

    |           |           |           |           |           |                 |
    | :-------- | :-------- | :-------- | :-------- | :-------- | :-------------- |
    | [ls](#ls) | [mv](#mv) | [rm](#rm) | [cp](#cp) | [ln](#ln) | [mkdir](#mkdir) |

3. 文件搜索

    |                 |                     |
    | :-------------- | :------------------ |
    | [which](#which) | [whereis](#whereis) |

4. 文本查找

    |      |      |
    | :--- | :--- |
    |      |      |

5. 文件压缩

    |      |      |
    | :--- | :--- |
    |      |      |

6. 权限管理

    |      |      |
    | :--- | :--- |
    |      |      |

### ls

ls(list directory contents) 列出文件信息

```shell
# 查看包含隐藏文件
ls -a
# 查看文件详细信息
ls -l
# 查看文件详细信息（文件大小美化显示）
ls -lh
```

### mv

mv(move) 移动或重命名文件或文件夹

```shell
# 移动（不显示确认与否）
mv -f src dst
```

### pwd

pwd(print the name of the current working directory) 打印当前工作路径

```shell
pwd
```

### cp

cp(copy)

```shell
cp src dst
```

### rm

rm(remove)

```shell
# 删除文件
rm file
# 删除文件夹
rm -rf dir
```

### ln

ln(link)

### mkdir

mkdir(make directory)

### chmod

chmod(change mode)

```shell
chmod 777 file
```

### touch

### vi

### vim

### less

### tail

```shell
# 一直滚动输出
tail -f txt_file
```

### cat

显示文本文件的内容

```shell
cat txt_file
```

### awk

处理文本的应用程序

### sed

对文本进行过滤和变形处理

### file

查看文件类型

### gzip

### nohup

### kill

终止进程

### killall

终止一系列进程

### uname

显示内核信息

### free

查看内存使用情况

### reboot

重启

### shutdown

关机

### find

查找文件的位置

### grep

对文件内容搜索，返回所有匹配的行

### which

输出命令的全路径

```shell
which exe_file
```

### whereis

显示某个命令的位置

### dd

复制磁盘或文件系统

### clear

清空屏幕

### du

du(disk usage) 查看磁盘使用率

```shell
du -sh
```

### df

df(disk free)

```shell
df -h
```

### systemctl

```shell
# 查看开机启动项
systemctl list-unit-files --type=service
```

### ldd

```shell
# 查看可执行文件的依赖库
ldd exe_file
```

### top

top 性能分析工具（类似 Windows 任务管理器）

```shell
top
# 使用后进入交互模式
```

|      |          |
| :--- | :------- |
| q    | 退出     |
| h    | 帮助界面 |

### ps

ps 查看进程、应用运行状态

```shell
# 查看应用的进程
ps -ef | grep exe
```

### mount

mount

```shell
```

## 关键文件

1. /etc/rc.d/rc.local 开机自启动一些指令
2. ~/.bash_profile 设置个人用户的环境变量、个人设置等
3. /etc/profile 设置系统级的环境变量、启动程序等，对所有用户生效
4. ~/.bashrc 用来配置 shell
