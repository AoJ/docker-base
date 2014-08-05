#!/bin/bash
set -e

apt-get update


# Fix some issues with APT packages.
# See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

# Upgrade all packages.
echo "initscripts hold" | dpkg --set-selections
apt-get upgrade -y --no-install-recommends

# install packages
apt-get install -y --no-install-recommends apt-transport-https
apt-get install -y --no-install-recommends net-tools nano wget curl openssh-server python-software-properties
apt-get install -y --no-install-recommends supervisor screen
apt-get clean
