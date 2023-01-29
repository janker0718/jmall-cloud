## 下载docker-compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/v2.15.1/docker-compose-`uname -s`-`uname -m`" -o /usr/local/bin/docker-compose
```

## 授权

```
chmod +x /usr/local/bin/docker-compose
```

## 验证

```
docker-compose --version
```

![image-20230129232120010](https://qiniu-cdn.janker.top/mdimg/image-20230129232120010.png)

出现以上的信息就证明已经安装ok了。