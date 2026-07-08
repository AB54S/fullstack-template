# FastAPI Project - Backend

## Requirements

- [uv](https://docs.astral.sh/uv/) for Python package and environment management
- Python 3.14 (same as the backend Docker image)

## General Workflow

From `./backend/` install dependencies:

```bash
uv sync
```

Activate the virtual environment:

```bash
source .venv/bin/activate
```

Run the API locally with reload:

```bash
fastapi dev app/main.py
```

Backend URL: <http://localhost:8000>

## Code Areas

- Models: `backend/app/models.py`
- API routes: `backend/app/api/`
- CRUD helpers: `backend/app/crud.py`
- Alembic migrations: `backend/app/alembic/versions/`

## Tests

Run backend tests from `backend/`:

```bash
bash scripts/tests-start.sh
```

Or run from repository root:

```bash
bash scripts/test.sh
```

Coverage output is generated in `backend/htmlcov/`.

## Migrations

Create a migration after model changes:

```bash
alembic revision --autogenerate -m "Describe migration"
```

Apply migrations:

```bash
alembic upgrade head
```

## Email Templates

Email templates are in `backend/app/email-templates/`:

- `src/`: source templates
- `build/`: generated HTML templates used by the app

If you edit MJML templates, use the VS Code MJML extension to export updated HTML.
