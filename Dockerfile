# Docker base image
#
# VERSION 1.10

FROM ubuntu:14.04
MAINTAINER AooJ <aoj@n13.cz>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV HOME /root
ENV CONFD_VERSION 0.6.3


# enable universe
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

# copy files
ADD install /tmp/install
RUN chmod +x /tmp/install/*
RUN /tmp/install/dependencies.sh
RUN /tmp/install/prepare.sh
RUN rm /tmp/install -rf

# supervisor
ADD files/supervisord.conf /etc/supervisord.conf

# screen
ADD files/screenrc /root/.screenrc

# start & install
ADD files/start.sh /opt/start.sh
ADD files/install.sh /opt/install.sh
RUN mkdir -p /opt/run
RUN chmod +x /opt/install.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
