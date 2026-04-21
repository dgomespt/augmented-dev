---
name: agentic-python
description: Rules for building and maintaining Python-based agentic applications. Extends dockerized skill.
extends: dockerized
compatibility: [claude-code, opencode, kilo]
metadata: 
  version: "26.04"
  author: dgomespt
---

# Skill: Agentic Python Development Standards

## 1. Environment Policy (MANDATORY)
- **Host Isolation:** NEVER run `pip`, `poetry`, or `python` commands on the host machine.
- **Docker Only:** All execution must happen via `docker compose run` or `docker compose exec`, `docker run`, etc. 
- **Persistence:** Ensure all agent logs and local vector DB storage are mapped to volumes in `docker-compose.yml`.

## 2. Agentic App Patterns
- **Instrumentation:** Always include OpenTelemetry or equivalent tracing (e.g., Arize Phoenix, LangSmith, Prometheus) in the `Dockerfile` environment.
- **Secrets:** Use `.env.example` files. Never hardcode API keys for LLM providers. 
- **Graceful Shutdown:** Agents must handle `SIGTERM` to ensure long-running loops or tool calls aren't killed mid-process.

## 3. Testing & Docs Standards
- **Testing:** - Unit tests in `tests/unit/` (mocking LLM responses).
  - Integration tests in `tests/integration/` (requiring a running container).
- **Documentation:**
  - `README.md`: Setup and "How to run" (Docker commands).
  - `/docs`: Architecture diagrams, agent state-machine definitions, and prompt versioning notes.

## 4. Trigger Commands
- When asked to "start a new agent" or "dockerize", immediately generate:
  1. A `Dockerfile` based on `python:3.11-slim`.
  2. A `docker-compose.yml` with a `dev` service.
  3. A `pyproject.toml` or `requirements.txt`.

## 5. Development vs. Production Logic
- **Conditional Debugging:** - The `Dockerfile` must use a multi-stage build or conditional ARG/ENV logic.
  - Install `debugpy` ONLY if `DEBUG_ENABLED=true`.
  - The `CMD` should switch between `python` and `python -m debugpy --listen 0.0.0.0:5678` based on this flag.

- **Tooling Segregation:**
  - `pytest`, `flake8`, `black`, and `mypy` must NOT be in the base `requirements.txt`.
  - Place dev-tools in a `requirements-dev.txt` or a `dev` extra in `pyproject.toml`.
  - Only the `docker-compose.yml` (dev version) should mount these tools or install the dev-dependency layer.

## 6. Implementation Reference (Reference for AI)
When the AI generates files, it must follow this pattern:

### Dockerfile Pattern:
ARG DEBUG_ENABLED=false
RUN if [ "$DEBUG_ENABLED" = "true" ] ; then pip install debugpy ; fi

### Docker Compose Pattern:
services:
  app:
    build:
      context: .
      args:
        - DEBUG_ENABLED=true
    environment:
      - DEBUG_ENABLED=true
    ports:
      - "5678:5678" # Debugger port
    volumes:
      - .:/app    # Hot-reload for dev