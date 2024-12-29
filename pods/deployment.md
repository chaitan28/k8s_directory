
![DEPLOYMENT](deployment.jpg)

#  Overview on Pods, Deployments, Namespaces, Services, and Commands

## Overview

This repository provides an introduction to key Kubernetes concepts including Pods, Deployments, Namespaces, and Services. The examples and commands provided here will help you understand how to manage and deploy applications in a Kubernetes cluster using both imperative and declarative approaches.

## Contents

- [Pods](#pods)
- [Deployments](#deployments)
- [Namespaces](#namespaces)
- [Services](#services)
- [Commands](#commands)

## Pods
Pod is wrapper/shell on the container. Each pod contains one or more containers.

### Commands

- View available resources: `kubectl api-resources`
- Explain pod details: `kubectl explain pod`
- Explain pod specifications: `kubectl explain pod.spec.affinity`
- List pods: `kubectl get pods`
- List pods in a specific namespace: `kubectl get pods -n alpha`

## Deployments

Deployments manage the creation and scaling of ReplicaSets, ensuring your applications have the desired number of running instances.

### Types of Deployments

- **Imperative Format**: Using kubectl commands.
  ```sh
  kubectl run nginx -n dev --image=nginx --dry-run=client -o yaml
  ```

- **Declarative Format**: Using YAML files.

## Namespaces

Namespaces are used to divide cluster resources between multiple users. They are useful for scenarios where multiple teams (e.g., Alpha and Bravo teams) share the same cluster but require resource isolation.

### Commands

- Create a namespace:
  ```sh
  kubectl create ns dev
  kubectl create ns qa
  ```
- List API resources that are namespaced:
  ```sh
  kubectl api-resources --namespaced=true
  ```

## Services

Services provide stable IP addresses and DNS names to Pods. They allow you to expose your applications within or outside the cluster.

### Commands

- Expose a pod as a service:
  ```sh
  kubectl expose pod nginx --port=8000 --target-port=80 --type=NodePort
  ```
- Describe a service:
  ```sh
  kubectl describe svc dev
  ```

## Commands

Here's a quick reference for common commands used in this tutorial:

- Create namespaces:
  ```sh
  kubectl create ns dev
  kubectl create ns qa
  ```
- Create a deployment:
  ```sh
  kubectl run nginx -n dev --image=nginx--dry-run=client -o yaml
  ```
- View available resources:
  ```sh
  kubectl api-resources
  ```
- Explain resources:
  ```sh
  kubectl explain pod
  kubectl explain pod.spec.affinity
  ```
- List pods:
  ```sh
  kubectl get pods
  kubectl get pods -n alpha
  ```
- Expose a pod:
  ```sh
  kubectl expose pod nginx --port=8000 --target-port=80 --type=NodePort
  ```
- Describe a service:
  ```sh
  kubectl describe svc nginx
  ``