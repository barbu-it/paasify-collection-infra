# Docker Registry

## Quickstart

To create a new image in you registry:
````
REGISTRY_DOMAIN=registry.example.org

docker pull debian:12-slim
docker tag debian:12-slim $REGISTRY_DOMAIN/debian-custom
docker images | grep debian-custom
docker push $REGISTRY_DOMAIN/debian-custom
```
