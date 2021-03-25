FROM tensorflow/tensorflow

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
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
        tensorflow-hub && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
