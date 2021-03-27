# Docker image for uvicorn-gunicorn-fastapi

The goal of this project is to create a docker image with [**Uvicorn**](https://www.uvicorn.org/) managed by [**Gunicorn**](https://gunicorn.org/) for high-performance [**FastAPI**](https://fastapi.tiangolo.com/) web applications in **[Python](https://www.python.org/) 3.9.2 with performance auto-tuning based on  [Alpine Linux](https://alpinelinux.org/).

Licensed under [MIT](https://github.com/jbergstroem/mariadb-alpine/blob/master/LICENSE).

## Features

- Support multi-architecture build
- **Uvicorn**:  A lightning-fast "ASGI" server runs asynchronous Python web code in a single process.
- **Gunicorn**: Manage Uvicorn and run multiple of these concurrent processes. That way, you get the best of concurrency and parallelism.
- **Fastapi**: A modern, fast (high-performance), web framework for building APIs

## Usage

For example, instead of running:

```sh
$ docker run -d -p 80:80 myimage
```

You could run:

```sh
$ docker run -d -p 80:80 -v $(pwd):/app myimage /start-reload.sh
```

* `-v $(pwd):/app`: means that the directory `$(pwd)` should be mounted as a volume inside of the container at `/app`.
    * `$(pwd)`: runs `pwd` ("print working directory") and puts it as part of the string.
* `/start-reload.sh`: adding something (like `/start-reload.sh`) at the end of the command, replaces the default "command" with this one. In this case, it replaces the default (`/start.sh`) with the development alternative `/start-reload.sh`.

## Test