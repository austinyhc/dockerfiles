#!/bin/bash

IMAGE=${IMAGE:-austinyhc/evirdeno}
SHORT_SHA=$(git rev-parse --short HEAD)
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION=${VERSION:-${SHORT_SHA}}

if [[ ${SNTZ_GH_TOKEN:-"unset"} == "unset"  ]]; then
    echo "Please set a security token to your local env variable by 'export SNTZ_GH_TOKEN=...'";
    exit 2;
fi

SNTZ_GH_TOKEN=${SNTZ_GH_TOKEN}

docker build \
    --build-arg BUILD_DATE="${DATE}" \
    --build-arg VCS_REF="${SHORT_SHA}" \
    --build-arg GH_TOKEN="${SNTZ_GH_TOKEN}" \
    -t "${IMAGE}:${VERSION}" .

docker push "${IMAGE}:${VERSION}"
