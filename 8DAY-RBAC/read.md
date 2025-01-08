


# Kubernetes RBAC Setup Guide

This guide provides instructions for setting up Role-Based Access Control (RBAC) for users and namespaces in a Kubernetes cluster.

## Why Use RBAC?

RBAC (Role-Based Access Control) is crucial for managing permissions and ensuring security within a Kubernetes cluster. It allows you to:

- **Control Access**: Define who can access specific resources and what actions they can perform. This is essential for enforcing security policies and preventing unauthorized access.
- **Segregate Duties**: Assign different roles to users based on their responsibilities. For instance, some users might only need read access, while others require full administrative privileges.
- **Enhance Security**: Minimize the risk of accidental or malicious actions by limiting user permissions to only what is necessary for their role.
- **Simplify Management**: Manage permissions at a granular level, making it easier to oversee and adjust access as needed.

## Steps to Follow

### 1. Copy Keys for Cluster Creation

Ensure you have the necessary keys and certificates:
```sh
cd /etc/kubernetes/kops-controller

```
- Copy the keys and certificates  (kubernetes-ca.crt & kubernetes-ca.key) to the appropriate directories (`.ssh/` and `private key`).

### 2. Create Namespaces

Create two namespaces: `development` and `production`.

### 3. Copy CA Certificates

Copy the following files from the master to the management server:
- `ca.crt`
- `ca.key`

### 4. Create Users

#### User 1: `user1`

Generate the key and certificate:

```bash
openssl genrsa -out user1.key 2048
openssl req -new -key user1.key -out user1.csr -subj "/CN=user1/O=development"
openssl x509 -req -in user1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out user1.crt -days 365
```

#### User 2: `user2`

Generate the key and certificate:

```bash
openssl genrsa -out user2.key 2048
openssl req -new -key user2.key -out user2.csr -subj "/CN=user2/O=production"
openssl x509 -req -in user2.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out user2.crt -days 365
```

### 5. Copy Certificates and Keys

Copy all `user1.crt` and `user1.key` files from the /tmp  to the master root location safely.

### 6. Create Config Files for Users

For User 1:

```bash
export KUBECONFIG=/root/config/user1-CONFIG
```

For User 2:

```bash
export KUBECONFIG=/root/config/user2-CONFIG
```

### 7. Set Up RBAC Roles and Bindings

Create roles and role bindings for the users, including:

**Role:** Permissions are scoped to a specific namespace.
**RoleBinding:** Binds a Role to a user/group within a namespace.
**ClusterRole:** Permissions are scoped across the entire cluster.
**ClusterRoleBinding:** Binds a ClusterRole to a user/group across all namespaces.

### Roles commands
```sh
kubectl get roles --all-namespaces
kubectl get roles -n <namespace>
kubectl get rolebindings -n <namespace>
kubectl get rolebindings --all-namespaces
```

### 8. Admin User Configuration

For the administrator `user1`:

```bash
openssl genrsa -out user1.key 2048
openssl req -new -key user1.key -out user1.csr -subj "/CN=user1/O=development"
openssl x509 -req -in user1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out user1.crt -days 365
```

Copy all `.crt` and `.key` files to the master root location safely.

Create the admin config file:

```bash
export KUBECONFIG=/root/config/user1-CONFIG
export -p
```

### 9. Merge Config Files

To combine multiple config files into one:

```bash
export KUBECONFIG=/root/config/user1-CONFIG:/root/config/user2-CONFIG
kubectl config view --merge --flatten > mixed-config.txt
export KUBECONFIG=mixed-config.txt
```
