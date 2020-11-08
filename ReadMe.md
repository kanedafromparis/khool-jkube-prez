# 5 - Build the application image and mariadb docker instance using io.fabric8:docker-maven-plugin

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).
At this step we want to create a docker image of our project and make it works with mariadb within the same docker network

## Sample To Do List web application using Spring Boot (and Mariadb)

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

## 2. Udpates and project files

  2.1. udpate files :

- [pom.xml](pom.xml) in order to set io.fabric8:docker-maven-plugin configuration that will add a mysql image to our application docker image, and activate to mariadb srping profile

- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

  2.1. create files :

- [src/main/resources/application-mariadb.properties](src/main/resources/application-mariadb.properties) with maria db docker application properties

- [setting.xml] with values used by the maria db docker instance

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
mvn -s settings.xml docker:build docker:start
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.5-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- docker-maven-plugin:0.34.1:build (default-cli) @ prez-fabric8-dmp ---
# [INFO] Reading assembly descriptor: /../khool-jkube/src/main/docker/../assembly/docker-assembly.xml
# [INFO] Copying files to /../khool-jkube/target/docker/kanedafromparis/prez-fabric8-dmp/0.1.5-SNAPSHOT/build/maven
# [INFO] Building tar: /../khool-jkube/target/docker/kanedafromparis/prez-fabric8-dmp/0.1.5-SNAPSHOT/tmp/docker-build.tar
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Created docker-build.tar in 873 milliseconds
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Built image sha256:2063a
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Removed old image sha256:3805e
# [INFO]
# [INFO] --- docker-maven-plugin:0.34.1:start (default-cli) @ prez-fabric8-dmp ---
# [INFO] DOCKER> [mariadb:10.3.10] "mariadb": Start container 956f8319e2bb
# 2020-11-08T12:12:56.363Z mariadb-Initializing database
# ...
# 2020-11-08T12:12:58.936Z mariadb-Version: '10.3.10-MariaDB-1:10.3.10+maria~bionic'  socket: '/var/run/mysqld/mysqld.sock'  port: 0  # mariadb.org binary distribution
# [INFO] DOCKER> [mariadb:10.3.10] "mariadb": Waited on log out 'mysqld: ready for connections.' 3081 ms
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Start container f7482ef34120
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Waiting on url http://192.168.99.131:8888 with method GET for status # 200..399.
# 2020-11-08T12:12:59.627Z Todo-VM settings:
# 2020-11-08T12:12:59.629Z Todo-    Max. Heap Size (Estimated): 986.00M
# 2020-11-08T12:12:59.629Z Todo-    Using VM: OpenJDK 64-Bit Server VM
# 2020-11-08T12:12:59.629Z Todo-
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Waiting to become healthy
# ...
# [INFO] DOCKER> [kanedafromparis/prez-fabric8-dmp:0.1.5-SNAPSHOT]: Waited on url http://192.168.99.131:8888 and on healthcheck # '"CMD-SHELL", "curl -f http://localhost:8080/ || exit 1"' 7096 ms
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  19.782 s
# [INFO] Finished at: 2020-11-08T13:13:06+01:00
# [INFO] ------------------------------------------------------------------------
```

## 4. Check project

   4.1. Open a web browser to [http://192.168.99.100:8888](http://$(minikube -p khool-jkube-prez ip):8888)

   4.2  watch the mariadb database : `watch -n 2 bash src/main/bash/showtables.sh`

## Next Step

Now let's move to Kubernetes with Jkube...
