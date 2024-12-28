DNS NAME<br>
CREATE A S3 BUCKET <br>
Create A EC2 Instance <br>
IAM ROLE(ADMIN FULL ACCESS) AND ASSIGN IT TO EC2 <br>
Connect to  EC2 INSTANCE AND GENERATE SSH ROLE in /.ssh <br>

## Download kubectl
 ```bash
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
  output from the above  : kubectl: OK
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  kubectl version --client
  ```
