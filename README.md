# Full Stack FastAPI Template

<a href="https://github.com/fastapi/full-stack-fastapi-template/actions?query=workflow%3A%22Test+Backend%22" target="_blank"><img src="https://github.com/fastapi/full-stack-fastapi-template/workflows/Test%20Backend/badge.svg" alt="Test Backend"></a>
<a href="https://coverage-badge.samuelcolvin.workers.dev/redirect/fastapi/full-stack-fastapi-template" target="_blank"><img src="https://coverage-badge.samuelcolvin.workers.dev/fastapi/full-stack-fastapi-template.svg" alt="Coverage"></a>

Full-stack FastAPI template with a local Minikube deployment guide.

## Technology Stack and Features

- ⚡ [**FastAPI**](https://fastapi.tiangolo.com) backend with [SQLModel](https://sqlmodel.tiangolo.com), [Pydantic](https://docs.pydantic.dev), and PostgreSQL.
- 🚀 [React](https://react.dev) frontend with TypeScript, Vite, Tailwind CSS, and shadcn/ui.
- 🔒 Auth-ready backend with JWT, hashed passwords, and first-admin bootstrap.
- 🤖 Generated API client for the frontend.
- ✅ Tests with Pytest and Playwright.
- ☸️ Kubernetes manifests for local deployment in Minikube.

### Screenshots

[![Dashboard login screenshot](img/login.png)](https://github.com/fastapi/full-stack-fastapi-template)
[![Admin dashboard screenshot](img/dashboard.png)](https://github.com/fastapi/full-stack-fastapi-template)
[![Items dashboard screenshot](img/dashboard-items.png)](https://github.com/fastapi/full-stack-fastapi-template)
[![Dark mode dashboard screenshot](img/dashboard-dark.png)](https://github.com/fastapi/full-stack-fastapi-template)
[![API docs](img/docs.png)](https://github.com/fastapi/full-stack-fastapi-template)

## Start Here

- Workshop guide: [docs/minikube-workshop.md](./docs/minikube-workshop.md)
- General development notes: [development.md](./development.md)
- Backend docs: [backend/README.md](./backend/README.md)
- Frontend docs: [frontend/README.md](./frontend/README.md)

## Quick Minikube Flow

```bash
minikube start
docker build -t fsft-backend:workshop -f backend/Dockerfile .
docker build -t fsft-frontend:workshop -f frontend/Dockerfile --build-arg API_URL=http://localhost:8000 .
minikube image load fsft-backend:workshop
minikube image load fsft-frontend:workshop
```

Then follow the exact staged `kubectl` commands in [docs/minikube-workshop.md](./docs/minikube-workshop.md).

## Security Defaults

Change these values before sharing the environment with anyone:

- `SECRET_KEY`
- `FIRST_SUPERUSER_PASSWORD`
- `POSTGRES_PASSWORD`

Generate secrets with:

```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

## Optional Extras (Not in Core Workshop Path)

- Adminer
- Mailcatcher
- Playwright end-to-end suite
- GitHub workflows and CI/CD

## Release Notes

Check [release-notes.md](./release-notes.md).

## License

The Full Stack FastAPI Template is licensed under the terms of the MIT license.
