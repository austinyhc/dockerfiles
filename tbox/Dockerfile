FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

ENV CUDA_HOME=/usr/local/cuda

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    # Disabling SSL verification
    SSL_NO_VERIFY=1 \
    PYTHONDONTWRITEBYTECODE=true \
    PATH=/usr/local/cuda-11.1/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/cuda-11.1/lib64:$LD_LIBRARY_PATH \
    TZ=Asia/Taipei \
    APT_INSTALL="apt-get install -y --no-install-recommends" \
    PIP_INSTALL="python3 -m pip --no-cache-dir install --default-timeout=100" \
    GIT_CLONE="git clone --depth 10" \
    TENSORRT_VERSION="7.2.3-1+cuda11.1"

EXPOSE 8888 6006 8090

RUN rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update --fix-missing && \

# ==================================================================
# System Packages & Tools
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        apt-utils \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        pigz \
        ffmpeg \
        dbus \
        systemd \
        tzdata \
        python-tk \
        htop \
        tmux \
        unzip \
        python3-pip \
        python3-dev \
        python3-venv \
        python3-setuptools \
        python3-pybind11 \
        libblas-dev \
        liblapack-dev \
        libjpeg-dev \
        zlib1g-dev \
        libffi-dev \
        libopenblas-dev \
        # libopenexr-dev \
        python3-gi \
        nginx

# ==================================================================
# Essesntial Packages
# ------------------------------------------------------------------

RUN DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update --fix-missing && \
    python3 -m pip install --upgrade pip && \
    $PIP_INSTALL --upgrade \
        pip \
        setuptools==50.3.2 \
        future \
        protobuf \
        psutil \
        wheel \
        && \
    $PIP_INSTALL --upgrade \
        llvmlite \
        pythran \
        pybind11 \
        Cython \
        numpy \
        scipy \
        pandas==0.25.3 \
        cloudpickle \
        scikit-learn \
        matplotlib \
        seaborn \
        flask \
        gunicorn \
        && \

# ==================================================================
# Jupyter Notebook
# ------------------------------------------------------------------

    $PIP_INSTALL \
        jinja2==2.11.3 \
        MarkupSafe==2.0.1 \
        yapf==0.32.0 \
        ipywidgets==7.6.5 \
        jupyter==1.0.0 \
        jupyter_contrib_nbextensions==0.5.1 \
        jupyter_nbextensions_configurator==0.4.1 \
        jedi==0.17.2 \
        parso==0.7.1 \
        nbconvert==5.6.1 \
        && \
    jupyter contrib nbextension install --user && \
    jupyter nbextension enable code_prettify/code_prettify && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable toggle_all_line_numbers/main && \

    python3 -m pip --no-cache-dir install --default-timeout=100 \
        jupyterlab-server==2.10.3 \
        jupyterlab==3.2.5 \
        jupyterlab_vim

# ==================================================================
# Pytorch
# ------------------------------------------------------------------

RUN $PIP_INSTALL \
        torch==1.9.1+cu111 \
        torchvision==0.10.1+cu111 \
        -f https://download.pytorch.org/whl/torch_stable.html \
        && \
    python3 -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')" \
        && \

    $PIP_INSTALL \
        torchmetrics==v0.6.0 \
        pytorch-lightning==1.4.9 \
        torch_optimizer \
        torchinfo \
        && \
    python3 -c "import pytorch_lightning as pl; print(pl.__version__)"

# ==================================================================
# Tensorflow
# ------------------------------------------------------------------

RUN $PIP_INSTALL \
        h5py \
        tensorflow==2.4.0 \
        tensorflow-determinism \
        tensorflow-addons \
        tensorboard \
        && \
        python3 -c "import tensorflow as tf; print(tf.__version__)" \
        && \
    ln -s /usr/local/cuda-11.1/targets/x86_64-linux/lib/libcusolver.so.11 /usr/local/cuda-11.1/targets/x86_64-linux/lib/libcusolver.so.10

# ==================================================================
# MISC.
# ------------------------------------------------------------------

RUN $PIP_INSTALL \
        timm \
        yellowbrick \
        plotly \
        shap \
        albumentations \
        umap-learn \
        scikit-image \
        optuna \
        tsfresh \
        piq \
        dtw-python \
        grad-cam \
        lpips \
        pyinstaller[encryption]==4.10 \
        pyarmor==7.4.1 \
        # kornia \
        bm3d \
        typing_extensions==4.2.0

RUN pip uninstall -y opencv-python opencv-python-headless && \
    $PIP_INSTALL \
        "opencv-python-headless<4.3" && \
    python3 -c "import cv2; print(cv2.__version__)"

RUN cd /root/ && \
    wget https://download.pytorch.org/models/alexnet-owt-7be5be79.pth && \
    mkdir -p /root/.cache/torch/hub/checkpoints && \
    cp alexnet-owt-7be5be79.pth /root/.cache/torch/hub/checkpoints/ && \
    rm alexnet-owt-7be5be79.pth && \

    echo "\
unbind C-b\n\
set-option -g prefix C-a\n\
bind-key C-a send-prefix\n\
" > /root/.tmux.conf && \

# ==================================================================
# Config & Cleanup
# https://jcristharif.com/conda-docker-tips.html
# ------------------------------------------------------------------
    ldconfig && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \

    # apt-get remove -y build-essential cmake && \
    rm -rf /opt/cmake /usr/local/bin/cmake /usr/bin/cmake && \
    apt-get clean -y && \
    apt-get autoremove -y && \

    find /usr/local/lib/python3.*/ -follow -type f -name '*.a' -delete && \
    find /usr/local/lib/python3.*/ -follow -type f -name '*.pyc' -delete && \
    find /usr/local/lib/python3.*/ -follow -type f -name '*.js.map' -delete && \
    find /usr/local/lib/python3.*/ -name 'tests' -exec rm -r '{}' + && \
    find /usr/local/lib/python3.*/dist-packages/ -name '*.so' -print -exec sh -c 'file "{}" | grep -q "not stripped" && strip -s "{}"' \; && \

    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

