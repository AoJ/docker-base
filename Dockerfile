# Docker base image
#
# VERSION 1.1

FROM ubuntu:12.04
MAINTAINER AooJ <aoj@n13.cz>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV HOME /root


ADD files/ /tmp
RUN chmod +x /tmp/install.sh && /tmp/install.sh

CMD ["/opt/start.sh"]
	
