# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (apt)
# jupyter       latest (pip)
# pytorch       latest (pip)
# tensorflow    latest (pip)
# jupyterlab    latest (pip)
# keras         latest (pip)
# opencv        4.0.1  (git)
# ==================================================================

FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

# ==================================================================
# Set the locale
# ------------------------------------------------------------------
RUN apt-get update --fix-missing && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:apt-fast/stable && \
    apt-get update --fix-missing && \
    echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections && \
    echo debconf apt-fast/dlflag boolean true | debconf-set-selections    && \
    echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections && \
    apt-get -y install apt-fast && \
    apt-fast clean && \
    apt-fast update --fix-missing && \
    apt-fast install -y locales && \
    locale-gen en_US.UTF-8

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    LC_ALL='en_US.UTF-8'
    #PATH=~/s4tf/bin:"${PATH}"

RUN APT_INSTALL="apt-fast install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --recurse-submodules --depth 10 -j8" && \

    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \

    apt-fast update --fix-missing && \

# ==================================================================
# tools
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        apt-utils \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        libncurses5-dev \
        libncursesw5-dev \
        htop \
        curl \
        tmux \
        ctags \
        cscope \
        libpython-dev \
        libpython3-dev \
        libblocksruntime-dev \
        ninja-build \
        clang \
        uuid-dev \
        libicu-dev \
        icu-devtools \
        libedit-dev \
        libxml2-dev \
        libsqlite3-dev \
        swig \
        pkg-config \
        libcurl4-openssl-dev \
        systemtap-sdt-dev \
        tzdata \
        rsync \
        sox \
        libsox-dev \
        libsox-fmt-all \
        libblocksruntime-dev \
        && \

# ==================================================================
# python
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-fast update --fix-missing && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.6 \
        python3.6-dev \
        python3-distutils-extra \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    $PIP_INSTALL \
        setuptools \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        cloudpickle \
		scikit-image>=0.14.2 \
        scikit-learn \
        matplotlib \
        Cython \
        && \

# ==================================================================
# dotvim
# ------------------------------------------------------------------
    $GIT_CLONE https://github.com/austinyhc/dotvim.git  ~/.vim && \
    unlink ~/.bashrc && \
    ln -s ~/.vim/bashrc ~/.bashrc && \
    ln -s ~/.vim/vimrc ~/.vimrc && \

# ==================================================================
# boost
# ------------------------------------------------------------------

	wget -O ~/boost.tar.gz https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz && \
    tar -zxf ~/boost.tar.gz -C ~ && \
    cd ~/boost_* && \
    ./bootstrap.sh --with-python=python3.6 && \
    ./b2 install -j"$(nproc)" --prefix=/usr/local && \

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

    $GIT_CLONE --branch 4.1.2 https://github.com/opencv/opencv ~/opencv && \
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
# pytorch \ fastai
# ------------------------------------------------------------------

    $PIP_INSTALL \
        future \
        numpy \
        protobuf \
        enum34 \
        pyyaml \
        typing \
        dataclasses \
        fastprogress \
        && \
    $PIP_INSTALL \
        torch torchvision\
        && \

# ==================================================================
# tensorflow
# ------------------------------------------------------------------

    $PIP_INSTALL \
        tensorflow-gpu \
        && \

# ==================================================================
# nvtop
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libncurses5-dev \
        libncursesw5-dev \
        && \
    $GIT_CLONE https://github.com/Syllo/nvtop.git ~/nvtop && \
    mkdir -p ~/nvtop/build && cd ~/nvtop/build && \
    cmake .. && \
    make -j"$(nproc)" install && \

# ==================================================================
# jupyterlab and extensions
# ------------------------------------------------------------------

    curl -sL https://deb.nodesource.com/setup_11.x  | bash - \
        && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        nodejs \
        && \
    $PIP_INSTALL \
        jupyterlab==1.2.11 \
        && \
    jupyter labextension install @jupyterlab/toc && \
    jupyter labextension install @axlair/jupyterlab_vim  && \

# ==================================================================
# customization
# ------------------------------------------------------------------

    $PIP_INSTALL \
        fire \
        librosa \
        nvidia-ml-py3 \
        PyWavelets \
        seaborn \
		pytest-xdist \
        pytest-sugar \
        pytest-repeat \
        pytest-picked \
        pytest-forked \
        pytest-flakefinder \
        pytest-cov \
        nbsmoke \
        && \

# ==================================================================
# swift for tensorflow
# ------------------------------------------------------------------

    rm -rf /swift && \
    mkdir -p /swift/toolchain && \
    wget -nv -O- https://storage.googleapis.com/swift-tensorflow-artifacts/releases/v0.8/rc1/swift-tensorflow-RELEASE-0.8-cuda10.0-cudnn7-ubuntu18.04.tar.gz | tar xzf - -C /swift/toolchain && \

    wget -nv -O- https://storage.googleapis.com/swift-tensorflow-artifacts/releases/v0.8/rc1/swift-jupyter.tar.gz | tar xzf - -C /swift && \
    python3.6 /swift/swift-jupyter/register.py --swift-toolchain /swift/toolchain && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-fast clean && \
    apt-fast autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

