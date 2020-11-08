# 0 - Welcom

## Introduction

This application was created in order to introduce [fabric8io/docker-maven-plugin](https://dmp.fabric8.io/) and [fabric8io/fabric8-maven-plugin](http://maven.fabric8.io/). It has been update to [Eclipse jkube](https://www.eclipse.org/jkube/docs/kubernetes-maven-plugin).

This is a step by step project toward automation build code from local to Kubernetes.

## Checkout

`git clone https://github.com/kanedafromparis/khool-jkube-prez`

`git branch` to see the steps

git checkout `010-Initialization` to start

## Plan

### 1 - Initialization simple spring in memory

### 2 - Use mariadb via a docker instance

### 3 - Build a docker image from our projet and use mariadb with docker-compose

### 4 - Build the application image using io.fabric8:docker-maven-plugin

### 5 - Build the application image and mariadb docker instance using io.fabric8:docker-maven-plugin

### 6 - Build the application image and push it into kubernetes (h2 database)

### 7 - Build the specific application image and push it into kubernetes (h2 database)

### 8 - Build the specific application image and push it into kubernetes and push it into kubernetes with other resources
