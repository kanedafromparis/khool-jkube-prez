# 6 - Build the default application image using jKube and push it into kubernetes (h2 database)

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to create a docker image of our project and make it works with mariadb within the same docker network

## Sample To Do List web application using Spring Boot, Mariadb using docker-compose

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template, Mariadb, )

## 1. instantiate a local mariadb

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

## 2. Udpate and project files

### 2.1. udpate file

- [pom.xml](pom.xml) update version and add docker image definition from our project, to build it

- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

## 3. build and run our project image using

### 3.1. `mvn clean package`
  
### 3.2. `mvn k8s:build`

```bash
 mvn k8s:build
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.6-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:build (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Running in Kubernetes mode
# [INFO] k8s: Building Docker image in Kubernetes mode
# [INFO] k8s: Running generator spring-boot
# [INFO] k8s: spring-boot: Using Docker image quay.io/jkube/jkube-java-binary-s2i:0.0.8 as base / builder
# [INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Created docker-build.tar in 334 # milliseconds
# [INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Built image sha256:f1450
# [INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Removed old image sha256:836ce
# [INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Tag with latest
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  4.862 s
# [INFO] Finished at: 2020-09-02T22:55:54+01:00
# [INFO] ------------------------------------------------------------------------
```

### 3.2.1 (optional) `mvn k8s:push`

### 3.3 `mvn k8s:resource`

```bash
mvn k8s:resource
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.6-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:resource (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Running generator spring-boot
# [INFO] k8s: spring-boot: Using Docker image quay.io/jkube/jkube-java-binary-s2i:0.0.8 as base / builder
# [INFO] k8s: Using resource templates from /../khool-jkube/src/main/jkube
# [INFO] k8s: jkube-controller: Adding a default Deployment
# [INFO] k8s: jkube-service: Adding a default service 'prez-fabric8-dmp' with ports [8080]
# [INFO] k8s: jkube-revision-history: Adding revision history limit to 2
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  2.422 s
# [INFO] Finished at: 2020-11-01T22:56:08+01:00
# [INFO] ------------------------------------------------------------------------
```

### 3.4 `mvn k8s:apply`

```bash
mvn k8s:apply
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.6-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:apply (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Using Kubernetes at https://192.168.99.131:8443/ in namespace default with manifest /../khool-jkube/target/classes/META-INF/jkube/# kubernetes.yml
# [INFO] k8s: Using namespace: default
# [INFO] k8s: Updating Service from kubernetes.yml
# [INFO] k8s: Updated Service: target/jkube/applyJson/default/service-prez-fabric8-dmp.json
# [INFO] k8s: Updating Deployment from kubernetes.yml
# [INFO] k8s: Updated Deployment: target/jkube/applyJson/default/deployment-prez-fabric8-dmp.json
# [INFO] k8s: HINT: Use the command `kubectl get pods -w` to watch your pods start up
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  6.534 s
# [INFO] Finished at: 2020-11-01T22:56:19+01:00
# [INFO] ------------------------------------------------------------------------
```

## 4. Check project

### 4.1 Look at generate yaml files

- [deployment](target/classes/META-INF/jkube/kubernetes/prez-fabric8-dmp-deployment.yml)

- [service](target/classes/META-INF/jkube/kubernetes/prez-fabric8-dmp-service.yml)

- [concatened file](target/classes/META-INF/jkube/kubernetes.yml)

### 4.2 check kubernetes

```bash
kubectl get svc,deploy,po -o name
# NAME                       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
# service/kubernetes         ClusterIP   10.96.0.1       <none>        443/TCP    12d1h
# service/prez-fabric8-dmp   ClusterIP   10.99.211.129   <none>        8080/TCP   23m37s
#
# NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/prez-fabric8-dmp   1/1     1            1           25m37s
#
# NAME                                    READY   STATUS    RESTARTS   AGE
# pod/prez-fabric8-dmp-57fc6b7b97-b68kp   1/1     Running   0          2m36s
```

### 4.3 check you pod log

```bash
mvn k8s:log
# [INFO] Scanning for projects...
# ...
# [INFO] --- kubernetes-maven-plugin:1.0.2:log (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Using Kubernetes at https://192.168.99.131:8443/ in namespace default with manifest /../khool-jkube/target/classes/META-INF/jkube/kubernetes.yml
# ...
# [INFO] k8s: INFO exec  java -javaagent:/usr/share/java/jolokia-jvm-agent/jolokia-jvm.jar=config=/opt/jboss/container/jolokia/etc/jolokia.properties -javaagent:/usr/share/java/prometheus-jmx-exporter/jmx_prometheus_javaagent.jar=9779:/opt/jboss/container/prometheus/etc/jmx-exporter-config.yaml -XX:+UseParallelOldGC -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=20 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MaxMetaspaceSize=100m -XX:+ExitOnOutOfMemoryError -cp "." -jar /deployments/prez-fabric8-dmp-0.1.6-SNAPSHOT.jar
# ...
# [INFO] k8s: 2020-11-08 14:17:09.087  INFO 1 --- [           main] i.g.k.prez.fabric8.dmp.Application       : Started Application in 4.305 seconds (JVM running for 4.996)
```

### 4.4 map pod port to local host

```bash
kubectl port-forward $(kubectl get po -l app=prez-fabric8-dmp -o name) 8080:8080`
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
```

### 4.5. Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

### 4.6. Notice the specificity of the image

```bash
docker images | grep kanedafromparis/prez-fabric8-dmp
# kanedafromparis/prez-fabric8-dmp                        latest                  53c8affca500        16 minutes ago      550MB
```

## Next Step

Now let's build our image.
