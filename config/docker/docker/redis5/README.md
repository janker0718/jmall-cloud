

```shell
docker run  -d --privileged=true  --name redis5 --restart=always -p 16379:6379 -v /root/docker/redis5/conf/redis.conf:/etc/redis/redis.conf -v /root/docker/redis5/data:/data  redis:5 redis-server /etc/redis/redis.conf --appendonly yes --requirepass "123456"
```