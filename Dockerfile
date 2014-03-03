# Docker base image
#
# VERSION 1.0

FROM ubuntu:12.04
MAINTAINER AooJ <aoj@n13.cz>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV HOME /root


# enable universe
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update


# Fix some issues with APT packages.
# See https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Upgrade all packages.
RUN echo "initscripts hold" | dpkg --set-selections
RUN apt-get upgrade -y --no-install-recommends

# install packages
RUN apt-get install -y --no-install-recommends apt-transport-https
RUN apt-get install -y --no-install-recommends net-tools nano wget curl openssh-server python-software-properties supervisor && apt-get clean

# Fix locale.
RUN apt-get install -y --no-install-recommends language-pack-en
RUN locale-gen en_US


# ssh
RUN mkdir /var/run/sshd
RUN mkdir -p /root/.ssh
RUN wget -q https://gist.githubusercontent.com/AoJ/9323875/raw/e1f179fd8d7650fae646e1b72f210b4417c6c36c/key.pub -O root/.ssh/authorized_keys
RUN chown root:root root/.ssh/authorized_keys
RUN dpkg-reconfigure openssh-server

# supervisor
RUN wget -q https://gist.githubusercontent.com/AoJ/9323875/raw/179575409db25e58c93c3220821de8d4b95ed4e3/supervisord.conf -O /etc/supervisor/conf.d/supervisord.conf

# start
RUN mkdir -p /opt/run
RUN wget -q https://gist.githubusercontent.com/AoJ/9323875/raw/828abcc60820273881c6a5f0bd4985a3667b84fd/start.sh -O /opt/start.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
	

