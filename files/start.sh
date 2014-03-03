#!/usr/bin/env bash

RUN_DIR=/opt/run
LOG=/var/log/start
touch $LOG

chmod +x $RUN_DIR -R

if [ "$(ls -A $RUN_DIR)" ]; then

  for file in $RUN_DIR/*
  do
    /bin/sh -c $file >> $LOG
  done
fi

/usr/bin/supervisord >> $LOG &

tail -f $LOG