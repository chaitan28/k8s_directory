
# Kubernetes Probes: Readiness and Liveness

### Readiness Probe

A Readiness Probe determines if a container is ready to handle requests. If the probe fails, the container is temporarily removed from service. From below example, if /healthz is deleted or unavailable in the container, the pod will show running state with unhealthy status. this will not restart the container.

**Dont send the traffic unless the pod is ready**

**Example:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: readiness-example
spec:
  containers:
  - name: myapp
    image: myapp:latest
    readinessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 10
```

In this example:

- **httpGet:** The probe sends an HTTP GET request to `/healthz` on port `8080`.
- **initialDelaySeconds:** : Waits 5 seconds after the container starts before performing the first probe.
- **periodSeconds:** The probe checks the endpoint every 10 seconds.

### Liveness Probe

A Liveness Probe ensures that your container is running properly. If the probe fails, Kubernetes will restart the container.From below example, if /healthz is deleted or unavailable in the container, the pod will show running state with unhealthy status. this will restart the container.

**if the pod fails kubelet trys to restart the pod**
```sh
Probe Type     | Purpose                                     | Action
readinessProbe | "Is the pod ready to serve traffic?"        | Kubernetes only sends traffic when the pod is ready.
livenessProbe  | "Is the pod still alive and functioning?"   | If the pod fails the liveness probe, it is restarted.
```
**Example:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-example
spec:
  containers:
  - name: myapp
    image: myapp:latest
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 3
      periodSeconds: 5
```

In this example:

- **httpGet:** Similar to the Readiness Probe, but used to determine if the container should be restarted.
- **initialDelaySeconds:** The probe starts checking 3 seconds after the container starts.
- **periodSeconds:** The probe checks the endpoint every 5 seconds.

## Practical Example

Imagine you have a web server that takes a few seconds to start. You can use a Readiness Probe to ensure it’s ready before receiving traffic. If your web server crashes or becomes unresponsive, the Liveness Probe will restart it automatically.

### Sample Application Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: probe-example
spec:
  replicas: 1
  selector:
    matchLabels:
      app: probe-example
  template:
    metadata:
      labels:
        app: probe-example
    spec:
      containers:
      - name: myapp
        image: myapp:latest
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          httpGet:
            path: /live
            port: 8080
          initialDelaySeconds: 3
          periodSeconds: 5
```

In this deployment:

- **Readiness Probe** checks if the application is ready to serve traffic by accessing `/ready`.Checks whether container is alive. 
- **Liveness Probe** monitors the health of the container through the `/live` endpoint.Checks whether container is alive.


## ALWAYS Readiness Probe and Liveness Probe are deployed in one deployment file. 

## Conclusion

Using Readiness and Liveness Probes in your Kubernetes deployment ensures that your application is reliable, responsive, and capable of self-healing. Start implementing these probes to make your services more robust and fault-tolerant.

## References

- [Kubernetes Documentation on Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
