# 8 - Build the default application and deploy the full project into kubernetes and helm

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to create an OCI image of our project and deploy it with its deployment dependencies into kubernetes.
We also will create a helm project

## Sample To Do List web application using Spring Boot, Mariadb into kubernetes and helm

### This is a simple Todo list application using Spring Boot (Spring JPA, Thymeleaf template, Mariadb )

## 1. Set up minikub env

### 1.1. (optional)

```bash
minikube -p khool-jkube-prez start
# 😄  [khool-jkube-prez] minikube v1.14.2 on Darwin 10.15.7
# ...
# 🏄  Done! kubectl is now configured to use "khool-jkube-prez" by default
```

The first start need to retreive and setup the environement so i might take some time. From 2 to 15 min, depending on your configuration and your network.

#### 1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

## 2. Udpate and project files

### 2.1. udpate files

- [pom.xml](pom.xml) update version from our project, to build it
  
- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

### 2.2. create kubernetes resource fragments

- [settings.xml](settings.xml) to store some of our properties and secrets
  
- [application-secret.yaml](/src/main/jkube/application-secret.yaml) for storing secrets

- [application-configmap.yaml](/src/main/jkube/application-configmap.yaml) for storing config informations

- [mariadb-service.yml](/src/main/jkube/mariadb-service.yml) to setup mariadb service

- [mariadb-statefulset.yml](/src/main/jkube/mariadb-statefulset.yml) to create mariadb statefullset

- [mariadb-statefulset.yml](/src/main/jkube/mariadb-statefulset.yml) to create mariadb statefullset

- [prez-fabric8-dmp-service.yaml](/src/main/jkube/prez-fabric8-dmp-service.yaml) to add custom info to our application service (ex : nodePort)

- [prez-fabric8-dmp-deployment.yml](/src/main/jkube/prez-fabric8-dmp-deployment.yml) to add custom info to our application deployement (ex : nb replicats)

- [application-configmap.yaml](application-configmap.yaml)for storing config informations

## 3. build and run our project image using

  3.1. `mvn clean package`
  
  3.2. `mvn k8s:build`

```bash
mvn -s settings.xml k8s:build -Djkube.namespace=prez-fabric8-dmp
[INFO] Scanning for projects...
[INFO]
[INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
[INFO] Building prez-fabric8-dmp 0.1.8-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- kubernetes-maven-plugin:1.0.2:build (default-cli) @ prez-fabric8-dmp ---
[INFO] k8s: Running in Kubernetes mode
[INFO] k8s: Building Docker image in Kubernetes mode
[INFO] k8s: Running generator spring-boot
[INFO] k8s: spring-boot: Using Docker image quay.io/jkube/jkube-java-binary-s2i:0.0.8 as base / builder
[INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Created docker-build.tar in 1 second
[INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Built image sha256:b24b0
[INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Removed old image sha256:33788
[INFO] k8s: [kanedafromparis/prez-fabric8-dmp:latest] "spring-boot": Tag with latest
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  9.599 s
[INFO] Finished at: 2020-11-08T17:59:29+01:00
[INFO] ------------------------------------------------------------------------
```

  3.2.1 (optional) `mvn k8s:push`

  3.3 `mvn k8s:resource`

```bash
mvn -s settings.xml k8s:resource -Djkube.namespace=prez-fabric8-dmp
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.7-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:resource (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Using resource templates from /Users/csabourdin/Documents/projets/personnel/projets/khool/# khool-jkube/src/main/jkube
# [INFO] k8s: jkube-controller: Adding a default Deployment
# [INFO] k8s: jkube-namespace: Adding a default Namespace: prez-fabric8-dmp
# [INFO] k8s: jkube-revision-history: Adding revision history limit to 2
# [INFO] ------------------------------------------------------------------------
```

  3.4 `mvn k8s:apply`

```bash
mvn -s settings.xml k8s:apply -Djkube.namespace=prez-fabric8-dmp
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.8-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:apply (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Using Kubernetes at https://192.168.99.131:8443/ in namespace prez-fabric8-dmp with manifest /../khool-jkube/target/classes/META-INF/jkube/kubernetes.yml
# [INFO] k8s: Using namespace: prez-fabric8-dmp
# [INFO] k8s: Using namespace: prez-fabric8-dmp
# [INFO] k8s: Updating Secret from kubernetes.yml
# [INFO] k8s: Updated Secret: target/jkube/applyJson/prez-fabric8-dmp/secret-spring-app.json
# [INFO] k8s: Creating a Service from kubernetes.yml namespace prez-fabric8-dmp name mariadb
# [INFO] k8s: Created Service: target/jkube/applyJson/prez-fabric8-dmp/service-mariadb.json
# [INFO] k8s: Creating a Service from kubernetes.yml namespace prez-fabric8-dmp name prez-fabric8-dmp
# [INFO] k8s: Created Service: target/jkube/applyJson/prez-fabric8-dmp/service-prez-fabric8-dmp.json
# [INFO] k8s: Updating ConfigMap from kubernetes.yml
# [INFO] k8s: Updated ConfigMap: target/jkube/applyJson/prez-fabric8-dmp/configmap-spring-app.json
# [INFO] k8s: Creating a Deployment from kubernetes.yml namespace prez-fabric8-dmp name prez-fabric8-dmp
# [INFO] k8s: Created Deployment: target/jkube/applyJson/prez-fabric8-dmp/deployment-prez-fabric8-dmp-1.json
# [INFO] k8s: Creating a StatefulSet from kubernetes.yml namespace prez-fabric8-dmp name mariadb
# [INFO] k8s: Created StatefulSet: target/jkube/applyJson/prez-fabric8-dmp/statefulset-mariadb.json
# [INFO] k8s: HINT: Use the command `kubectl get pods -w` to watch your pods start up
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  2.607 s
# [INFO] Finished at: 2020-11-08T18:00:51+01:00
# [INFO] ------------------------------------------------------------------------
```

## 4. Check project

### 4.1 Check pod deployment

```bash
watch -n 2 kubectl get svc,deploy,po -o name -n prez-fabric8-dmp
```

### 4.2 Map

```bash
kubectl -n prez-fabric8-dmp port-forward $(kubectl get svc -l app=prez-fabric8-dmp -n prez-fabric8-dmp -o name) 8080:8080`
```

### 4.3 check on local

Open a web browser to [http://127.0.0.1:8080](http://127.0.0.1:8080)

### 4.4 check on local NodePort

```bash
open "http://$(minikube -p khool-jkube-prez ip):$(kubectl -n prez-fabric8-dmp get svc prez-fabric8-dmp -o json | jq .spec.ports[]?.nodePort)"
```

### 4.5 create Helm Chart

```bash
mvn -s settings.xml k8s:helm  -Djkube.namespace=prez-fabric8-dmp
# [INFO] Scanning for projects...
# [INFO]
# [INFO] -------------< io.github.kanedafromparis:prez-fabric8-dmp >-------------
# [INFO] Building prez-fabric8-dmp 0.1.8-SNAPSHOT
# [INFO] --------------------------------[ jar ]---------------------------------
# [INFO]
# [INFO] --- kubernetes-maven-plugin:1.0.2:helm (default-cli) @ prez-fabric8-dmp ---
# [INFO] k8s: Creating Helm Chart "prez-fabric8-dmp" for Kubernetes
# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time:  2.143 s
# [INFO] Finished at: 2020-11-08T18:20:55+01:00
# [INFO] ------------------------------------------------------------------------
```

## Next Step

Let's have fun and add ingress  ;-)
