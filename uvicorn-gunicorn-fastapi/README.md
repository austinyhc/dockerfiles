# Docker image for sntz

The goal of this project is to create a pull-and-use docker image for setting up a server that can store waveform data for data science. The base image is from my other docker image [austinyhc/alpine-mariadb-py](https://hub.docker.com/repository/docker/austinyhc/alpine-mariadb-py), which is designed as a bite-sized, fast startup docker image for [MariaDB](https://mariadb.org/) plus container-friendly Linux distribution [Alpine Linux](https://alpinelinux.org/) and prebuilt with Python.

Licensed under [MIT](https://github.com/jbergstroem/mariadb-alpine/blob/master/LICENSE).

## Features

- Support multi-architecture build

## Usage

For those configuration related to database, you can refer to the [documentation](https://github.com/austinyhc/dockerfiles/tree/master/alpine-mariadb-py#usage) in [austinyhc/alpine-mariadb-py](https://hub.docker.com/repository/docker/austinyhc/alpine-mariadb-py). In the following example, I will assume we are using a named volume to persist my storage across restarts.

Create a volume:

```sh
$ docker volume create db
db
```

The `root` user is intentionally left password-less. Should you insist setting one, pass `MYSQL_ROOT_PASSWORD` at initialization stage. Publish the port `3306` for MariaDB and port `80` for FastAPI.

```sh
$ docker run -it --rm --name=test \
         -e MYSQL_ROOT_PASSWORD=secretsauce \
         -p 3306:3306 \
         -p 80:80 \
         -v db:/var/lib/mysql \
         -v $PWD:/sntz \
         austinyhc/sntz:
```

## Test

This container image is tested with [`bats`](https://github.com/bats-core/bats-core) - a bash testing framework. Please find the [installation]([Install · bats-core/bats-core Wiki (github.com)](https://github.com/bats-core/bats-core/wiki/Install)) helpful. To test:

```sh
$ sh/build-image.sh
$ sh/run-tests.bash
 ✓ should output mysqld version
 ✓ start a default server with InnoDB and no password
 ✓ start a server without a dedicated volume (issue #1)
 ✓ start a server without InnoDB
 ✓ start a server with a custom root password
 ✓ start a server with a custom database
 ✓ start a server with a custom database, user and password
 ✓ verify that binary logging is turned off
 ✓ should allow a user to pass a custom config
 ✓ should import a .sql file and execute it
 ✓ should import a compressed file and execute it
 ✓ should execute an imported shell script

12 tests, 0 failures
```

