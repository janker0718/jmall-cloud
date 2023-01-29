# # Docker 环境下部署 seata-server
> Seata 的高可用依赖于注册中心、配置中心和数据库来实现。
## 安装Nacos

见 `Docker` 环境下安装 `nacos` 。

## 拉取镜像

```
docker pull seataio/seata-server:1.6.1
```

## 使用自定义配置文件

自定义配置文件需要通过挂载文件的方式实现，将宿主机上的 `application.yml` 挂载到容器中相应的目录

首先启动一个用户将resources目录文件拷出的临时容器

```
docker run -d -p 8091:8091 -p 7091:7091  --name seata-server seataio/seata-server:1.6.1
docker cp seata-server:/seata-server/resources /Users/janker/Documents/docker/seata/config
```

## 临时容器停止及销毁

```
 docker stop  seata-server # 停止容器
```

```
 docker rm  seata-server # 销毁
```

## 指定 application.yml 启动容器

```shell
docker run --name seata-server \
-p 8091:8091 \
-p 7091:7091 \
-v /Users/janker/Documents/docker/seata/config/resources:/seata-server/resources  \
-e SEATA_IP=192.168.31.164 \
-e SEATA_PORT=8091 \
-d seataio/seata-server:1.6.1
```

其中 `-e` 用于配置环境变量， `-v` 用于挂载宿主机的目录

接下来你可以看到宿主机对应目录下已经有了, `logback-spring.xml` , `application.example.yml` , `application.yml` 如果比较熟悉 `springboot` ,那么接下来就很简单了,只需要修改 `application.yml` 即可,详细配置可以参考`application.example.yml` ,该文件存放了所有可使用的详细配置。

> 参考 [使用 Docker 部署 Seata Server](https://seata.io/zh-cn/docs/ops/deploy-by-docker.html)

> 