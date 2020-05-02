---
title: Nginx快速入门
date: 2020-05-02 23:18:17
tags:
categories: 学习笔记
---

# Nginx快速入门

{% asset_img logo.png logo %}

## 概念

### 是什么

Nginx 是一款轻量级的 Web 服务器/反向代理服务器，其特点是占有内存少，并发能力强。

### 正向代理/反向代理

{% asset_img 正向反向代理.png 正向反向代理 %}

正向代理隐藏真实客户端，反向代理隐藏真实服务端。

### 负载均衡

将负载分发到不同的服务器上。

{% asset_img 负载均衡.png 负载均衡 %}

### 动静分离

把动态页面和静态页面分发给不同的服务器进行解析，加快解析速度，降低服务器压力。

{% asset_img 动静分离.png 动静分离 %}

## 安装

[Nginx官方安装文档](http://nginx.org/en/docs/install.html)

[Nginx](http://nginx.org/en/) 原生没有集成插件，推荐使用 [OpenResty](http://openresty.org/cn/)。

类似这种的应该还有其他的，今天看视频的时候偶然发现，B站用的是[Tengine](http://tengine.taobao.org/)，也是基于 Nginx 增强的，是阿里巴巴的开源项目。

Tengine是由淘宝网发起的Web服务器项目。它在[Nginx](http://nginx.org/)的基础上，针对大访问量网站的需求，添加了很多高级功能和特性。Tengine的性能和稳定性已经在大型的网站如[淘宝网](http://www.taobao.com/)，[天猫商城](http://www.tmall.com/)等得到了很好的检验。它的最终目标是打造一个高效、稳定、安全、易用的Web平台。

OpenResty 是一个基于 Nginx 与 Lua 的高性能 Web 平台，其内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态 Web 应用、Web 服务和动态网关。

## 命令

启动

```linux
./nginx
```

关闭

```linux
./nginx -s stop
```

查看版本号

```linux
./nginx -v
```

重新加载

```linux
./nginx -s reload
```

## 配置

### 位置	

./conf/nginx.conf

### 组成

1. 全局块

   从配置文件开始到 events 之间的内容，主要是一些影响 Nginx 整体运行的配置指令。

   ```conf
   worker_processes  1;	值越大，可支持的并发处理量越大
   ```

2. events 块

   主要影响 Nginx 与用户网络的连接。

   ```conf
   worker_connections  1024;	支持最大连接数
   ```

3. http 块

   大多数功能和第三方插件的配置都在这里。

   - server 块
     - location 块

## 实例

### 反向代理

```conf
server {
        listen       80;
        server_name  localhost;

        location / {
            root   html;
            proxy_pass  http://127.0.0.1:8080;
            index  index.html index.htm;
        }
    }
```

正则

### 负载均衡

```conf
upstream myserver {
        server  127.0.0.1:8080;
        server  127.0.0.1:8081;
    }

    server {
        listen       80;
        server_name  localhost;

        location / {
            proxy_pass  http://myserver;
            root   html;
            index  index.html index.htm;
        }
    }
```

- 轮询（默认）

- ip_hash

  每个请求按访问的 ip 的 hash 结果分配，每个访客固定一个服务器，可以解决session问题。

  ```conf
  upstream myserver {
  		ip_hash;
          server  127.0.0.1:8080;
          server  127.0.0.1:8081;
      }
  ```

- weight（权重）

  根据服务器权重分配，默认权重为1。

  ```conf
  server  127.0.0.1:8080	weight=5;
  server  127.0.0.1:8081	weight=10;
  ```

- fair（第三方）

  根据服务器响应时间来分配，相应时间短的优先分配。

  ```conf
  upstream myserver {
          server  127.0.0.1:8080;
          server  127.0.0.1:8081;
          fair;
      }
  ```

### 动静分离

### 高可用集群

{% asset_img 高可用集群.png 高可用集群 %}

## 原理

