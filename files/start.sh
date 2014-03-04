#!/usr/bin/env bash

RUN_DIR=/opt/run

chmod +x $RUN_DIR -R

if [ "$(ls -A $RUN_DIR)" ]; then

  for file in $RUN_DIR/*
  do
    /bin/sh -c $file
  done
fi

/usr/bin/supervisord
