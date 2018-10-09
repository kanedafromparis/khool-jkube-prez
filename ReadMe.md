# 2 - Use mariadb via a docker instance
## Reminder

This application is created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin)

At this step we want to add a database via docker


## Sample To Do List web application using Spring Boot (and Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

1. instantiate a local mariadb

  1.1. (optional) 
`docker-machine create prez-fabric8-dmp`

  1.2. (optional) 
`eval $(docker-machine env prez-fabric8-dmp) && \`
`docker-machine ip prez-fabric8-dmp`

>  1.3. `docker run --name todo-mariadb \`
`  -e MYSQL_USER=springuser \`
`  -e MYSQL_PASSWORD=mypassword-quoor-uHoe7z \`
`  -e MYSQL_DATABASE=db_todo \`
`  -e MYSQL_ROOT_PASSWORD=r00t-aeKie8ahWai_ \`
`  -p 3306:3306 \`   
`  -d mariadb:10.3.10`

2. create basic project files

  2.1. update file :
    - [pom.xml](pom.xml) update version and dependency
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

  2.2. create [src/main/resources/application.mariadb.properties](src/main/resources/application.mariadb.properties) with correct docker ip

  2.3. `mvn clean package`

  2.4. `mvn spring-boot:run -Dspring.config.location=$(pwd)/src/main/resources/application.mariadb.properties`

3. Check project 

   3.1. Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

   3.2. check you database mouvement with
`watch -n 2 bash src/main/bash/showtables.sh`

## Next Step
Create a docker image and a docker-compose