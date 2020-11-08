# 4 - Build the image using io.fabric8:docker-maven-plugin

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to create a docker image and run it using io.fabric8:docker-maven-plugin

## Sample To Do List web application using Spring Boot (and later Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

## 1. instantiate a local docker

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

  1.2. (optional / reminder)

```bash
mvn docker:help
# [INFO] Scanning for projects...
# ...
# [INFO] --- docker-maven-plugin:0.34.1:help (default-cli) @ prez-fabric8-dmp ---
# [INFO] docker-maven-plugin 0.34.1
#   Docker Maven Plugin
#
# This plugin has 14 goals:
#
# docker:build
#   Mojo for building a data image
#
# docker:help
#   Display help information on docker-maven-plugin.
#   Call mvn docker:help -Ddetail=true -Dgoal=<goal-name> to display parameter
#   details.
#
# docker:logs
#   Mojo for printing logs of a container. By default the logs of all containers
#   are shown interwoven with the time occured. The log output can be highly
#   customized in the plugin configuration, please refer to the reference manual
#   for documentation. This Mojo is intended for standalone usage. See StartMojo
#   for how to enabling logging when starting containers.
#
# ...
#
# docker:run
#   Alias for `docker:start`
#
# ...
#
```

## 2. Udpates and project files

### 2.1. udpate files

- [pom.xml](pom.xml) in order to set io.fabric8:docker-maven-plugin configuration for our application docker image

- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

### 2.1. create files

- [src/main/docker/](src/main/docker/.forgit) this directory is needed by the plugin and can be use for an overide Dockerfile

- [src/main/assembly/docker-assembly.xml](src/main/assembly/docker-assembly.xml) maven assembly script use to build docker image

- [src/main/conf/application.properties](src/main/conf/application.properties) docker application properties

### 2.3. (optional) remove files

- [Dockerfile](Dockerfile)

- [docker-compose.yml](docker-compose.yml)

## 3. build and run our project image using

  3.1. `mvn clean package`

```bash
mvn clean package
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.4-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
#  ...
# [INFO] Results:
# [INFO]
# [INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
# [INFO]
# [INFO]
# [INFO] --- maven-jar-plugin:3.2.0:jar (default-jar) @ prez-fabric8-dmp ---
# [INFO] Building jar: /../target/prez-fabric8-dmp-0.1.4-SNAPSHOT.jar
# [INFO]
# [INFO] --- spring-boot-maven-plugin:2.3.5.RELEASE:repackage (repackage) @ prez-fabric8-dmp ---
# [INFO] Replacing main artifact with repackaged archive
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  11.978 s
# [INFO] Finished at: 2020-10-07T12:06:18+01:00
# [INFO] ------------------------------------------------------------------------
```

  3.2. `mvn docker:build docker:start`

```bash
mvn docker:build docker:start
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.4-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- docker-maven-plugin:0.34.1:build (default-cli) @ prez-fabric8-dmp ---
# [INFO] Reading assembly descriptor: /../khool-jkube/src/main/docker/../assembly/docker-assembly.xml
# [INFO] Copying files to /../khool-jkube/target/docker/kanedafromparis/prez-fabric8-dmp/0.1.4-SNAPSHOT/build/maven
# [INFO] Building tar: /../khool-jkube/target/docker/kanedafromparis/prez-fabric8-dmp/0.1.4-SNAPSHOT/tmp/docker-build.tar
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT]: Created docker-build.tar in 695 milliseconds
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT]: Built image sha256:8c1ff
# [INFO]
# [INFO] --- docker-maven-plugin:0.34.1:start (default-cli) @ prez-fabric8-dmp ---
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT]: Start container a21ff9ba903c
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT]: Waiting on url http://192.168.99.131:8888 with method GET for status # 200..399.
# 2020-11-08T11:16:48.568Z Todo-VM settings:
# 2020-11-08T11:16:48.571Z Todo-    Max. Heap Size (Estimated): 986.00M
# 2020-11-08T11:16:48.571Z Todo-    Using VM: OpenJDK 64-Bit Server VM
# 2020-11-08T11:16:48.571Z Todo-
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT]: Waiting to become healthy
# 2020-11-08T11:16:49.461Z Todo-
# ...
# 2020-11-08T11:16:49.464Z Todo- :: Spring Boot ::        (v2.3.5.RELEASE)
# ...
# 2020-11-08T11:16:52.081Z Todo-2020-11-08 11:16:52.081  INFO 7 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat
# ...
# 2020-11-08T11:16:53.237Z Todo-2020-11-08 11:16:53.237  INFO 7 --- [           main] i.g.k.prez.fabric8.dmp.Application       : Started # Application in 4.177 seconds (JVM running for 4.72)
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.4-SNAPSHOT]: Waited on url http://192.168.99.131:8888 and on healthcheck # '"CMD-SHELL", "curl -f http://localhost:8080/ || exit 1"' 5194 ms
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  12.425 s
# [INFO] Finished at: 2020-11-08T12:16:53+01:00
# [INFO] ------------------------------------------------------------------------
```

## 4. Check project

### 4.1. Open a web browser to [http://192.168.99.100:8888](http://$(minikube -p khool-jkube-prez ip):8888)

## Next Step

Add mariadb instance into our application builded via io.fabric8:docker-maven-plugi
