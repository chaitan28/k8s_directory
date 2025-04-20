# Networking for pods
### Assignment IPs to the Pods in cluster
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