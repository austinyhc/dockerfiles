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
        texlive-xetex \
        texlive-plain-generic \
        ssh \
        gosu \
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
RUN rm -rf /var/lib/apt/lists/* /tmp/* ~/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
