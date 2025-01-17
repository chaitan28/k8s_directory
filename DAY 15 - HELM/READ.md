## Helm chart
- A Helm chart is a collection of files that describe a related set of Kubernetes resources. Think of it as a Kubernetes application template

### Helm Commands
- helm create -helloworld- <br>
  This will generate a directory structure with all the necessary files for a Helm chart<br>
```sh
 helloworld/<br>
  **Chart.yaml:**   A YAML file containing information about the chart <br>
  **values.yaml:**  The default configuration values for this chart<br>
  **charts/:**       A directory to store any dependencies<br>
  **templates/:**    A directory containing Kubernetes manifest templates<br>
  **.helmignore:**   A file to ignore unwanted files when packaging the chart<br>
```

- helm install -myhelloworld- -helloworld-<br>
  This command will install the "helloworld" chart and create a release named "myhelloworld<br>
- helm list -a<br>
The command helm list -a will list all the Helm releases in your Kubernetes cluster, including those that are currently deleted but still have some history. Here's how you can use it.
```sh
root@ip-172-31-16-226:~# helm list -a
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
myhelloworld    default         3               2025-01-16 12:23:38.333933535 +0000 UTC deployed        helloworld-0.1.0        1.16.0 

```
- helm uninstall myhelloworld
- helm status myhelloworld
- helm upgrade myhelloworld helloworld --set replicaCount=4
- helm upgrade myhelloworld helloworld  # change the replicacount=2 then apply<br>
- helm rollback myhelloworld 1          # rollback is made <br>
- helm install myhelloworld --debug --dry-run helloworld<br>
- helm template helloworld<br>
- helm lint helloworld/<br>