#!/bin/bash
set -e


# Fix locale.
apt-get install -y --no-install-recommends language-pack-en
locale-gen en_US


# ssh
mkdir /var/run/sshd
mkdir -p /root/.ssh
touch root/.ssh/authorized_keys
chown root:root root/.ssh/authorized_keys
dpkg-reconfigure openssh-server
