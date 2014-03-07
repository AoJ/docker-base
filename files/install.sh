#!/usr/bin/env bash

RUN_DIR=/opt/run


if [ "$(ls -A $RUN_DIR)" ]; then

  echo "=> running install scripts"

  chmod +x $RUN_DIR -R
  for file in $RUN_DIR/*
  do
    /bin/sh -c $file
  done
  rm $RUN_DIR/* -rf
fi
