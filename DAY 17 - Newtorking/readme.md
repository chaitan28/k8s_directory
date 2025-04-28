# Networking for pods
--- 
## Assignment IPs to the Pods in cluster
- When a pod is created, Kubernetes asks the CNI plugin to assign it an IP.
- Kops installs a CNI plugin (usually Calico/Cilium by default).
- See assigned Pod CIDRs to Nodes:
```sh
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{" → "}{.spec.podCIDR}{"\n"}{end}'
```
- Check Cilium status:
```sh
kubectl -n kube-system exec $(kubectl get pods -n kube-system -l k8s-app=cilium -o jsonpath='{.items[0].metadata.name}') -- cilium status
```
- Check the apiserver DNS:
```sh
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'
```
 ---
Sure! Here's a **simple explanation** about **Network Policies** in Kubernetes:

---

#  What are Network Policies?
- NetworkPolicies **control** how **pods** communicate with each other and with **outside** the cluster.
- They act like **firewall rules** inside Kubernetes.
- By **default**, pods can talk to **anyone** (open network).
- After you apply a **NetworkPolicy**, only the allowed traffic is permitted — everything else is **blocked**.

---

# Why use Network Policies?
✅ Improve **security** (pod-to-pod communication is limited).  
✅ Prevent unwanted traffic.  
✅ Protect sensitive services like databases.  
✅ Follow best practices for **Zero Trust** networking.

---

#  Basic Structure of a NetworkPolicy

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-nginx
  namespace: my-namespace
spec:
  podSelector:
    matchLabels:
      app: nginx           # select pods having app=nginx
  policyTypes:
  - Ingress                # control incoming traffic
  - Egress                 # (optional) control outgoing traffic
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: allowed  # allow pods with label access=allowed
    ports:
    - protocol: TCP
      port: 80
```

---

#  Key Fields

| Field          | Meaning                                                  |
|----------------|-----------------------------------------------------------|
| `podSelector`  | Select which pods the policy applies to                  |
| `policyTypes`  | `Ingress`, `Egress`, or both                              |
| `ingress`      | Rules for **incoming** traffic (who can access you)       |
| `egress`       | Rules for **outgoing** traffic (who you can access)       |
| `from`         | Defines allowed sources (other pods, namespaces, IPs)     |
| `to`           | Defines allowed destinations (used with `egress`)         |
| `ports`        | (Optional) Limit to specific ports like 80, 443, etc.      |

---

# 🔥 Important Points:
- If a pod is **selected** by a NetworkPolicy, it will **only allow** traffic defined by that policy.
- If no NetworkPolicy selects a pod, **everything** is allowed (default Kubernetes behavior).
- Needs a **CNI plugin** that supports NetworkPolicies (like Calico, Cilium, Weave Net).

---

# ⚡ In short:
| Without NetworkPolicy                    | With NetworkPolicy |
|------------------------                  |--------------------|
| Everything can talk to everything        | Only allowed traffic is possible |

---

Would you like me to give a real **example** like **"allow only frontend to access backend"** with YAML? 🚀  
It’s a very common pattern in microservices! 🎯
