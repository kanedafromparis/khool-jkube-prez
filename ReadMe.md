# 3 - Build a docker image from our projet and use mariadb with docker-compose
## Reminder

This application is created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin)

At this step we want to create a docker image of our project and make it works with mariadb within the same docker network


## Sample To Do List web application using Spring Boot, Mariadb using docker-compose

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template, Mariadb, )

1. instantiate a local mariadb

  1.1. (optional) 
`docker-machine create prez-fabric8-dmp`

  1.2. (optional) 
`eval $(docker-machine env prez-fabric8-dmp) && \`
`docker-machine ip prez-fabric8-dmp `

2. create basic project files

  2.1. update file :
    - [pom.xml](pom.xml) update version and dependency
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

  2.2. create project [Dockerfile](Dockerfile)

  2.3. create a application config file [src/main/resources/application.mariadb.compose.properties](application.properties)

  2.4. create project [docker-compose.yml](docker-compose.yml)

  2.5. `mvn clean package`
  
  2.6. `docker-compose build`

  2.7. `docker-compose up `

3. Check project 

   3.1. Open a web browser to [http://$(docker-machine ip prez-fabric8-dmp):8080](http://192.168.99.100:8080)

   3.2. check your database mouvement with
   `watch -n 2 bash showtables.sh`

## Next Step
Let's replace all this a dedicate maven-plugin