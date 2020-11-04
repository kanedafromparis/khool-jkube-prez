# 2 - Use mariadb via a docker instance

## Reminder

This application was created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin) and [http://maven.fabric8.io/](fabric8io/fabric8-maven-plugin) it has been update to [https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin](Eclispe jkube)

At this step we want to add a database via docker

## Sample To Do List web application using Spring Boot (and Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

## 1. instantiate a local mariadb

  1.1. (optional)

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

  1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

  1.3. start mariadb using docker

```bash
docker run --name todo-mariadb \
  -e MYSQL_USER=springuser \
  -e MYSQL_PASSWORD=mypassword-quoor-uHoe7z \
  -e MYSQL_DATABASE=db_todo \
  -e MYSQL_ROOT_PASSWORD=r00t-aeKie8ahWai_ \
  -p 3306:3306 \
  -d mariadb:10.3.10
```

## 2. create basic project files

  2.1. update file :
    - [pom.xml](pom.xml) update version and dependency
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

  2.2. create [src/main/resources/application-mariadb.properties](src/main/resources/application-mariadb.properties) with correct docker ip

  2.3. `mvn clean package`

  2.4. `export SPRING_PROFILES_ACTIVE=mariadb && mvn spring-boot:run`

## 3. Check project

   3.1. Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

   3.2. check you database mouvement with
`watch -n 2 bash src/main/bash/showtables.sh`

## Next Step

Create a docker image and a docker-compose