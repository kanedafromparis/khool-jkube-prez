# 5 - Build the application image and mariadb docker instance using io.fabric8:docker-maven-plugin:0.27.1
## Reminder

This application is created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin)

At this step we want to add a database via docker


## Sample To Do List web application using Spring Boot (and Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

1. instantiate a local docker

  1.1. (optional) 
`docker-machine create prez-fabric8-dmp`

  1.2. (optional) 
`docker-machine start prez-fabric8-dmp && \`
`eval $(docker-machine env prez-fabric8-dmp) && \`
`docker-machine ip prez-fabric8-dmp `

2. Udpate and project files

  2.1. update file :
    - [pom.xml](pom.xml) update version and dependency and add mariadb docker image to our project
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

3. build and run our project image using

  3.1. `mvn clean package`
  
  3.2. `mvn docker:build docker:start`
  
4. Check project 

   4.1. Open a web browser to [http://192.168.99.100:8888](http://$(docker-machine ip prez-fabric8-dmp):8080)
   
   4.2. check you database mouvement with
    `watch -n 2 bash src/main/bash/showtables.sh`
   
   
## Next Step
Now let's move to kubernetes