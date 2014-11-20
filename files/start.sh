#!/bin/sh


/opt/install.sh

supervisord -c /etc/supervisord.conf
