# Docker Folder Structure

For multi-image projects or complex configurations:

```
project/
├── docker/
│   ├── Dockerfile.app           # Main application image
│   ├── Dockerfile.worker       # Background worker image
│   ├── Dockerfile.cli        # CLI tool image
│   ├── docker-compose.yml    # Orchestration
│   ├── .env.example         # Environment template
│   └── configs/
│       ├── app.env
│       └── worker.env
├── src/                      # Application source
├── ...
```

## Image Naming

```yaml
# docker-compose.yml
services:
  app:
    build:
      context: ..
      dockerfile: docker/Dockerfile.app
    image: ${PROJECT}/app:${VERSION}
  worker:
    build:
      context: ..
      dockerfile: docker/Dockerfile.worker
    image: ${PROJECT}/worker:${VERSION}
```

## Entrypoints

Store entrypoint scripts in `docker/entrypoints/`:
```
docker/
└── entrypoints/
    ├── app.sh
    └── worker.sh
```