# create one image in docker
# reuse performance fix

# enable universe
sed 's/main$/main universe/' -i /etc/apt/sources.list
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
apt-get install -y --no-install-recommends net-tools nano wget curl make gcc language-pack-en openssh-server python-software-properties supervisor && apt-get clean

# Fix locale.
locale-gen en_US


# ssh
mkdir /var/run/sshd
mkdir -p /root/.ssh
wget -q https://gist.githubusercontent.com/AoJ/9323875/raw/e1f179fd8d7650fae646e1b72f210b4417c6c36c/key.pub -O root/.ssh/authorized_keys
chown root:root root/.ssh/authorized_keys
dpkg-reconfigure openssh-server

# supervisor
cp /tmp/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start
mkdir -p /opt/run
cp /tmp/start.sh /opt/start.sh
chmod +x /opt/start.sh

# clean up
rm /tmp -rf

