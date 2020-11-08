# 2 - Use mariadb via a docker instance

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to add a database via docker

## Sample To Do List web application using Spring Boot (and Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

## 1. instantiate a local mariadb

### 1.1. (optional)

```bash
minikube -p khool-jkube-prez start
# 😄  [khool-jkube-prez] minikube v1.14.2 on Darwin 10.15.7
# ✨  Automatically selected the virtualbox driver
# 👍  Starting control plane node khool-jkube-prez in cluster khool-jkube-prez
# 🔥  Creating virtualbox VM (CPUs=4, Memory=4096MB, Disk=20000MB)
# 🐳  Preparing Kubernetes v1.19.2 on Docker 19.03.12 ...
# 🔎  Verifying Kubernetes components...
# 🌟  Enabled addons: storage-provisioner, default-storageclass
# 🏄  Done! kubectl is now configured to use "khool-jkube-prez" by default
```

The first start need to retreive and setup the environement so i might take some time. From 2 to 15 min, depending on your configuration and your network.

### 1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

### 1.3. start mariadb using docker

```bash
docker run --name todo-mariadb \
  -e MYSQL_USER=springuser \
  -e MYSQL_PASSWORD=mypassword-quoor-uHoe7z \
  -e MYSQL_DATABASE=db_todo \
  -e MYSQL_ROOT_PASSWORD=r00t-aeKie8ahWai_ \
  -p 3306:3306 \
  -d mariadb:10.3.10
# 6628ed033c3239db7f936e1ab54kofefe3b393425962592bb95862487ba29c9d2
```

## 2. create basic project files

### 2.1. update files

- [pom.xml](pom.xml) update version and dependency

- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

### 2.2. create file

- [src/main/resources/application-mariadb.properties](src/main/resources/application-mariadb.properties) with correct docker ip

### 2.3. `mvn clean package`

### 2.4. `mvn spring-boot:run`

```bash
export SPRING_PROFILES_ACTIVE=mariadb && \
   mvn spring-boot:run
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.2-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# ...
# [INFO] <<< spring-boot-maven-plugin:2.3.5.RELEASE:run (default-cli) < test-compile @ prez-fabric8-dmp <<<
# [INFO]
# [INFO]
# [INFO] --- spring-boot-maven-plugin:2.3.5.RELEASE:run (default-cli) @ prez-fabric8-dmp ---
# [INFO] Attaching agents: []
# 2020-11-08 14:16:58.082  INFO 15417 --- [           main] i.g.k.prez.fabric8.dmp.Application       : Starting Application on kumite. local with PID 15417 (/../khool-jkube/target/classes started by csabourdin in /../khool-jkube)
# 2020-11-08 14:16:58.084  INFO 15417 --- [           main] i.g.k.prez.fabric8.dmp.Application       : The following profiles are active:  mariadb
# ...
# 2020-11-08 14:16:59.630  INFO 15417 --- [           main] i.g.k.prez.fabric8.dmp.Application       : Started Application in 6.83 seconds (JVM running for 7.118)
#...
# you keep it running ;-)
```

## 3. Check project

   3.1. Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

   3.2. check you database mouvement with
`watch -n 2 bash src/main/bash/showtables.sh`

## Next Step

Create a docker image for our project.
