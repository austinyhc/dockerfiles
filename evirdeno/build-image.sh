#!/bin/bash

IMAGE=${IMAGE:-austinyhc/evirdeno}
SHORT_SHA=$(git rev-parse --short HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION=${VERSION:-${SHORT_SHA}}

docker build \
    --build-arg BUILD_DATE="${DATE}" \
    --build-arg VCS_REF="${SHORT_SHA}" \
    -t "${IMAGE}:${VERSION}" .

docker push "${IMAGE}:${VERSION}"
