#  StatefulSets in Kubernetes

## What is a StatefulSet?

A **StatefulSet** is a Kubernetes controller used to manage **stateful applications**. Unlike Deployments, StatefulSets maintain a unique identity for each pod, which is useful for applications that require:

- Stable network identity
- Persistent storage
- Ordered deployment and scaling

---

##  Key Features

- **Stable pod names**: Pods get persistent names like `pod-0`, `pod-1`, etc.
- **Stable storage**: Each pod can have its own PersistentVolumeClaim.
- **Ordered operations**: Supports ordered startup, scaling, and deletion.
- **Sticky identity**: Even if a pod is deleted, its replacement will have the same name and storage.

---

##  Use Cases

- Databases (e.g., MySQL, PostgreSQL)
- Kafka, Zookeeper, Redis (when requiring persistence)
- Applications that need sticky identity or stable hostname

---


