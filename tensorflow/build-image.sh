#!/bin/bash

IMAGE=${IMAGE:-austinyhc/tensorflow}
SHORT_SHA=$(git rev-parse --short HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION=${VERSION:-${SHORT_SHA}}

docker buildx create --name mbuilder
docker buildx use mbuilder
docker buildx ls
docker buildx inspect --bootstrap

docker buildx build \
    --platform linux/amd64,linux/arm64,linux/arm/v7 \
    --build-arg BUILD_DATE="${DATE}" \
    --build-arg VCS_REF="${SHORT_SHA}" \
    -t "${IMAGE}:${VERSION}" \
    --push .

docker buildx rm mbuilder

