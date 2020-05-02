---
title: Docker核心
date: 2020-05-03 00:15:46
tags:
---

# Docker核心

{% asset_img logo.png logo %}

## 概念

| Docker | 面向对象 |
| ------ | -------- |
| 容器   | 对象     |
| 镜像   | 类       |

### 镜像

镜像（image）是一个只读的模板。

### 容器

容器（container）是用镜像创建的运行实例。

### 仓库

仓库（Repository）是集中存放镜像文件的场所。

## 命令

### 帮助

#### docker 版本

```linux
docker version
```

#### docker 信息

```linux
docker info
```

#### 帮助信息

```linux
docker --help
```

### 镜像

#### 列出本地镜像

```linux
docker images
[-a]:列出本地所有的镜像（含中间映像层）
[-q]:只显示镜像 ID
[--digests]:显示镜像的摘要信息
[--no-trunc]:显示镜像的完整信息
```

- REPOSITORY：表示镜像的仓库源
- TAG：镜像的标签
- IMAGE ID：镜像 ID
- CREATED：镜像创建时间
- SIZE：镜像大小

#### 搜索镜像

```linux
docker search 镜像名
[-s 数字]:列出 star 数不小于指定值的镜像
[--no-trunc]:显示镜像的完整信息
```

#### 下载镜像

```linux
docker pull 镜像名
```

#### 删除镜像

```linux
docker rmi 镜像名
[-f]:强制删除
$(docker images -qa):删除全部
```

### 容器

#### 新建启动容器

```linux
docker run 镜像名
[-d]:后台运行容器，并返回容器 ID，即启动守护式容器
[-i]:以交互模式运行容器，通常与 -t 同时使用
[-t]:为容器重新分配一个伪输入终端
[-P]:随机端口映射
[-p]:指定端口映射，有以下四种格式
ip:hostPort:containerPort
ip::containerPort
hostPort:containerPort
containerPort
[--name="容器新名字"]:为容器指定一个名称
```

#### 列出运行的容器

```linux
docker ps
[-a]:列出当前所有正在运行的容器和历史运行过的
[-l]:显示最近创建的容器
[-n 数字]:显示最近 n 个创建的容器
[-q]:只显示容器 ID
[--no-trunc]:显示容器的完整信息
```

#### 启动容器

```linux
docker start 容器 ID 或容器名
```

#### 进入容器

```linux
docker attach 容器 ID 或容器名
docker exec -it 容器 ID 或容器名 bashShell	不进入容器执行命令
```

#### 退出容器

```linux
exit	容器停止退出
ctrl+P+Q	容器不停止退出
```

#### 重启容器

```linux
docker restart 容器 ID 或容器名
```

#### 停止容器

```linux
docker stop 容器 ID 或容器名
```

#### 强制停止容器

```linux
docker kill 容器 ID 或容器名
```

#### 删除容器

```linux
docker rm 容器 ID 或容器名
[-f]:强制删除
$(docker ps -qa):删除全部
```

#### 查看容器日志

```linux
docker logs 容器 ID 或容器名
[-t]:加入时间戳
[-f]:动态更新日志
[--tail 数字]:显示最后多少条
```

#### 查看容器内的进程

```linux
docker top 容器 ID 或容器名
```

#### 查看容器内信息

```linux
docker inspect  容器 ID 或容器名
```

#### 从容器内拷贝文件

```linux
docker cp 容器 ID:容器内路径 主机路径
```

## Docker镜像

docker commit -m=“描述信息” -a=“作者” 容器ID 创建的镜像名:[标签名]

## 数据卷

## DockerFile

### 是什么

Dockerfile 是用来构建 Docker 镜像的构建文件，是由一系列命令和参数构成的脚本。

### 构建步骤

1. 编写 Dockerfile 文件
2. docker build
3. docker run

## Docker Compose