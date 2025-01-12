

# Advanced Kubernetes Scheduling
-  In Kubernetes, the feasible score is part of the scheduling process. When a Pod needs to be scheduled, the kube-scheduler first  identifies a set of Nodes that meet the Pod's scheduling requirements. These Nodes are called feasible Nodes 
```sh
feasible score = memory of node x cpu of node
example:  workernode consists of 4 cpu and 16 gb of memory.
          Feasible score = 4 x 16 = 64
```


## Topics Covered

### 1. Node Selector

**Node Selector** is a simple way to ensure that your pods run on specific nodes by assigning labels. This is useful when you have nodes with special hardware or software configurations and you want certain workloads to run only on those nodes.

- **Example Use Case:** Targeting a node with high-performance CPUs for compute-intensive tasks.

```sh
# Label a node with a custom label
kubectl label node <node-name> high-perf-cpu=yes
kubectl describe node <node-name> | grep -i high-perf-cpu
# Deploy a pod targeting the node with the specified label
kubectl apply -f <your-deployment-file>.yaml

```

### 2. Node Affinity

**Node Affinity** allows more complex scheduling decisions based on node labels. Unlike Node Selector, Node Affinity supports multiple label expressions and can differentiate between preferred and required conditions.
- In Kubernetes, required-hard and preferred-soft are concepts used in pod scheduling to specify node affinities. 
     1. **requiredDuringSchedulingIgnoredDuringExecution (Required-Hard)**
- Specifies rules that must be met for the scheduler to assign the pod to a node. If these rules are not satisfied, the pod will not be scheduled.
```sh
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: disktype
          operator: In
          values:
          - ssd
```
- The pod will only schedule on nodes labeled with disktype=ssd. If no such node exists, the pod will remain unscheduled.

    2. **preferredDuringSchedulingIgnoredDuringExecution (Preferred-Soft)**
- Specifies rules that the scheduler tries to follow but does not strictly enforce. If no nodes meet the criteria, the pod can still be scheduled on other nodes.
```sh
affinity:
  nodeAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 1
      preference:
        matchExpressions:
        - key: region
          operator: In
          values:
       - us-west-1
```
- The scheduler will prefer nodes labeled region=us-west-1 but will not block the pod from being scheduled elsewhere.

```sh
# Label nodes with different environment labels
kubectl label node <node1-id> env=one
kubectl label node <node2-id> env=two


# Deploy a workload with Node Affinity rules
kubectl apply -f <your-deployment-file>.yml

# Scale the deployment to observe how pods are distributed
kubectl scale deployment <deployment-name> --replicas=8
```


### 3. Taints & Tolerations

**Taints** are applied to nodes to prevent pods that don't tolerate the taint from being scheduled on them. **Tolerations** are applied to pods to allow them to be scheduled on tainted nodes. This feature is essential for keeping certain workloads separate or ensuring critical workloads are not disrupted.

- **Example Use Case:** Ensuring that only specific pods can run on a node reserved for special tasks.

```sh
# Taint nodes to control scheduling
kubectl taint node <node-id> high-cpu=yes:NoSchedule
kubectl taint node <node-id> med-cpu=yes:NoExecute

# Describe the node to see its taints
kubectl describe node <node-id> | grep -i high

# Deploy a pod to see if it gets scheduled based on tolerations
kubectl apply -f <your-deployment-file>.yaml

# Remove taints from nodes if needed
kubectl taint node <node-id> high-cpu-
kubectl taint node <node-id> med-cpu-
```

### 4. Pod Affinity & Anti-Affinity

**Pod Affinity** allows you to schedule pods together on the same node, while **Pod Anti-Affinity** ensures that pods are placed on separate nodes. This is useful for reducing latency between pods or ensuring high availability by spreading pods across nodes.

- **Example Use Case:** Grouping frontend and backend pods together to reduce network latency or ensuring that replicas of the same service are spread out to avoid single points of failure.

```sh
# Use pod affinity or anti-affinity in your deployment YAML
kubectl apply -f <your-deployment-file>.yaml

# Scale the deployment and observe the behavior
kubectl scale deployment <deployment-name> --replicas=2

# Drain a node to see how pods are rescheduled
kubectl drain <node-id>
kubectl uncordon <node-id>
```

## Commands Overview

Here’s a summary of the key commands used for the topics covered:

```sh
# Label a node
kubectl label node <node-name> high-perf-cpu=yes

# Apply a deployment file
kubectl apply -f <your-deployment-file>.yaml

# Verify pod placement
kubectl get pods -o wide --no-headers | awk -F" " '{print $1, $8}'

# Label nodes for Node Affinity
kubectl label node <node1-id> env=one
kubectl label node <node2-id> env=two
kubectl label node <node3-id> env=three

# Scale a deployment
kubectl scale deployment <deployment-name> --replicas=8

# Taint nodes
kubectl taint node <node-id> high-cpu=yes:NoSchedule
kubectl taint node <node-id> med-cpu=yes:NoExecute

# Remove taints from nodes
kubectl taint node <node-id> high-cpu-
kubectl taint node <node-id> med-cpu-

# Drain and uncordon a node
kubectl drain <node-id>
kubectl uncordon <node-id>
```

## Conclusion

This repository provides practical examples and commands to help you understand and implement advanced scheduling techniques in Kubernetes. By mastering these concepts, you can ensure that your applications run efficiently and reliably in a Kubernetes environment.

---
