FROM mcr.microsoft.com/windows/servercore:ltsc2022

ARG VCS_REF
ARG BUILD_DATE
ENV NUITKA_VERSION 0.6.8.4

MAINTAINER Austin Chen <austin.yhc@gmail.com>
LABEL org.label-schema.name="Docker Nuitka Build Base" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$NUITKA_VERSION \
      org.label-schema.description="Docker Image premade with Python3, docker.io and nuitka compiler"

RUN Set-ExecutionPolicy AllSigned
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
RUN choco install -y git
RUN choco install -y python --version=3.8.10
RUN pip install Nuitka
