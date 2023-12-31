## 拉取镜像
```shell
docker pull jenkins:2.60.3
```

## 创建挂载目录
```shell
mkdir -p /root/docker/jenkins/jenkins_home
```

## 启动jenkins
```shell
docker run -d --name jenkins -p 18081:8080 -v /root/docker/jenkins/jenkins_home:/home/jenkins_home -v /root/docker/jenkins/etc:/etc jenkins:2.60.3

docker run -d --name jenkins -p 18081:8080 -v /root/docker/jenkins/jenkins_home:/home/jenkins_home  jenkins:2.60.3
```


## 进入容器
```shell
docker exec -u 0 -it jenkins /bin/bash


cd /var/jenkins_home/



 docker cp jenkins:/var/jenkins_home /root/docker/jenkins/jenkins_home
 docker cp jenkins:/etc/ /root/docker/jenkins/etc
 docker cp /root/docker/jenkins/jenkins_home/hudson.model.UpdateCenter.xml  jenkins:/var/jenkins_home/
```


