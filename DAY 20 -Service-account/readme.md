In Kubernetes, **ServiceAccounts** and **RBAC (Role-Based Access Control)** work together to manage **permissions and access control** for workloads and users.

---

###  What is a ServiceAccount?

A **ServiceAccount** is an identity used by **pods** to interact with the Kubernetes API server.

* Every pod runs under a ServiceAccount.
* By default, pods use the `default` ServiceAccount in the namespace.
* You can create custom ServiceAccounts and assign them to pods.

---

###  What is RBAC (Role-Based Access Control)?

**RBAC** defines **what actions** an identity (user, group, or ServiceAccount) can perform on **which resources**.

RBAC components:

* **Role**: Permissions **within a namespace**.
* **ClusterRole**: Permissions **cluster-wide** (can also be used in a namespace).
* **RoleBinding**: Binds a Role to a user, group, or ServiceAccount **within a namespace**.
* **ClusterRoleBinding**: Binds a ClusterRole to a subject **across the cluster**.

---

### 🔧 Example: Create a ServiceAccount and RBAC Role

#### 1. Create a ServiceAccount

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-app-sa
  namespace: default
```

#### 2. Create a Role

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: default
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

#### 3. Bind Role to ServiceAccount

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: my-app-sa
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

#### 4. Assign ServiceAccount to a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  serviceAccountName: my-app-sa
  containers:
  - name: app
    image: my-app-image
```

---

### 🔒 Use Case Summary

| Use Case                 | Use                                  |
| ------------------------ | ------------------------------------ |
| Separate pod permissions | Use ServiceAccounts                  |
| Limit API access         | Use RBAC with Roles                  |
| Give namespace access    | Use Role + RoleBinding               |
| Give cluster-wide access | Use ClusterRole + ClusterRoleBinding |

Let me know if you want an example for ClusterRole or automation with Helm/Kustomize.
