#!/bin/bash
set -e

apt-get update


# Fix some issues with APT packages.
# See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

# Upgrade all packages.
echo "initscripts hold" | dpkg --set-selections
apt-get upgrade -y -qq -u --no-install-recommends

# install packages
apt-get install -y -qq --no-install-recommends apt-transport-https software-properties-common
apt-get install -y -qq --no-install-recommends net-tools nano wget curl openssh-server python-software-properties
apt-get install -y -qq --no-install-recommends make screen python-pip git-core
apt-get clean

pip install supervisor

apt-get remove -y python-pip

#confd
wget -q -O /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64
chmod +x /usr/bin/confd
mkdir -p /etc/confd/{templates,conf.d}
