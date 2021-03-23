FROM tensorflow/tensorflow

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    $PIP_INSTALL \
        jupyterlab \
        jupyterlab_vim \
        watchdog
