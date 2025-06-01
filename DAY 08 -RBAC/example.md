This image explains **how to give a DevOps person limited access** to a Kubernetes cluster running on **Amazon EKS** using **IAM, RBAC, and `aws-auth` ConfigMap**.

Here’s the breakdown:

---

### 🔷 1. **Role (Kubernetes `Role`)**

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: deployment-role
  namespace: frontend
rules:
  - apiGroups: ["", "extensions", "apps"]
    resources: ["deployments", "replicasets", "pods"]
    verbs: ["create", "get", "list", "update", "delete", "watch", "patch"]
```

**Purpose:**
This defines what permissions are allowed **within the `frontend` namespace**.

* It allows actions like `create`, `update`, etc. on `pods`, `deployments`, etc.
* It's a namespaced Role, so only valid inside the `frontend` namespace.

---

### 🔷 2. **RoleBinding**

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: deployment-rolebinding
  namespace: frontend
roleRef:
  apiGroup: ""
  kind: Role
  name: deployment-role
subjects:
  - kind: User
    name: developerbob
    apiGroup: ""
```

**Purpose:**
This **binds the above Role** (`deployment-role`) to the Kubernetes user `developerbob`, but **only inside the `frontend` namespace**.

---

### 🔷 3. **`aws-auth` ConfigMap (EKS-specific)**

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapUsers: |
  - userarn: arn:aws:iam::719217631821:user/developerbob
    username: developerbob
    groups:
      - deployment-role

```

**Purpose:**

* This maps an **IAM user** (`developerbob`) to a **Kubernetes user** with a group.
* The group name `deployment-role` **must match the group used in a RoleBinding**, or you’ll use `username` matching like in this case.

---

### Final Outcome:

* `developerbob` (IAM user) assumes access to the EKS cluster.
* He is recognized as `developerbob` in Kubernetes.
* Kubernetes RBAC (RoleBinding) grants him access to manage **deployments, pods, replicasets** inside **only the `frontend` namespace**.

---


