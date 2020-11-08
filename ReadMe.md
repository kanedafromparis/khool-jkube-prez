# 1 - Initialization simple spring application

## Introduction

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).
At this step we want to simply have a look to the spring boot project.

## Sample To Do List web application using Spring Boot (and MySQL)

This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

### 1. create basic project files

#### 1.1. create [pom.xml](pom.xml) for the project

- add dependency

#### 1.2. create the Todo Entity :

- [src/main/java/.../todo/TodoItem.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItem.java)

- [src/main/java/.../todo/TodoListViewModel.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoListViewModel.java)

- [src/main/java/.../todo/TodoItemRepository.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepository.java)

#### 1.3. create the Application and its controller :

- [src/main/java/.../TodoController.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/TodoController.java)

- [src/main/java/.../Application.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/Application.java)

#### 1.4. create the ressource files (application.properties, index.html) :

- [src/main/resources/application.properties}(src/main/resources/application.properties)

- [src/main/resources/templates/index.html](src/main/resources/templates/index.html)

#### 1.5. create the application test(s) :

- [src/test/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepositoryTest.java](src/test/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepositoryTest.java)

### 2. Build, Test and run

#### 2.1. `mvn clean package`

```bash
mvn clean package
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.1-SNAPSHOT
# ...
# [INFO] Results:
# [INFO]
# [INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
# [INFO]
# [INFO]
# [INFO] --- maven-jar-plugin:3.2.0:jar (default-jar) @ prez-fabric8-dmp ---
# [INFO] Building jar: /../khool-jkube/target/prez-fabric8-dmp-0.1.1-SNAPSHOT.jar
# [INFO]
# [INFO] --- spring-boot-maven-plugin:2.3.5.RELEASE:repackage (repackage) @ prez-fabric8-dmp ---
# [INFO] Replacing main artifact with repackaged archive
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  11.740 s
# [INFO] Finished at: 2020-11-08T13:59:43+01:00
# [INFO] ------------------------------------------------------------------------
```

#### 2.2. `mvn spring-boot:run`

#### 2.3. Open a web browser to [http://127.0.0.1:8080/](http://127.0.0.1:8080)

## Next Step

In order to improve integration we will start a container instacne of mariadb
