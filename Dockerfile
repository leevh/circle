FROM leevh/dind-ubuntu:phusion-base-overlay

RUN apt-get update -qq && apt-get install -qqy \
    iptables \
    bridge-utils \
    cgroup-bin \
    xvfb \
    xdg-utils \
    sudo

RUN DISPLAY=:1.0 && export DISPLAY \

# Setup a non root user
&& adduser --disabled-password --gecos '' ci && adduser ci sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
&& sudo usermod -aG docker ci

USER ci
WORKDIR "/home/ci"

VOLUME /var/lib/docker

RUN curl -fsSL get.docksal.io | sh
