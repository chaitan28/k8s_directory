
# Kubernetes Deployments Guide

### Deployments
Deployments are used by 99.99% of people to deploy their applications. They include ReplicaSets and Pods.
### Features of Deployments
- Rolling Updates: Perform updates to Pods in a controlled manner. <br>
- Rollback: Revert to previous versions in case of issues.  <br>
- Scaling: Adjust the number of Pod replicas.  <br>
- Self-healing: Automatically replace failed or unhealthy Pods.  <br>

### DaemonSets
DaemonSets ensure that a pod is run on each node in the cluster. This is typically used for log collection and monitoring.

### StatefulSets
StatefulSets maintain the identity of pods, ensuring the hostname remains the same, which is crucial for stateful applications like MongoDB and MySQL.

## Commands Used

### Creating a Deployment
```sh
kubectl create deployment testapp --image kiran2361993/kubegame:v1 --replicas 3 --dry-run -o yaml
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
### RollingUpdate in Deployment
- Rolling updates allow you to update your application without downtime by gradually replacing the old version of your Pods with new ones

### Strategy
```sh
kubectl explain deployment.spec.strategy
```
Under spec:
```yaml
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 0
      maxSurge: 1

```


