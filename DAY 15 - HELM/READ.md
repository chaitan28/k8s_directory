## Helm chart
- A Helm chart is a collection of files that describe a related set of Kubernetes resources. Think of it as a Kubernetes application template

### Helm Commands
- helm create -helloworld- <br>
  helm rollback -chartname-

  This will generate a directory structure with all the necessary files for a Helm chart<br>
```sh
 helloworld/<br>
  **Chart.yaml:**   A YAML file containing information about the chart <br>
  **values.yaml:**  The default configuration values for this chart<br>
  **charts/:**       A directory to store any dependencies<br>
  **templates/:**    A directory containing Kubernetes manifest templates<br>
  **.helmignore:**   A file to ignore unwanted files when packaging the chart<br>
```
- helm template helloworld/
  The command will generate the Kubernetes manifests for the resources defined in the chart, such as Deployments, Services, ConfigMaps before running like a dry run.
- helm install -myhelloworld- -helloworld-<br>
  This command will install the "helloworld" chart and create a release named "myhelloworld<br>
- helm list -a<br>
The command helm list -a will list all the Helm releases in your Kubernetes cluster, including those that are currently deleted but still have some history. Here's how you can use it.
```sh
root@ip-172-31-16-226:~# helm list -a
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
myhello default         1               2025-01-17 06:29:08.93430527 +0000 UTC  deployed        helloworld-0.1.0        1.16.0     
```
- helm uninstall myhelloworld
- helm status myhelloworld
- helm upgrade myhelloworld helloworld --set replicaCount=2. or # change the replicacount=2 in values.yaml file then apply<br>
- helm rollback myhelloworld 1          # rollback is made <br>
 Every release upgrade in Helm creates a new version. The version numbers increment even after rollbacks. <br>
- helm history <release-name>
```sh
root@ip-172-31-16-226:~/helloworld# helm history myhello
REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION     
1               Fri Jan 17 06:29:08 2025        superseded      helloworld-0.1.0        1.16.0          Install complete
2               Fri Jan 17 06:33:46 2025        superseded      helloworld-0.1.0        1.16.0          Upgrade complete
3               Fri Jan 17 06:36:45 2025        deployed        helloworld-0.1.0        1.16.0          Rollback to 1 
```
- helm install myhelloworld --debug --dry-run helloworld<br>
  --dry-run Simulates the installation process without actually applying changes to the cluster<br>
- helm lint helloworld/<br>