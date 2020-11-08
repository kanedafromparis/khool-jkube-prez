# 3 - Build a docker image from our projet and use mariadb with docker-compose

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to create a docker image of our project and make it works with mariadb within the same docker network

## Sample To Do List web application using Spring Boot, Mariadb using docker-compose

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template, Mariadb, )

## 1. instantiate a local mariadb

### 1.1. (optional)

```bash
minikube -p khool-jkube-prez start
# 😄  [khool-jkube-prez] minikube v1.14.2 on Darwin 10.15.7
# ...
# 🏄  Done! kubectl is now configured to use "khool-jkube-prez" by default
```

The first start need to retreive and setup the environement so i might take some time. From 2 to 15 min, depending on your configuration and your network.

### 1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

## 2. create basic project files

### 2.1. update file

- [pom.xml](pom.xml) update version and dependency

- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

### 2.2. create project [Dockerfile](Dockerfile)

### 2.3. create a application config file [src/main/resources/application.mariadb.compose.properties](application.properties)

### 2.4. create project [docker-compose.yml](docker-compose.yml)

### 2.5. `mvn clean package`

```bash
mvn clean package
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.3-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
#...
```

### 2.6. `docker-compose build`

```bash
docker-compose build
# mariadb uses an image, skipping
# Building springboot
# Step 1/8 : FROM adoptopenjdk:11-jre-hotspot
#  ---> 39af3d85a52b
# Step 2/8 : ENV JVM_OPTIONS="-Djava.security.egd=file:/dev/./urandom                  -XshowSettings:vm"
#  ---> Using cache
#  ---> 3cd5567d6c43
# Step 3/8 : RUN mkdir -p /opt/prez-fabric8-dmp/conf/
#  ---> Using cache
#  ---> 3f97a7032b5d
# Step 4/8 : COPY src/main/resources/application.mariadb.compose.properties /opt/prez-fabric8-dmp/conf/application.properties
#  ---> Using cache
#  ---> 1b134a38e6f6
# Step 5/8 : COPY target/prez-fabric8-dmp-0.1.3-SNAPSHOT.jar /opt/prez-fabric8-dmp/prez-fabric8-dmp.jar
#  ---> 3bf8077c175e
# Step 6/8 : USER 1001
#  ---> Running in 4d2fd2e0e643
# Removing intermediate container 4d2fd2e0e643
#  ---> f5c619ecdc21
# Step 7/8 : WORKDIR /opt/prez-fabric8-dmp
#  ---> Running in b1c9854831f4
# Removing intermediate container b1c9854831f4
#  ---> e2e4cf2e4d2e
# Step 8/8 : ENTRYPOINT java $JVM_OPTIONS                   -Dspring.config.location=/opt/prez-fabric8-dmp/conf/application.properties                                         -jar /opt/prez-fabric8-dmp/prez-fabric8-dmp.jar
#  ---> Running in 585ed2e653a9
# Removing intermediate container 585ed2e653a9
#  ---> c5df11a7adfa
#
# Successfully built c5df11a7adfa
# Successfully tagged kanedafromparis/prez-fabric8-dmp:0.1.3-SNAPSHOT
```

### 2.7. `docker-compose up`

```bash
docker-compose up
# Creating network "khool-jkubeold_default" with the default driver
# Creating todo-compose-mariadb ... done
# Creating prez-compose-fabric8-dmp ... done
# Attaching to todo-compose-mariadb, prez-compose-fabric8-dmp
# prez-compose-fabric8-dmp | VM settings:
# ...
# prez-compose-fabric8-dmp | 2020-11-08 13:30:30.791  INFO 6 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data JPA repositories in DEFERRED mode.
# todo-compose-mariadb | Initializing database
# ..
# todo-compose-mariadb | 2020-11-08 13:30:35 0 [Note] mysqld: ready for connections.
# todo-compose-mariadb | Version: '10.3.10-MariaDB-1:10.3.10+maria~bionic'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution
# ...
# prez-compose-fabric8-dmp | 2020-11-08 13:31:06.458  INFO 7 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 9 ms
```

## 3. Check project

### 3.1. Open a web browser to [http://$(minikube -p khool-jkube-prez ip):8080](http://192.168.99.100:8080)

### 3.2. check your database mouvement with

`watch -n 2 bash showtables.sh`

## Next Step

Let's replace all with maven-plugins.
