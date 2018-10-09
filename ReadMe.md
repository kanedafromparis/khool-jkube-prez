# 1 - Initialization simple spring application 
## Introduction

This application is created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin)


## Sample To Do List web application using Spring Boot (and MySQL)

This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)


1. create basic project files

  1.1. create [pom.xml](pom.xml) for the project
    - add dependency


  1.2. create the Todo Entity :
    - [src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItem.java](src/main/fabric8/application-configmap.yaml)
    - [src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoListViewModel.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoListViewModel.java)
    - [src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepository.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepository.java)
    
  1.3. create the Application and its controller :
    - [src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/TodoController.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/TodoController.java)
    - [src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/Application.java](src/main/java/io/github/kanedafromparis/prez/fabric8/dmp/Application.java)

  1.4. create the ressource files (application.properties, index.html) :
    - [src/main/resources/application.properties}(src/main/resources/application.properties)
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html)

  1.4. create the application test(s) :
    - [src/test/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepositoryTest.java](src/test/java/io/github/kanedafromparis/prez/fabric8/dmp/todo/TodoItemRepositoryTest.java)

2. Build, Test and run 

  2.1. `mvn clean package`

  2.2. `mvn spring-boot:run`

  2.3. Open a web browser to [http://127.0.0.1:8080/](http://127.0.0.1:8080)

## Next Step
Create configuration for mysql and docker-compose to do so