
# Kubernetes Deployments Guide

### Deployments
Deployments are used by 99.99% of people to deploy their applications. They include ReplicaSets and Pods.
### Features of Deployments
- Rolling Updates: Perform updates to Pods in a controlled manner. <br>
- Rollback: Revert to previous versions in case of issues.  <br>
- Scaling: Adjust the number of Pod replicas.  <br>
- Self-healing: Automatically replace failed or unhealthy Pods.  <br>

### DaemonSets
DaemonSets ensure that a pod is run on each node in the cluster. This is typically used for log collection and monitoring. <br>

### StatefulSets
StatefulSets maintain the identity of pods, ensuring the hostname remains the same, which is crucial for stateful applications like MongoDB and MySQL.

## Commands Used

### Creating a Deployment
```sh
kubectl create deployment testapp --image kiran2361993/kubegame:v1 --replicas 6 --dry-run -o yaml
```

### Deploying the Deployment
```sh
kubectl apply -f deployment.yaml
kubectl get pods
```
### Login into the pod
```sh
kubectl exec -it <pod-name> -- /bin/bash

```
### Exposing the Deployment
```sh
kubectl expose deployment testapp --name sv1 --port 80 --target-port 80 --type NodePort
```
### RollingUpdate in Deployment
- RollingUpdate Replace the old ReplicaSets by new one using rolling update i.e gradually scale down the old ReplicaSets and scale up the new one.

### Strategy
```sh
kubectl explain deployment.spec.strategy.rollingUpdate
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
  ### maxSurge      
    The maximum number of pods that can be scheduled above the desired number of
    pods. Value can be an absolute number (ex: 5) or a percentage of desired
    pods (ex: 10%). This can not be 0 if MaxUnavailable is 0. Absolute number is
    calculated from percentage by rounding up. Defaults to 25%. Example: when
    this is set to 30%, the new ReplicaSet can be scaled up immediately when the
    rolling update starts, such that the total number of old and new pods do not
    exceed 130% of desired pods. Once old pods have been killed, new ReplicaSet
    can be scaled up further, ensuring that total number of pods running at any
    time during the update is at most 130% of desired pods.

  ### maxUnavailable    
    The maximum number of pods that can be unavailable during the update. Value
    can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
    Absolute number is calculated from percentage by rounding down. This cannot
    be 0 if MaxSurge is 0. Defaults to 25%. Example: when this is set to 30%,
    the old ReplicaSet can be scaled down to 70% of desired pods immediately
    when the rolling update starts. Once new pods are ready, old ReplicaSet can
    be scaled down further, followed by scaling up the new ReplicaSet, ensuring
    that the total number of pods available at all times during the update is at
    least 70% of desired pods.

### Rollout commands
```sh
kubectl rollout status deployment/<deployment-name>
Example: kubectl rollout status deployment/testapp
```

```sh
kubectl rollout history deployment/<deployment-name>
Example: kubectl rollout history deployment/testapp
```

```sh
kubectl rollout undo deployment/<deployment-name>
Example: kubectl rollout undo deployment/testapp   #rollout to previous version
```

```sh
kubectl rollout history deployment/<deployment-name>
Example: kubectl rollout history deployment/testapp
kubectl rollout undo deployment/<deployment-name> --to-revision=<revision>     #rollout to specific revision 
kubectl rollout undo deployment/testapp --to-revision=1
```

