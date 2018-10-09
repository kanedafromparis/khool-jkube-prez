# 6 - Build the default application image using fabric8-maven-plugin and push it into kubernetes (h2 database)
## Reminder

This application is created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin) and [http://maven.fabric8.io/](fabric8io/fabric8-maven-plugin)

At this step we want to build the application image and run it into kubernetes

NB :  since I am using minikube : (`mvn`) `fabric8:push` won't be used

## Sample To Do List web application using Spring Boot (and Mariadb)

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template)

1. instantiate a local mariadb

  1.1. (optional) 
  `minikube start`

  1.2. (optional) 
  `minikube update-context && \`
  `minikube dashboard && \`
  `eval $(minikube docker-env)`

2. Udpate and project files

  2.1. udpate files :
    - [pom.xml](pom.xml) update version and clean docker image to our project, to switch to the default fmp version
    - [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

3. build and run our project image using

  3.1. `mvn clean package`
  
  3.2. `mvn fabric8:build fabric8:resource fabric8:deploy`
  
  3.3. (optional) `kubens prez-fabric8-dmp`

  3.4. bug in snapshot so manually edit to :latest 
  `kubectl -n prez-fabric8-dmp edit deployment.apps/prez-fabric8-dmp`
  
4. Check project 

   4.1 map pod port to local host
   `kubectl port-forward $(kubectl get po -l app=prez-fabric8-dmp -o name) 8080:8080`

   4.2. Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

   4.3. Notice the specificity of the image 
   `docker images | grep kanedafromparis/prez-fabric8-dmp`

   
## Next Step
Now let's build our image