## 拉取镜像
```shell
docker pull jenkins/jenkins:2.438-jdk11
```

## 创建挂载目录
```shell
mkdir -p /root/docker/jenkins/jenkins_home
```

## 启动jenkins
```shell
docker run -d --name jenkins -p 18081:8080 --env JAVA_OPTS="-Dhudson.model.DownloadService.noSignatureCheck=true" -v /root/docker/jenkins/jenkins_home:/home/jenkins_home  -v /root/docker/java/jdk8/jdk1.8.0_391:/usr/local/jdk8 -v /root/docker/java/jdk17/jdk-17.0.9:/usr/local/jdk17 jenkins/jenkins:2.438-jdk11

docker run -d --name jenkins -p 18081:8080   jenkins/jenkins:2.438-jdk11
```


## 进入容器
```shell
docker exec -u 0 -it jenkins /bin/bash


cd /var/jenkins_home/

 docker cp jenkins:/var/jenkins_home /root/docker/jenkins
```
## 配置镜像加速
打开宿主机 Jenkins 工作目录下的hudson.model.UpdateCenter.xml文件。

```shell
vim /usr/local/jenkins/hudson.model.UpdateCenter.xml
```
原始内容如下：

```xml
<?xml version='1.1' encoding='UTF-8'?>
<sites>
  <site>
    <id>default</id>
    <url>https://updates.jenkins.io/update-center.json</url>
  </site>
</sites>
```
url 修改为国内的清华大学官方镜像地址，最终内容如下：
```xml
<?xml version='1.1' encoding='UTF-8'?>
<sites>
  <site>
    <id>default</id>
    <url>https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json</url>
  </site>
</sites>
```


## 全局工具配置







