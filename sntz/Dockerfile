FROM ubuntu:20.04

LABEL maintainer="Austin Chen <austin.yhc@gmail.com>"

RUN dpkg --configure -a && \
    apt-get update --fix-missing && \
    apt-get -y upgrade && \
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
        libffi-dev \
        zlib1g-dev \
        libcurl4-openssl-dev \
        libsqlite3-dev \
        pkg-config \
        libnotify-dev \
        gnupg2 \
        python3-dev \
        python3-pip \
        software-properties-common \
        pandoc \
        && \
    $GIT_CLONE https://github.com/sstephenson/ruby-build.git \
                /root/.rbenv/plugins/ruby-build && \
    /root/.rbenv/plugins/ruby-build/install.sh

RUN /bin/bash -c "echo 'deb https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_20.04/ ./' >> /etc/apt/sources.list" && \
    /bin/bash -c "wget https://download.opensuse.org/repositories/home:/npreining:/debian-ubuntu-onedrive/xUbuntu_20.04/Release.key" && \
    /bin/bash -c "apt-key add ./Release.key" && \
    /bin/bash -c "apt-get update" && \
    /bin/bash -c "apt install -y onedrive"

ENV PATH /root/.rbenv/bin:$PATH

RUN PIP_INSTALL="python3 -m pip --no-cache-dir install --upgrade" && \
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
        nbdev \
        nbconvert \
        && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
