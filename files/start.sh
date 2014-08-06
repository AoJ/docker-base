#!/usr/bin/env bash


/opt/install.sh

/usr/bin/supervisord -c /etc/supervisor/conf.d/*
