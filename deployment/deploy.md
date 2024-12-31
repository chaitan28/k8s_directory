


# Kubernetes Deployments Guide

### Deployments
Deployments are used by 99.99% of people to deploy their applications. They include ReplicaSets and Pods.

### DaemonSets
DaemonSets ensure that a pod is run on each node in the cluster. This is typically used for log collection and monitoring.

### StatefulSets
StatefulSets maintain the identity of pods, ensuring the hostname remains the same, which is crucial for stateful applications like MongoDB and MySQL.

## Commands Used

### Creating a Deployment
```sh
kubectl create deployment testapp --image kiran2361993/kubegame:v1 --replicas 3 --dry-run -o yaml
```

### Labels and Annotations
Labels are key-value pairs used to pass information.

#### Creating Pods
```sh
kubectl run testpod1 --image nginx:latest
```

### Deploying the Deployment
```sh
kubectl apply -f deployment.yaml
kubectl get pods
```

### Exposing the Deployment
```sh
kubectl expose deployment testapp --name sv1 --port 8000 --target-port 80 --type NodePort
```

### Strategy
```sh
kubectl explain deployment.spec.strategy
```
Under spec:
```yaml
strategy:
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0%
```


