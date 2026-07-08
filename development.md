# FastAPI Project - Development

This repository is structured for a local Kubernetes workflow with Minikube.

## Deployment Path Used in This Repository

- Kubernetes manifests live in `k8s/`.
- A step-by-step workshop guide lives in `docs/minikube-workshop.md`.
- The default workshop flow is:
  1. Build backend and frontend images with Docker.
  2. Load images into Minikube.
  3. Create namespace/config/secret.
  4. Apply manifests in staged order.
  5. Use `kubectl port-forward` to access frontend and backend.

## Local App Development (Without Kubernetes)

You can still develop each app directly.

### Backend

```bash
cd backend
uv sync
source .venv/bin/activate
fastapi dev app/main.py
```

Backend URL: <http://localhost:8000>

### Frontend

```bash
cd frontend
bun install
bun run dev
```

Frontend URL: <http://localhost:5173>

## Environment and Secrets

- The backend validates security-sensitive values (`SECRET_KEY`, `POSTGRES_PASSWORD`, `FIRST_SUPERUSER_PASSWORD`).
- In local mode (`ENVIRONMENT=local`), default placeholders warn but do not crash.
- For workshop reliability, set strong values in Kubernetes secrets.

Generate a secret value with:

```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

## Optional Extras (Out of Core Workshop Scope)

- Adminer for DB inspection
- Mailcatcher for local email capture
- Playwright end-to-end test workflow
- GitHub workflows and CI/CD setup

## Pre-commits and Linting

This project uses [prek](https://prek.j178.dev/) for formatting and linting.

Install hooks from the `backend/` directory:

```bash
uv run prek install -f
```

Run all hooks manually:

```bash
uv run prek run --all-files
```
