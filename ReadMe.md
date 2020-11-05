# 4 - Build the image using io.fabric8:docker-maven-plugin:0.27.1

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).
At this step we want to create a docker image of our project and make it works with mariadb within the same docker network

## Sample To Do List web application using Spring Boot, Mariadb using docker-compose

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template, Mariadb, )

## 1. instantiate a local mariadb

  1.1. (optional)

```bash
minikube -p khool-jkube-prez start
# 😄  [khool-jkube-prez] minikube v1.14.2 on Darwin 10.15.7
# ...
# 🏄  Done! kubectl is now configured to use "khool-jkube-prez" by default
```

The first start need to retreive and setup the environement so i might take some time. From 2 to 15 min, depending on your configuration and your network.

  1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

## 2. Udpates and project files

  2.1. udpate files :
    - [pom.xml](pom.xml) in order to set io.fabric8:docker-maven-plugin configuration for our application docker image
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

  2.1. create files :
    - [src/main/docker/](src/main/docker/.forgit) this directory is needed by the plugin and can be use for an overide Dockerfile
    - [src/main/assembly/docker-assembly.xml](src/main/assembly/docker-assembly.xml) maven assembly script use to build docker image
    - [src/main/conf/application.properties](src/main/conf/application.properties) docker application properties

  2.3. (optional) remove [Dockerfile](Dockerfile) & [docker-compose.yml](docker-compose.yml)

## 3. build and run our project image using

  3.1. `mvn clean package`
  
  3.2. `mvn k8s:build`

  3.3. `docker run -e SPRING_PROFILES_ACTIVE=mariadb -e MARIADBIP=$(minikube -p khool-jkube-prez ip) -p 8888:8080 kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT`

## 4. Check project

   4.1. Open a web browser to http://$(minikube -p khool-jkube-prez ip):8888

## Next Step

Add mariadb instance into our application builded via io.fabric8:docker-maven-plugin
