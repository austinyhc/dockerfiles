# ==================================================================
# module list
# ------------------------------------------------------------------
# darknet       latest (git)
# python        3.8    (apt)
# jupyter       latest (pip)
# pytorch       latest (pip)
# tensorflow    latest (pip)
# jupyterlab    latest (pip)
# opencv        4.5.4  (git)
# ==================================================================

FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04

ENV LANG C.UTF-8
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        apt-utils \
        ca-certificates \
        wget \
        git \
        vim \
        libssl-dev \
        curl \
        unzip \
        unrar \
        cmake \
        && \
# ==================================================================
# darknet
# ------------------------------------------------------------------
    $GIT_CLONE https://github.com/AlexeyAB/darknet ~/darknet && \
    cd ~/darknet && \
    sed -i 's/GPU=0/GPU=1/g' ~/darknet/Makefile && \
    sed -i 's/CUDNN=0/CUDNN=1/g' ~/darknet/Makefile && \
    make -j"$(nproc)" && \
    cp ~/darknet/include/* /usr/local/include && \
    cp ~/darknet/darknet /usr/local/bin && \
# ==================================================================
# python
# ------------------------------------------------------------------
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.8 \
        python3.8-dev \
        python3.8-distutils \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.8 ~/get-pip.py && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-image \
        scikit-learn \
        matplotlib \
        Cython \
        tqdm \
        && \
# ==================================================================
# boost
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libboost-all-dev \
        && \
# ==================================================================
# jupyter
# ------------------------------------------------------------------
    $PIP_INSTALL \
        jupyter \
        && \
# ==================================================================
# pytorch
# ------------------------------------------------------------------
    $PIP_INSTALL \
        future \
        numpy \
        protobuf \
        enum34 \
        pyyaml \
        typing \
        && \
    $PIP_INSTALL \
        --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116 \
        && \
# ==================================================================
# fastai
# ------------------------------------------------------------------
    $PIP_INSTALL \
        fastai \
        && \
# ==================================================================
# tensorflow
# ------------------------------------------------------------------
    $PIP_INSTALL \
        tensorflow-gpu \
        && \
# ==================================================================
# jupyterlab
# ------------------------------------------------------------------
    $PIP_INSTALL \
        jupyterlab \
        jupyterlab_vim \
        && \
# ==================================================================
# opencv
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libatlas-base-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        && \
    $GIT_CLONE --branch 4.5.4 https://github.com/opencv/opencv ~/opencv && \
    mkdir -p ~/opencv/build && cd ~/opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_IPP=OFF \
          -D WITH_CUDA=OFF \
          -D WITH_OPENCL=OFF \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          -D BUILD_DOCS=OFF \
          -D BUILD_EXAMPLES=OFF \
          .. && \
    make -j"$(nproc)" install && \
    ln -s /usr/local/include/opencv4/opencv2 /usr/local/include/opencv2 && \
# ==================================================================
# misc
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libsndfile-dev \
        && \
    $PIP_INSTALL \
        librosa \
        PyWavelets \
        seaborn \
        torchbearer \
        watchdog \
        kaggle \
        nbdev \
        && \
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

COPY kaggle /.kaggle
RUN chmod 600 /.kaggle/kaggle.json
