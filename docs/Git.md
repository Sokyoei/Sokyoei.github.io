# Git

## git 初始化

```shell
# 初始化仓库
git init
# 克隆项目（包括子项目）
git clone url [--recursive]
```

## git 本地仓库提交

```shell
git merge

git reset

git rebase

# 添加文件到暂存区
git add

# 提交到本地仓库
git commit

git checkout

git cherry-pick

# 查看当前的状态
git status

# 查看提交的日志
git log
# 查看分支
git branch
```

## git 远程仓库

```shell
# 与远程仓库进行同步
git pull
# 推送到远程仓库
git push
```

## git submodule

```shell
# 添加子模块
git submodule add url [dst]
# clone 之后更新子模块
git submodule update --remote
# 更新子模块
git submodule update --init --remote
```

> 在主仓库中更新子仓库的内容时，先保障子仓库的 HEAD 指针指向 master 而不是某个 commit, 否则无法推送到远程仓库，因为 HEAD
> 此时是 detached 的

## git 更改 log

```shell
# 修改上次 log
git commit --amend
```

## git Windows 下更改文件名大小写

```shell
git mv src_path dst_path
```

## GitHub

## 私有仓库 pull push

1. token
2. ssh

## FAQ

### TCP connection reset by peer

```log
fatal: unable to access 'https://github.com/Sokyoei/Ceceilia/': TCP connection reset by peer
```
