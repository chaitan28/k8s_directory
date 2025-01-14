DNS NAME<br>
CREATE A S3 BUCKET <br>
Create A EC2 Instance <br>
IAM ROLE(ADMIN FULL ACCESS) AND ASSIGN IT TO EC2 <br>
Connect to  EC2 INSTANCE AND GENERATE SSH ROLE in .ssh/ <br>
download kops and kubectl to usr/local/bin(default location)
### Download kubectl
 ```bash
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  output from the above -- kubectl: OK
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  kubectl version --client
  ```
### kops 
```bash
wget https://github.com/kubernetes/kops/releases/download/v1.28.7/kops-linux-amd64
mv kops-linux-amd64  kops
kops version
```
### nano ~/.bashrc
- environment variable(export=) is session-specific, meaning it will be lost when the system is rebooted.
export NAME=whytebatl.com<br>
export KOPS_STATE_STORE=s3://whytebatl.com<br>
export AWS_REGION=us-east-1<br>
export CLUSTER_NAME=whytebatl.com<br>
export EDITOR='/usr/bin/nano'<br>
If using nano, press CTRL+O, then Enter to save. Press CTRL+X to exit the editor <br>
After copying the above files to .bashrc run “ source ~/.bashrc ” <br>

### Create a Cluster using Kops and generate a cluster file and save it carefully and do neccessary changes
```bash

kops create cluster --name=whytebatl.com --state=s3://whytebatl.com  --zones=us-east-1a,us-east-1b --node-count=2 --control-plane-count=1 --node-size=t3.medium --control-plane-size=t3.medium --control-plane-zones=us-east-1a --control-plane-volume-size 25 --node-volume-size 25 
--ssh-public-key ~/.ssh/custom.pub --dns-zone=whytebatl.com  --dry-run --output yaml > cluster.yml

```

####  One done run below commands to create the cluster 
```bash
kops create -f cluster.yml  
kops update cluster --name  whytebatl.com --yes --admin
kops rolling-update cluster                                         #update the cluster
kops validate cluster --wait 10m
kops delete -f cluster.yml  --yes
kubectl get nodes -o wide 
kubectl get no -o wide 
kubectl get pod -o wide 
kubectl get po -o wide 
kubectl cluster-info
kubectl get ns
kubectl get po -o wide -n kube-system
curl -k https://api.whytebatl.com:6443
kubectl config view --minify

```

### Run kubectl commands as default user(ubuntu)
```sh
sudo su root
mkdir -p /home/ubuntu/.kube/
cp /root/.kube/config /home/ubuntu/.kube/config
chown -R ubuntu:ubuntu /home/ubuntu/.kube
chmod 600 /home/ubuntu/.kube/config
su - ubuntu or sudo su ubuntu
kubectl get pods
```


- Rancher installation 
```sh
docker run -d --restart=unless-stopped  -p 80:80 -p 443:443  --privileged  rancher/rancher:latest
docker logs  58219c96294d   2>&1 | grep "Bootstrap Password:"
Admin@280324
curl --insecure -sfL https://54.82.26.66/v3/import/6tfkvcrr4zfp2kt8nrc6x4gckj7p7qlkn5bjl4v4ncdxk68v8lp6pg_c-m-9frqpphw.yaml | kubectl apply -f -
```