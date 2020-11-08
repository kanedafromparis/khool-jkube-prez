# 8 - Build the default application and deploy the full project into kubernetes and with ingress (minikube version)

## Reminder

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/) it has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

At this step we want to create an OCI image of our project and deploy it with its deployment dependencies into kubernetes.
And create the ingress route for this service

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

### 1.2. (optional)

```bash
eval $(minikube -p khool-jkube-prez docker-env) && \
minikube -p khool-jkube-prez ip
```

### 1.3. (optional)

```bash
minikube -p khool-jkube-prez addons enable ingress
# 🔎  Verifying ingress addon...
# 🌟  The 'ingress' addon is enabled
minikube -p khool-jkube-prez addons enable ingress-dns
# 🌟  The 'ingress-dns' addon is enabled
```

For more set-up detail look in to the [project]( https://github.com/kubernetes/minikube/tree/master/deploy/addons/ingress-dns)


## 2. Udpate and project files

### 2.1. udpate files

- [pom.xml](pom.xml) update version from our project, to build it
  
- [src/main/resources/templates/index.html](src/main/resources/templates/index.html) update version

### 2.2. create kubernetes resource fragments

- [settings.xml](settings.xml) to store some of our properties and secrets
  
- [application-ingress.yaml](/src/main/jkube/application-ingress.yaml) to define the ingress resoucres


## 3. build and run our project image using

  3.1. `mvn clean package`
  
  3.2. `mvn k8s:build`

```bash
mvn -s settings.xml k8s:build -Djkube.namespace=prez-fabric8-dmp
```

  3.2.1 (optional) `mvn k8s:push`

  3.3 `mvn k8s:resource`

```bash
mvn -s settings.xml k8s:resource -Djkube.namespace=prez-fabric8-dmp
```

  3.4 `mvn k8s:apply`

```bash
mvn -s settings.xml k8s:apply -Djkube.namespace=prez-fabric8-dmp
```

## 4. Check project

### 4.1 Check pod deployment

```bash
watch -n 2 kubectl get svc,deploy,po -o name -n prez-fabric8-dmp
```

### 4.4 check on local NodePort

```bash
kubectl get ingress -n prez-fabric8-dmp
# NAME               CLASS    HOSTS                   ADDRESS          PORTS   AGE
# prez-fabric8-dmp   <none>   prez-fabric8-dmp.test   192.168.99.131   80      15s
open http://$(kubectl get ingress -n prez-fabric8-dmp  prez-fabric8-dmp -o json | jq -r .spec.rules[]?.host)
```

## Next Step

Do it yourself and share it with others

