# 0 - Welcom
## Introduction

This application was created in order to introduce [https://dmp.fabric8.io/](fabric8io/docker-maven-plugin) and [http://maven.fabric8.io/](fabric8io/fabric8-maven-plugin) it has been update to [jkube/docs/kubernetes-maven-plugin](Eclispe jkube) 

## Checkout

`git clone https://github.com/kanedafromparis/prez-fabric8-dmp.git`

`git branch` to see the steps 

git checkout `010-Initialization` to start

## Plan
### 1 - Initialization simple spring in memory
### 2 - Use mariadb via a docker instance
### 3 - Build a docker image from our projet and use mariadb with docker-compose
### 4 - Build the application image using io.fabric8:docker-maven-plugin:0.27.1
### 5 - Build the application image and mariadb docker instance using io.fabric8:docker-maven-plugin:0.27.1
### 6 - Build the application image and push it into kubernetes (h2 database)
### 7 - Build the specific application image and push it into kubernetes (h2 database)
### 8 - Build the specific application image and push it into kubernetes with a configmap configuration and a mariadb database
