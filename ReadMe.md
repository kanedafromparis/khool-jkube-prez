# 4 - Build the image using io.fabric8:docker-maven-plugin:0.27.1
## Reminder

This application is created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin)

At this step we want to clean a little all the docker specific stuff and move things to a a better full maven way.


## Sample To Do List web application using Spring Boot (and Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

1. instantiate a local docker

  1.1. (optional) 
`docker-machine create prez-fabric8-dmp`

  1.2. (optional) 
`eval $(docker-machine env prez-fabric8-dmp) && \`
`docker-machine ip prez-fabric8-dmp `

2. Udpates and project files

  2.1. udpate files :
    - [pom.xml](pom.xml) in order to set io.fabric8:docker-maven-plugin configuration for our application docker image
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

    
  2.1. create files :
    - [src/main/docker/](src/main/docker/.forgit) this directory is needed by the plugin and can be use for an overide Dockerfile
    - [src/main/assembly/docker-assembly.xml](src/main/assembly/docker-assembly.xml) maven assembly script use to build docker image
    - [src/main/conf/application.properties](src/main/conf/application.properties) docker application properties
    
  2.3. (optional) remove [Dockerfile](Dockerfile) & [docker-compose.yml](docker-compose.yml)

3. build and run our project image using

  3.1. `mvn clean package`
  
  3.2. `mvn docker:build docker:start`
  
4. Check project 

   4.1. Open a web browser to [http://192.168.99.100:8888](http://$(docker-machine ip prez-fabric8-dmp):8888)

## Next Step
Add mariadb instance into our application builded via io.fabric8:docker-maven-plugin