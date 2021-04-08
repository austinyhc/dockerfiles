FROM python:3.9.2-slim-buster

LABEL maintainer="Austin Chen <austin.yhc@gmail.com>"

RUN apt-get update --fix-missing && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        gcc \
        libmariadb-dev-compat \
        && \
    $PIP_INSTALL \
        pip \
        fastapi \
        uvicorn[standard] \
        gunicorn \
        mysqlclient \
        sqlalchemy \
        python-multipart \
        pyyaml \
        ujson \
        "pydantic>=1.2.0,<2.0.0" \
        inflection \
        && \
    apt-get autoremove -y build-essential gcc && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

COPY sh/start.sh /start.sh
COPY gunicorn_conf.py /gunicorn_conf.py
COPY sh/start-reload.sh /start-reload.sh
RUN chmod +x /start.sh && chmod +x /start-reload.sh

EXPOSE 80

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
CMD ["/start.sh"]
