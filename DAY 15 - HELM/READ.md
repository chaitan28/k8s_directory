## Helm chart
- A Helm chart is a collection of files that describe a related set of Kubernetes resources. Think of it as a Kubernetes application template

### Helm Commands
- helm create <helloworld>
  This will generate a directory structure with all the necessary files for a Helm chart<br>
 helloworld/
  Chart.yaml      # A YAML file containing information about the chart <br>
  values.yaml     # The default configuration values for this chart<br>
  charts/         # A directory to store any dependencies<br>
  templates/      # A directory containing Kubernetes manifest templates<br>
  .helmignore     # A file to ignore unwanted files when packaging the chart<br>

- helm install myhelloworld helloworld<br>
- helm list -a<br>
- helm upgrade myhelloworld helloworld  # change the replicacount=2 then apply<br>
- helm rollback myhelloworld 1          # rollback is made <br>
- helm install myhelloworld --debug --dry-run helloworld<br>
- helm template helloworld<br>
- helm lint helloworld/<br>