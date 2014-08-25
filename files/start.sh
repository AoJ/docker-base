#!/usr/bin/env bash


/opt/install.sh

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
