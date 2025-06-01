### kops cluster autoscaling: 

- when you create a Kubernetes cluster using kOps on AWS, it automatically provisions Auto Scaling Groups (ASGs) for both master and worker nodes. These ASGs are managed through Instance Groups in kOps, which map directly to AWS ASGs.​

- Instance Groups: In kOps, an Instance Group defines a set of similar machines. On AWS, each Instance Group corresponds to an Auto Scaling Group. 
```sh
    kops edit instancegroup  nodes-ap-south-1a --name whytebatl.com
    kops update cluster --name  whytebatl.com --yes --admin
    kops update cluster --name  whytebatl.com --yes --admin
    kops validate cluster --wait 10m
```
- Kops creates an ASG in AWS Cloud for each node. After scaling the nodes as per the edited file above, you can also create a dynamic scaling policy attached to the AWS ASG in the Automatic Scaling section. The rules defined in the dynamic scaling policy specify that if CPU usage exceeds 50%, the nodes will scale in.


​



​

