## 拉取镜像

```
 docker pull mysql:5.7
```

## 运行容器

```
docker run -p 3306:3306 --name mysql -v /Users/janker/Documents/docker/mysql5.7/log:/var/log/mysql -v /Users/janker/Documents/docker/mysql5.7/data:/var/lib/mysql -v /Users/janker/Documents/docker/mysql5.7/conf:/etc/mysql -e MYSQL_ROOT_PASSWORD=123456  -d mysql:5.7
```
> 注意：挂载路径自由替换即可。