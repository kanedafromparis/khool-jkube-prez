# 7.5 - Build the default application image using fabric8-maven-plugin with more flexibility and push it into kubernetes (h2 database)

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to specific docker image of our project and make it run into kubernetes.

## Sample To Do List web application using Spring Boot, Mariadb using docker-compose

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template, Mariadb, )

## 1. Set up Docker env

### 1.1. (optional)

```bash
minikube -p khool-jkube-prez start
# 😄  [khool-jkube-prez] minikube v1.14.2 on Darwin 10.15.7
# ...
# 🏄  Done! kubectl is now configured to use "khool-jkube-prez" by default
```

The first start need to retreive and setup the environement so i might take some time. From 2 to 15 min, depending on your configuration and your network.

### 1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

## 2. Udpate and project files

### 2.1. udpate files

- [pom.xml](pom.xml) update version and add docker image definition from our project, to build it
  
- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

### 2.2. delete the Dockerfile

## 3. build and run our project image using

### 3.1. `mvn clean package`
  
### 3.2. `mvn k8s:build`

```bash
mvn k8s:build
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.7-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:build (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Running in Kubernetes mode
# [INFO] k8s: Building Docker image in Kubernetes mode
# [INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest]: Created docker-build.tar in 3 seconds
# [INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest]: Built image sha256:b1120
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  19.377 s
# [INFO] Finished at: 2020-08-03T00:07:26+01:00
# [INFO] ------------------------------------------------------------------------
```

You can check it for fun

```bash
docker images | grep kaneda
# kanedafromparis/prez-fabric8-dmp                        0.1.7.5-SNAPSHOT        223eb066debb        15 seconds ago      247MB
```

### 3.2.1 (optional) `mvn k8s:push`

### 3.3 `mvn k8s:resource`

```bash
mvn k8s:resource k8s:deploy
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.7.5-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:resource (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Using resource templates from /../khool-jkube/src/main/jkube
# [INFO] k8s: jkube-controller: Adding a default Deployment
# [INFO] k8s: jkube-healthcheck-docker: Adding readiness probe, with period 120 seconds
# [INFO] k8s: jkube-healthcheck-docker: Adding liveness probe, with period 120 seconds
# [INFO] k8s: jkube-revision-history: Adding revision history limit to 2
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  2.371 s
# [INFO] Finished at: 2020-11-08T17:09:52+01:00
# [INFO] ------------------------------------------------------------------------
```

### 3.4 `mvn k8s:deploy`

```bash
mvn k8s:watch
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.7-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] >>> kubernetes-maven-plugin:1.0.2:deploy (default-cli) > install @ prez-fabric8-dmp >>>
# [INFO]
# [INFO] --- maven-resources-plugin:3.1.0:resources (default-resources) @ prez-fabric8-dmp ---
# [INFO] Using 'UTF-8' encoding to copy filtered resources.
# [INFO] Copying 2 resources
# [INFO] Copying 1 resource
# [INFO]
# [INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ prez-fabric8-dmp ---
# 
# [INFO] --- maven-resources-plugin:3.1.0:testResources (default-testResources) @ prez-fabric8-dmp ---
# ...
# [INFO] --- maven-compiler-plugin:3.8.1:testCompile (default-testCompile) @ prez-fabric8-dmp ---
# [INFO] Nothing to compile - all classes are up to date
# [INFO]
# [INFO] --- maven-surefire-plugin:2.22.2:test (default-test) @ prez-fabric8-dmp ---
# [INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
# ...
# [INFO] --- maven-jar-plugin:3.2.0:jar (default-jar) @ prez-fabric8-dmp ---
# [INFO] Building jar: //../khool-jkube/target/prez-fabric8-dmp-0.1.7-SNAPSHOT.jar
# [INFO]
# [INFO] --- spring-boot-maven-plugin:2.3.5.RELEASE:repackage (repackage) @ prez-fabric8-dmp ---
# ...
# [INFO] <<< kubernetes-maven-plugin:1.0.2:deploy (default-cli) < install @ prez-fabric8-dmp <<<
# [INFO]
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:deploy (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Using Kubernetes at https://192.168.99.131:8443/ in namespace prez-fabric8-dmp with manifest /../khool-jkube/target/classes/META-INF/jkube/# kubernetes.yml
# [INFO] k8s: Updating Deployment from kubernetes.yml
# [INFO] k8s: Updated Deployment: target/jkube/applyJson/prez-fabric8-dmp/deployment-prez-fabric8-dmp-1.# json
# [INFO] k8s: HINT: Use the command `kubectl get pods -w` to watch your pods start up
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  12.018 s
# [INFO] Finished at: 2020-11-06T00:19:19+01:00
# [INFO] ------------------------------------------------------------------------
```

## 4. Check project

### 4.1 check pods

```bash 
kubectl get pods -w -n prez-fabric8-dmp
# NAME                                READY   STATUS    RESTARTS   AGE
# prez-fabric8-dmp-86d5dd44f4-rms5q   1/1     Running   0          19s
```

### 4.1 map pod port to local host

```bash
kubectl -n prez-fabric8-dmp port-forward $(kubectl get po -l app=prez-fabric8-dmp -n prez-fabric8-dmp -o name) 8080:8080
# Forwarding from 127.0.0.1:8080 -> 8080
# Forwarding from [::1]:8080 -> 8080
# Handling connection for 8080
```

### 4.2. Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

### 4.3. Notice the specificity of the image

```bash
docker images | grep kanedafromparis/prez-fabric8-dmp
# kanedafromparis/prez-fabric8-dmp                        latest                  6e4290c2679f        3 minutes ago       288MB
```

## Next Step

Now let's build our image.
