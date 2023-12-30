# Docker 环境部署 elasticsearch
## 拉取镜像

```
docker pull elasticsearch:7.13.4
```

## 创建docker镜像挂载目录

```
sudo mkdir -p /root/docker/elasticsearch7.13.4/config
sudo mkdir -p /root/docker/elasticsearch7.13.4/data
sudo mkdir -p /root/docker/elasticsearch7.13.4/plugins
```

## 配置文件

```
echo "http.host: 0.0.0.0" >>/root/docker/elasticsearch7.13.4/config/elasticsearch.yml
```

## 启动

```shell
sudo docker run --name elasticsearch -p 19200:9200  -p 19300:9300 \
-e "discovery.type=single-node" \
-e ES_JAVA_OPTS="-Xms1024m -Xmx1024m" \
-v /root/docker/elasticsearch7.13.4/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /root/docker/elasticsearch7.13.4/data:/var/lib/elasticsearch/data \
-v /root/docker/elasticsearch7.13.4/plugins:/var/libelasticsearch/plugins \
-d elasticsearch:7.13.4
```

## 查看启动详情

```
docker ps  查看是否启动
docker logs elasticsearch  启动日志查询
docker restart elasticsearch   重启
docker exec -it elasticsearch bash 进入
```



## 安装可视化界面

### 拉取镜像

```
docker pull wangpengcheng/elasticsearch-head:5
```

### 运行容器

```
docker run -d -p 19100:9100 wangpengcheng/elasticsearch-head:5
```

访问 本地 `ip:9100`，连接本地 `es` 显示 `node` 健康就ok了。

## 安装插件
