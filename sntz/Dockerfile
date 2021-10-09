FROM tensorflow/tensorflow:latest

LABEL maintainer="Austin Chen <austin.yhc@gmail.com>"

RUN dpkg --configure -a && \
    apt-get update --fix-missing && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    GIT_CLONE="git clone --recurse-submodules --depth 10 -j8" && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        make \
        gcc \
        git \
        libmariadb-dev-compat \
        libsndfile1 \
        unzip \
        unrar \
        p7zip-full \
        wget \
        curl  \
        vim \
        rbenv \
        libssl-dev \
        zlib1g-dev \
        && \
    $GIT_CLONE https://github.com/sstephenson/ruby-build.git \
                /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/plugins/ruby-build/install.sh

ENV PATH /root/.rbenv/bin:$PATH

RUN PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc && \
    /bin/bash -c "source /root/.bashrc" && \
    rbenv install 2.7.1 && rbenv global 2.7.1 && \
    $PIP_INSTALL \
        pip \
        "pygit2==1.6.1" \
        dvc[gdrive] \
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
        jupyterlab \
        jupyterlab_vim \
        watchdog \
        argh \
        fastprogress \
        typeguard \
        tensorflow-addons \
        tensorflow-hub \
        scikit-learn \
        "scikit-image>=0.14.2" \
        inflection \
        dataset \
        # Workaround for fastapi running on python 3.6
        async-exit-stack async-generator \
        librosa \
        xlrd \
        patool \
        pyunpack \
        checksumdir \
        openpyxl \
        && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
