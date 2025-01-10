# Kubernetes Persistent Storage

This repository provides examples and explanations of different Kubernetes storage options. Here’s a simple guide to understand how different types of persistent storage work in Kubernetes.

### Persistent Volume (PV)
- **Purpose**: Represents a piece of storage in the cluster that has been provisioned by an administrator.
- **Details**: PVs are managed by the cluster and can be dynamically provisioned using storage classes.

### Persistent Volume Claim (PVC)
- **Purpose**: A request for storage by a user. PVCs are used to claim PVs and can be either static or dynamic.

### Storage Class
- **Purpose**: Defines the provisioner and parameters for dynamically provisioning PVs.
- **Dynamic Provisioning**: Automatically creates PVs based on PVC requests using predefined storage classes.

## Tasks

### EBS-Volume
1. create a EBS-VOL in AWS Console
2. upload the yaml defined 

### Persistent Volume and Claim
1. Create 5 PVs.
2. Use `kubectl get pv` to view them.
3. Claims can be static or dynamic:
   - **Static PVC**: Manually create a PV and PVC.
   - **Dynamic PVC**: Create a PVC and let it automatically provision a PV using storage classes.

4. Test different PVC sizes (2GB, 8GB) and check the claims.
5. Delete PVs and PVCs as needed.

### Dynamic Provisioning
1. Create a PVC with a storage class to automatically provision a PV.
2. View storage classes with:
   ```bash
   kubectl get storageclasses
   ```
3. Deleting all storage classes will affect PVC provisioning.

### Policies
- **AWS Org Policies**: Ensure developers don’t create excessive or unnecessary storage by setting up policies that control resource usage.
