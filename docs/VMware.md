# VMware

## VMware 挂载文件夹

```shell
vmhgfs-fuse .host:/Asuka /mnt
```

## FAQ

## 1. VMware CentOS root 背景黑色，不显示上下的任务栏

```shell
# 删除 gnome 缓存
rm -rf /root/.cache/thumbnails/fail/gnome-thumbnail-factory
rm -rf /root/.cache/gnome-shell
rm -rf /root/.cache/gnome-software
rm -rf /root/.cache/gnome-control-center
rm -rf /root/.config/gnome-initial-setup-done
rm -rf /root/.config/gnome-session
rm -rf /root/.local/share/gnome-shell
rm -rf /root/.local/share/gnome-settings-daemon
# 重启
reboot
```
