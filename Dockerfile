FROM ubuntu:xenial

RUN apt-get update -qq && apt-get install -qqy \
    iptables \
    bridge-utils \
    cgroup-bin \
    xvfb \
    xdg-utils \
    sudo \
    uuid-runtime

RUN DISPLAY=:1.0 && export DISPLAY \

# Setup a non root user
&& adduser --disabled-password --gecos '' ci && adduser ci sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
&& sudo groupadd docker && sudo usermod -aG docker ci

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


VOLUME /var/lib/docker

USER ci
WORKDIR "/home/ci"

ADD setup_docksal.sh /home/ci/setup_docksal.sh

ADD daemonup /usr/share/kalabox/scripts/daemonup
