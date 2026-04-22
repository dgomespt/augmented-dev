---
name: dockerized
description: Docker-first development standards for any language project.
compatibility: [claude-code, opencode, kilo]
metadata: 
  version: "1.0.0"
  author: dgomespt
---

# Skill: Dockerized Development Standards

Universal Docker-first standards for all software projects.

## 1. Environment Policy (MANDATORY)

- **Host Isolation:** Never run language-specific commands on host (`pip`, `npm`, `cargo`, `go build`, etc.)
- **Docker Only:** All builds and execution via `docker compose run`, `docker compose exec`, `docker run`, etc.
- **Persistence:** Map logs, caches, and data directories to volumes in `docker-compose.yml`. Common volumes: `/app/logs`, `/app/data`

## 2. Standard Files

### Single Image Project
```
├── Dockerfile
├── docker-compose.yml
└── .dockerignore
```

### Multi-Image / Complex Project
Use `docker/` folder:
```
├── docker/
│   ├── Dockerfile.app
│   ├── Dockerfile.worker
│   ├── docker-compose.yml
│   └── configs/
├── src/
└── ...
```

## 3. Trigger Commands

When asked to "dockerize" or "add docker":

### Dockerfile Pattern

```dockerfile
FROM ${base_image}
WORKDIR /app
COPY . .
RUN ${install_command}
EXPOSE ${port}
```

| Language | Base Image | Install |
|----------|-----------|----------|
| Python | `python:3.11-slim` | `pip install -r requirements.txt` |
| Node | `node:20-alpine` | `npm ci` |
| Rust | `rust:1.75-slim` | `cargo build --release` |
| Go | `golang:1.22-alpine` | `go build` |

### Docker Compose Pattern

```yaml
services:
  dev:
    build: .
    ports:
      - "${PORT}:${PORT}"
    volumes:
      - .:/app
    environment:
      - NODE_ENV=development
    command: ${dev_command}
```

## 4. Development vs Production

- **Dev:** Mount source, hot-reload, verbose logging, dev tools installed, debugger enabled, linting and testing dependencies included.
- **Prod:** Single-stage build, multi-stage for minimal images, no dev dependencies

```yaml
# Development override
services:
  dev:
    volumes:
      - .:/app
    command: ${dev_server}
    profiles:
      - dev
```

## 5. Best Practices

- Use specific version tags, never `latest`
- Combine `COPY` statements to minimize cache invalidation
- Run as non-root user in production
- Health checks via `HEALTHCHECK` instruction