Perfect. Let’s **create a dummy Helm chart from scratch** for **two images** (frontend + backend).
No assumptions. Clean and minimal.

---

## 1. Create Helm chart

```bash
helm create two-apps
cd two-apps
```

---

## 2. Clean default files

```bash
rm -rf templates/tests
rm templates/deployment.yaml
rm templates/service.yaml
```

---

## 3️. `values.yaml` (define 2 dummy images)

```yaml
app1:
  name: frontend
  image: nginx
  tag: "1.25"
  replicas: 1

app2:
  name: backend
  image: httpd
  tag: "2.4"
  replicas: 1
```

---

## 4️. Create Deployment for App1

📄 `templates/deployment-app1.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Values.app1.name }}
spec:
  replicas: {{ .Values.app1.replicas }}
  selector:
    matchLabels:
      app: {{ .Values.app1.name }}
  template:
    metadata:
      labels:
        app: {{ .Values.app1.name }}
    spec:
      containers:
        - name: {{ .Values.app1.name }}
          image: "{{ .Values.app1.image }}:{{ .Values.app1.tag }}"
          ports:
            - containerPort: 80
```

---

## 5️. Create Deployment for App2

📄 `templates/deployment-app2.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-{{ .Values.app2.name }}
spec:
  replicas: {{ .Values.app2.replicas }}
  selector:
    matchLabels:
      app: {{ .Values.app2.name }}
  template:
    metadata:
      labels:
        app: {{ .Values.app2.name }}
    spec:
      containers:
        - name: {{ .Values.app2.name }}
          image: "{{ .Values.app2.image }}:{{ .Values.app2.tag }}"
          ports:
            - containerPort: 80
```



## 6. Create Service file

📄 **`templates/service-app1.yaml`**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-{{ .Values.app1.name }}
spec:
  type: NodePort
  selector:
    app: {{ .Values.app1.name }}
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

---

## 7. Service for App2

📄 **`templates/service-app2.yaml`**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-{{ .Values.app2.name }}
spec:
  type: NodePort
  selector:
    app: {{ .Values.app2.name }}
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30081
```

---

## 8. Install / Upgrade

```bash
helm upgrade --install demo .
```

---

## 9. Access in browser

```text
http://<NODE-IP>:30080   # frontend (nginx)
http://<NODE-IP>:30081   # backend (httpd)
```

Get node IP:

```bash
kubectl get nodes -o wide
```

---

## 10. Install Helm chart (dummy test)

```bash
helm install demo .
```

Verify:

```bash
kubectl get pods
kubectl get deploy
```

---

## 11. Expected Output

```
demo-frontend-xxxxx   Running
demo-backend-xxxxx    Running
```

---

## 12. Package for Helm repo

```bash
helm package .
```

Creates:

```
two-apps-0.1.0.tgz
```

## 12. Helpful Commands

```bash
helm list
helm status demo 
helm history demo 
helm get manifest demo 
helm get all demo
helm uninstall demo
```
---

