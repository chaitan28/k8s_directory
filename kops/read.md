DNS NAME<br>
CREATE A S3 BUCKET <br>
Create A EC2 Instance <br>
IAM ROLE(ADMIN FULL ACCESS) AND ASSIGN IT TO EC2 <br>
Connect to  EC2 INSTANCE AND GENERATE SSH ROLE in /.ssh <br>

## Download kubectl
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
export NAME=www.whytebatl.com<br>
export KOPS_STATE_STORE= s3://www.whytebatl.com<br>
export AWS_REGION=us-east-1<br>
export CLUSTER_NAME=whytebatl<br>
export EDITOR='/usr/bin/nano'<br>

### After copying the above files to .bashrc run “ source .bashrc ”.
