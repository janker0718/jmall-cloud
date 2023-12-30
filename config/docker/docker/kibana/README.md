#
```shell
docker  pull kibana:7.13.4
```


mkdir 


docker run -d -p 15601:5601 --name kibana --link elasticsearch:elasticsearch docker.io/kibana:7.13.4


http://192.168.217.12:15601/#/