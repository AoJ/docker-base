# Docker base image
#
# VERSION 1.9

FROM ubuntu:14.04
MAINTAINER AooJ <aoj@n13.cz>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV HOME /root


# enable universe
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

# copy files
ADD install /tmp/install
RUN chmod +x /tmp/install/*
RUN /tmp/install/dependencies.sh
RUN /tmp/install/prepare.sh
RUN rm /tmp/install -rf

# supervisor
ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# screen
ADD files/screenrc /root/.screenrc

# start & install
ADD files/ /opt/
RUN mkdir -p /opt/run
RUN chmod +x /opt/install.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
