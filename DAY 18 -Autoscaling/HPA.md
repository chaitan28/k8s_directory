# Horizontal Pod Autoscaler (HPA)
Horizontal Pod Autoscaler (HPA) in Kubernetes is a feature that automatically scales the number of pods in a deployment, StatefulSet, or ReplicaSet based on observed CPU, memory, or custom metrics.
How HPA Works
- Monitors resource utilization (e.g., CPU or memory usage).
- Adjusts the number of pods dynamically to match demand.
- Uses the Metrics Server to collect resource metrics.
- Works as a control loop, checking metrics at intervals (default: 15 seconds).

---

### Horizontal Pod Autoscaler (HPA) Setup for Nginx Deployment

## 1. Ensure Metrics Server is Installed
First, ensure that the Metrics Server is installed in your Kubernetes cluster, as it provides the necessary resource usage data for autoscaling. <br>

If not installed, run: <br>

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

## 2. Create Horizontal Pod Autoscaler
Here’s a sample YAML file to create an HPA for your nginx deployment, targeting 50% CPU utilization with a minimum of 1 replica and a maximum of 5 replicas. <br>

Create a file called `nginx-hpa.yaml`:

```sh
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: nginx-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx  # Name of your nginx deployment
  minReplicas: 1
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50  # Target 50% CPU utilization
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx  
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: kiran2361993/kubegame:v1
        ports:
        - containerPort: 80
        env:
        - name: TITLE
          value: "NGINX APP1"
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 200m
            memory: 256Mi
      - name: stress
        image: progrium/stress
        command: ["stress"]
        args: ["--cpu", "1"]   # This simulates 1 full CPU core usage — your HPA will respond by scaling up.
```

## 3. Apply the HPA Resource
Now apply the HPA definition:

```bash
kubectl apply -f nginx-hpa.yaml
```

## 4. Verify the HPA
You can check the status of the HPA by running:

```bash
kubectl get hpa
```

You should see something like:

```bash
NAME        REFERENCE          TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
nginx-hpa   Deployment/nginx   10%/50%   1         5         1          2m
```

This means the HPA is targeting 50% CPU utilization, and the number of replicas can scale between 1 and 5 based on usage.

## 5. Test the Autoscaling
You can simulate CPU load on your nginx deployment to test if the autoscaler is working:

```bash
kubectl run -i --tty load-generator --image=busybox /bin/sh
```

Then execute a CPU-intensive command, like:

```bash
while true; do wget -q -O- http://nginx; done
```

This should increase the CPU utilization of the nginx pods, causing the HPA to scale the number of replicas.

## 6. Monitor Scaling
To see the current resource usage and autoscaling actions, you can watch the HPA and pods in real-time:

```bash
kubectl get hpa -w
kubectl get pods -l app=nginx -w
```

---

Let me know if you need any more help with setting up or tweaking your HPA for nginx!

