# 🚀 Upgrading kOps to v1.31

Upgrading kOps to v1.31 is a multi-step but safe process if done carefully. This guide walks you through:

- ✅ Upgrading the **kOps CLI** on your local machine
- ☨️ Upgrading the **Kubernetes cluster** it manages

---

## 🔧 Step 1: Upgrade kOps CLI to 1.31

### 🔹 On Ubuntu or Linux:

```bash
curl -Lo kops https://github.com/kubernetes/kops/releases/download/v1.31.0/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/
```

✅ Confirm the upgrade:

```bash
kops version
```

Should show something like:

```
Version 1.31.0 (git-...)
```

---

## ☁️ Step 2: Backup Cluster State

If you're using an S3 state store (recommended), back it up:

```bash
aws s3 cp s3://<your-kops-state-store> s3://<your-kops-state-store>-backup --recursive
```

✅ This ensures you can roll back if something goes wrong.

> Replace `<your-kops-state-store>` with your actual bucket, e.g., `whytebatl.com`

---

## ☨️ Step 3: Upgrade Kubernetes Cluster

### 1. Edit the Cluster Manifest

```bash
kops edit cluster <cluster-name>
```

Update the `kubernetesVersion` field to a supported version (e.g., `1.27.9` or `1.28.x` — check kOps 1.31 release notes).

Example:

```yaml
kubernetesVersion: 1.27.9
```

---

### 2. Apply the Cluster Changes

```bash
kops update cluster --name <cluster-name> --yes
```

---

### 3. Perform a Rolling Upgrade

```bash
kops rolling-update cluster --name <cluster-name> --yes
```

This rolls each master and worker node one at a time with minimal downtime.

---

## ✅ Final Check

Once the upgrade completes, verify everything is healthy:

```bash
kubectl version
kubectl get nodes
```

You should see all nodes in **Ready** state and running the new Kubernetes version.

---

## 🧐 Pro Tip

Let us know your current cluster version if you want help picking the best compatible `kubernetesVersion` for kOps 1.31.

---

