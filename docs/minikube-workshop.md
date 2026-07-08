# Minikube Workshop Guide

This guide is the primary deployment path for this repository.

## Prerequisites

- Docker installed and running
- Minikube installed
- `kubectl` installed

## 1) Start Minikube

```bash
minikube start
```

## 2) Build Images with Docker

From repository root:

```bash
docker build -t fsft-backend:workshop -f backend/Dockerfile .
docker build -t fsft-frontend:workshop -f frontend/Dockerfile --build-arg API_URL=http://localhost:8000 .
```

## 3) Load Images into Minikube

```bash
minikube image load fsft-backend:workshop
minikube image load fsft-frontend:workshop
```

## 4) Create Namespace, ConfigMap, and Secret with Commands

Pick your namespace (for example `interns`):

```bash
kubectl create namespace interns
```

Create config values:

```bash
kubectl -n interns create configmap app-config \
  --from-literal=ENVIRONMENT=local \
  --from-literal=PROJECT_NAME="Full Stack FastAPI Project" \
  --from-literal=FRONTEND_HOST=http://localhost:8080 \
  --from-literal=BACKEND_CORS_ORIGINS=http://localhost:8080,http://127.0.0.1:8080 \
  --from-literal=POSTGRES_SERVER=postgres \
  --from-literal=POSTGRES_PORT=5432 \
  --from-literal=POSTGRES_DB=app \
  --from-literal=POSTGRES_USER=postgres \
  --from-literal=SENTRY_DSN=
```

Create secrets (replace placeholder values):

```bash
kubectl -n interns create secret generic app-secret \
  --from-literal=SECRET_KEY="replace-me" \
  --from-literal=FIRST_SUPERUSER="admin@example.com" \
  --from-literal=FIRST_SUPERUSER_PASSWORD="replace-me" \
  --from-literal=POSTGRES_PASSWORD="replace-me"
```

Notes:

- Equivalent YAML files are also provided in `k8s/` for reference.
- If namespace/config/secret already exist, either delete and recreate or use the YAML files with `kubectl apply -f`.

## 5) Apply Kubernetes Manifests (Staged)

Apply storage first:

```bash
kubectl apply -f k8s/postgres-pvc.yaml
```

Apply database service and deployment:

```bash
kubectl apply -f k8s/services/postgres-service.yaml
kubectl apply -f k8s/deployments/postgres-deployment.yaml
```

Run migrations and initial data job:

```bash
kubectl apply -f k8s/backend-migrate-job.yaml
kubectl -n interns wait --for=condition=complete job/backend-migrate --timeout=180s
```

Apply backend and frontend services and deployments:

```bash
kubectl apply -f k8s/services/backend-service.yaml
kubectl apply -f k8s/services/frontend-service.yaml
kubectl apply -f k8s/deployments/backend-deployment.yaml
kubectl apply -f k8s/deployments/frontend-deployment.yaml
```

## 6) Verify Resources

```bash
kubectl -n interns get pods
kubectl -n interns get svc
```

## 7) Access the Application with Port Forwarding

Use two terminals.

Terminal 1:

```bash
kubectl -n interns port-forward svc/backend 8000:8000
```

Terminal 2:

```bash
kubectl -n interns port-forward svc/frontend 8080:80
```

Open:

- Frontend: <http://localhost:8080>
- Backend docs: <http://localhost:8000/docs>

## 8) Quick Troubleshooting

Check pod status:

```bash
kubectl -n interns get pods
```

Describe a failing pod:

```bash
kubectl -n interns describe pod <pod-name>
```

Check logs:

```bash
kubectl -n interns logs deploy/backend
kubectl -n interns logs job/backend-migrate
```

## Optional Extras (Not Required for Workshop)

- Adminer
- Mailcatcher
- Playwright end-to-end tests
- GitHub CI/CD workflows
