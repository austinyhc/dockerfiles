FROM mcr.microsoft.com/windows/servercore:ltsc2019

ARG VCS_REF
ARG BUILD_DATE
ENV NUITKA_VERSION 0.6.8.4

MAINTAINER Austin Chen <austin.yhc@gmail.com>
LABEL org.label-schema.name="Docker Nuitka Build Base" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$NUITKA_VERSION \
      org.label-schema.description="Docker Image premade with Python3, docker.io and nuitka compiler"

RUN powershell -Command Set-ExecutionPolicy AllSigned
RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
#RUN powershell -Command wget https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/sjlj/x86_64-8.1.0-release-win32-sjlj-rt_v6-rev0.7z -o ./x86_64-8.1.0-release-win32-sjlj-rt_v6-rev0.7z
RUN powershell -Command choco install -y git; choco install -y vim; choco install -y python --version=3.8.10; choco install -y 7zip.install
RUN powershell -Command pip install Nuitka


