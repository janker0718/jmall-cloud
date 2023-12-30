# 创建namesrv服务

## 拉取镜像

```
docker pull apache/rocketmq:4.9.7
```

## 创建namesrv数据存储路径

```
mkdir -p  /root/docker/rocketmq4.9.7/data/namesrv/logs   /root/docker/rocketmq4.9.7/data/namesrv/store
```

## 构建namesrv容器

```
docker run -d \
--restart=always \
--name rmqnamesrv \
-p 19876:9876 \
-v /root/docker/rocketmq4.9.7/data/namesrv/logs:/root/logs \
-v /root/docker/rocketmq4.9.7/data/namesrv/store:/root/store \
-e "MAX_POSSIBLE_HEAP=100000000" \
apache/rocketmq:4.9.7 \
sh mqnamesrv
```

| **参数**                                                     | **说明**                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| -d                                                           | 以守护进程的方式启动                                         |
| - -restart=always                                            | docker重启时候容器自动重启                                   |
| - -name rmqnamesrv                                           | 把容器的名字设置为rmqnamesrv                                 |
| -p 9876:9876                                                 | 把容器内的端口9876挂载到宿主机9876上面                       |
| `-v /Users/janker/Documents/docker/rocketmq/data/namesrv/logs:/root/logs` | 把容器内的 `/root/logs` 日志目录挂载到宿主机的  `/Users/janker/Documents/docker/rocketmq/data/namesrv/logs` 目录 |
| -v /docker/rocketmq/data/namesrv/store:/root/store           | 把容器内的/root/store数据存储目录挂载到宿主机的 /docker/rocketmq/data/namesrv目录 |
| rmqnamesrv                                                   | 容器的名字                                                   |
| -e “MAX_POSSIBLE_HEAP=100000000”                             | 设置容器的最大堆内存为100000000                              |
| rocketmqinc/rocketmq                                         | 使用的镜像名称                                               |
| sh mqnamesrv                                                 | 启动namesrv服务                                              |

# 创建broker节点

## 创建broker数据存储路径

```
mkdir -p /root/docker/rocketmq4.9.7/data/broker/logs   /root/docker/rocketmq4.9.7/data/broker/store //root/docker/rocketmq4.9.7/conf
```

## 创建配置文件

```
vi /root/docker/rocketmq4.9.7/conf/broker.conf
# 所属集群名称，如果节点较多可以配置多个
brokerClusterName = DefaultCluster
#broker名称，master和slave使用相同的名称，表明他们的主从关系
brokerName = broker-a
#0表示Master，大于0表示不同的slave
brokerId = 0
#表示几点做消息删除动作，默认是凌晨4点
deleteWhen = 04
#在磁盘上保留消息的时长，单位是小时
fileReservedTime = 48
#有三个值：SYNC_MASTER，ASYNC_MASTER，SLAVE；同步和异步表示Master和Slave之间同步数据的机制；
brokerRole = ASYNC_MASTER
#刷盘策略，取值为：ASYNC_FLUSH，SYNC_FLUSH表示同步刷盘和异步刷盘；SYNC_FLUSH消息写入磁盘后才返回成功状态，ASYNC_FLUSH不需要；
flushDiskType = ASYNC_FLUSH
# 设置broker节点所在服务器的ip地址
brokerIP1 = 192.168.31.164
# 磁盘使用达到95%之后,生产者再写入消息会报错 CODE: 14 DESC: service not available now, maybe disk full
diskMaxUsedSpaceRatio=95
```

## 构建broker容器

```
docker run -d  \
--restart=always \
--name rmqbroker \
--link rmqnamesrv:namesrv \
-p 10911:10911 \
-p 10909:10909 \
-v  /root/docker/rocketmq4.9.7/data/broker/logs:/root/logs \
-v  /root/docker/rocketmq4.9.7/data/broker/store:/root/store \
-v /root/docker/rocketmq4.9.7/conf/broker.conf:/home/rocketmq/rocketmq-4.9.7/conf/broker.conf \
-e "NAMESRV_ADDR=namesrv:9876" \
-e "JAVA_OPT_EXT=-server -Xms512m -Xmx512m" \
-e "MAX_POSSIBLE_HEAP=200000000" \
apache/rocketmq:4.9.7 \
sh mqbroker -c /home/rocketmq/rocketmq-4.9.7/conf/broker.conf
```

看到下面的启动日志就代表启动成功了。

<img src="https://qiniu-cdn.janker.top/mdimg/image-20230125113645521.png" alt="image-20230125113645521" style="zoom:80%;" />

# 创建 dashboard

## 拉取镜像

```
docker pull apacherocketmq/rocketmq-dashboard:1.0.0
```

## 运行容器应用

```
docker run -d \
--restart=always \
--name rocketmq-console \
-e "JAVA_OPTS=-Drocketmq.namesrv.addr=192.168.217.10:19876 -Dcom.rocketmq.sendMessageWithVIPChannel=false" -p 9998:8080 apacherocketmq/rocketmq-dashboard:1.0.0
```

## 访问控制台

http://192.168.31.164:9998/#/

<img src="https://qiniu-cdn.janker.top/mdimg/image-20230125160859456.png" alt="image-20230125160859456" style="zoom:67%;" />