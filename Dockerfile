# Docker base image
#
# VERSION 1.4

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
ADD files/key.pub root/.ssh/authorized_keys
RUN chown root:root root/.ssh/authorized_keys
RUN dpkg-reconfigure openssh-server

# supervisor
ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start
RUN mkdir -p /opt/run
ADD files/start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
	

