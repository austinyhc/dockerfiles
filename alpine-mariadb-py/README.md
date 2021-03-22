# A tiny Alpine+MariaDB+Python image

---

The goal of this project is to achieve a high quality, bite-sized, fast startup docker image for [MariaDB](https://mariadb.org/). It is built on the excellent, container-friendly Linux distribution [Alpine Linux](https://alpinelinux.org/).

Licensed under [MIT](https://github.com/jbergstroem/mariadb-alpine/blob/master/LICENSE).

## Features

---

- Reduce default settings for InnoDB: production deployments should have their own `my.cnf`
- Simple and fast shutdown: Both `CTRL+C` in interactive mode and `docker stop` does the job.
- Permissive ACL: Aminimal no-flags startup "just works"; convenient for developement

## Multi-Arch Build

---

Create a new builder called `testbuilder`

```sh
$ docker buildx create --name testbuilder
```

Switch to `testbuilder` builder instance

```sh
$ docker buildx use testbuilder
$ docker buildx ls
```

The ensures that the builder is running before inspecting it. If the driver is `docker-container`, then `--bootstrap` starts the buildkit container and waits until it is operational. Bootstrapping is automatically done during build, it is thus not necessary. The same BuildKit container is used during the lifetime of the associated builder node (as displayed in `buildx ls`).

```sh
$ docker buildx inspect --bootstrap
```

Build ARM-based Docker images

```sh
$ docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t austinyhc/alpine-mariadb-py --push .
```

Awesome. The `--platform` flag enabled buildx to generate Linux images for Intel 64-bit, arm 32-bit and arm 64-bit arch. The `--push` option generates a multi-arch manifest and pushes all the images all the images to Docker Hub. Cool, isn't it?

Let’s use `docker buildx imagetools` to inspect what we did. `imagetools` contains commands for working with manifest lists in the registry. These commands are useful for inspecting multi-platform build results. It creates a new manifest list based on source manifests. The source manifests can be manifest lists or single platform distribution manifests and must already exist in the registry where the new manifest is created. If only one source is specified create performs a carbon copy.

```sh
$ docker buildx imagetools inspect docker.io/austinyhc/alpine-mariadb-py:latest
```

```sh
Name:      docker.io/austinyhc/alpine-mariadb-py:latest
MediaType: application/vnd.docker.distribution.manifest.list.v2+json
Digest:    sha256:f25173390d240b155ae75295db6f2b63bbea4a74a5047f98bc08efe0e9fafe05

Manifests:
  Name:      docker.io/austinyhc/alpine-mariadb-py:latest@sha256:b0731afa6c6223f657cd27f4979a8a10789c69a07974f69aa74f62a0f4e4d86b
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/amd64

  Name:      docker.io/austinyhc/alpine-mariadb-py:latest@sha256:9fbb205cb1f640624fb3e4a94f18040f963d136fd956651cb5980f2126a9c701
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/arm64

  Name:      docker.io/austinyhc/alpine-mariadb-py:latest@sha256:feac98cee9f00af0ed9a9ee417fec5110c00c95af853f1d4fa09fec2b589e02d
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/arm/v7
```

## Usage

---

Default startup:

```sh
$ docker run -it --rm --name=db jbergstroem/mariadb-alpine
```

If you would like to skip InnoDB (read: faster), this is for you:

```sh
$ docker run -it --rm --name=db \
         -e SKIP_INNODB=yes \
         austinyhc/alpine-mariadb-py
```

Creating your own database with a user/password assigned to it:

```sh
$ docker run -it --rm --name=db \
         -e MYSQL_USER=foo \
         -e MYSQL_DATABASE=bar \
         -e MYSQL_PASSWORD=baz \
         austinyhc/alpine-mariadb-py
```

The `root` user is intentionally left password-less. Should you insist setting one, pass `MYSQL_ROOT_PASSWORD` at initialization stage:

```sh
$ docker run -it --rm --name=db \
         -e MYSQL_ROOT_PASSWORD=secretsauce \
         austinyhc/alpine-mariadb-py
```

Using a volume to persist your storage across restarts:

```sh
$ docker volume create db
db
$ docker run -it --rm --name=db \
         -v db:/var/lib/mysql \
         austinyhc/alpine-mariadb-py
```