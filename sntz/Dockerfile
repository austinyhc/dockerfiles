FROM austinyhc/sensorai:3165199

LABEL maintainer="Austin Chen <austin.yhc@gmail.com>"

RUN dpkg --configure -a && \
    apt-get update --fix-missing && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        gcc \
        libmariadb-dev-compat \
        libsndfile1 \
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
        numpy \
        pandas \
        scipy \
        matplotlib \
        scikit-learn \
        "scikit-image>=0.14.2" \
        inflection \
        dataset \
        # Workaround for fastapi running on python 3.6
        async-exit-stack async-generator \
        librosa \
        && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
