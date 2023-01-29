# Docker 环境部署 elasticsearch
## 拉取镜像

```
docker pull elasticsearch:7.13.4
```

## 创建docker镜像挂载目录

```
sudo mkdir -p /Users/janker/Documents/opt/elasticsearch/config
sudo mkdir -p /Users/janker/Documents/opt/elasticsearch/data
sudo mkdir -p /Users/janker/Documents/opt/elasticsearch/plugins
```

## 配置文件

```
echo "http.host: 0.0.0.0" >> /Users/janker/Documents/opt/elasticsearch/config/elasticsearch.yml
```

## 启动

```
sudo docker run --name elasticsearch -p 9200:9200  -p 9300:9300 \
-e "discovery.type=single-node" \
-e ES_JAVA_OPTS="-Xms84m -Xmx512m" \
-v /Users/janker/Documents/opt/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/janker/Documents/opt/elasticsearch/data:/usr/share/elasticsearch/data \
-v /Users/janker/Documents/opt/elasticsearch/plugins:/usr/share/elasticsearch/plugins \
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
docker pull elasticsearch-head:5
```

### 运行容器

```
docker run -d -p 9100:9100 mobz/elasticsearch-head:5
```

访问 本地 `ip:9100`，连接本地 `es` 显示 `node` 健康就ok了。