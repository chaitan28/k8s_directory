
![KUBERNETES ARCHITECTURE](K8S.jpg)
### MASTER NODE <br>
1. Api Server <br>
 :  handles requests (kubectl, other services), and validates configurations.<br>
2. Control Manager: <br>
Runs control loop processes like:<br>
Node Controller:            Manages node status.<br>
Replication Controller:     Ensures desired number of pod replicas.<br>
Endpoint Controller:        Populates endpoint objects.<br>
Service Account Controller: Manages default accounts.<br>
3. ECTD : database for the cluster, stores all the infomation of the cluster<br>
4. Kube-Scheduler: <br>
   Assigns workloads (Pods) to available nodes.<br>


### WOEKER NODE
1. kubelet:<br>
  It is responsible containers are running as defined in PodSpecs.<br>
2. kubeproxy:<br>
    communication inside the cluster. Assigns Ip to the pods <br>
3. container runtime <br>
   the softwate which responsible  for running container<br>

   ### ALL THE COMPONENTS ARE WORKING AS PODS BY ITSELF. BUT KUBELET IS DEPLOYED AS DEMONSETS