# 安装ES

前文已经把  `elasticsearch`  已经安装完成了，本文略过。

# 安装 Skywalking OAP

### 拉取镜像

```
docker pull apache/skywalking-oap-server:8.6.0-es7
```

## 启动容器应用

```
docker run \
--name skywalking-oap \
--restart always \
-p 11800:11800 \
-p 12800:12800 -d \
--privileged=true \
-e TZ=Asia/Shanghai \
-e SW_STORAGE=elasticsearch7 \
-e SW_STORAGE_ES_CLUSTER_NODES=192.168.31.164:9200 \
apache/skywalking-oap-server:8.6.0-es7
```

# 安装 Skywalking UI

## 拉取镜像

```
 docker pull apache/skywalking-ui:8.6.0
```

## 启动容器应用

`Skywalking UI` 是对 `Skywalking` 收集到的数据进行分析展示的控制台服务，所以需要指定 `Skywalking OAP` 服务地址，使用 `Docker` 安装命令如下:

```
docker run  \
--name skywalking-ui \
--restart always \
-p 8088:8080 -d \
--privileged=true \
-e TZ=Asia/Shanghai \
-e SW_OAP_ADDRESS=192.168.31.164:12800 \
apache/skywalking-ui:8.6.0
```

因为是本地 `docker`  启动，启动时间比较长，大概得几分钟，耐心等待，就能看到下面的这个图了。

<img src="https://qiniu-cdn.janker.top/mdimg/image-20230125165504213.png" alt="image-20230125165504213" style="zoom: 33%;" />

## 启动测试

```
java -jar -javaagent:/Users/janker/Documents/docker/skywalking/skywalking-agent.jar=agent.service_name=jmall-demo,collector.backend_service=192.168.31.164:11800 -jar spring-transaction-2.2.6.RELEASE.jar
```

