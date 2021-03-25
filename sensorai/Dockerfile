FROM tensorflow/tensorflow:latest

RUN apt-get update --fix-missing && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    GIT_CLONE="git clone --recurse-submodules --depth 10 -j8" && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        vim git wget curl rbenv \
        gcc make libssl-dev zlib1g-dev \
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
        pandas \
        matplotlib \
        nbdev \
        matplotlib \
        jupyterlab \
        jupyterlab_vim \
        watchdog \
        pyyaml \
        argh \
        fastcore \
        fastprogress \
        numba \
        typeguard \
        tensorflow-addons \
        tensorflow-hub \
        && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
