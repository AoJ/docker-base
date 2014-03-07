# Docker base image

docker base image for my usage


## Usage

    FROM aooj/base:latest

install your own service

    RUN apt-get install -y redis
    
add some install script. Install scripts are fired for first start

    ADD files/my.sh /opt/run/my.sh
    
add config for supervisord

    ADD files/my.conf /etc/supervisor/conf.d/my.conf

expose it

    EXPOSE 6379


### install script should look like

    #!/usr/bin/env bash
    
    TOUCH /var/tmp/foo
    echo "bar" >> /var/tmp/foo
    
- install scripts must exit=0
- all stdout is logged to logfile in /var/log/start and docker logs


### supervisord script should look like

    [program:sshd]
    command=/usr/my_program
    
### examples
see example in https://github.com/AoJ/docker-redis

## Develop


### build
    git clone https://github.com/AoJ/docker-base.git
    make build
    
### and start it
    make run

### build, start and attach
    make debug

## Tips
- set your own ssh key to container. In Dockerfile fill authorized_keys like this:
    ADD my_rsa_pub root/.ssh/authorized_keys

    
## TODO
- change FROM to https://github.com/phusion/baseimage-docker
- make tests


## Changelog
- 1.7 refactor install scripts
- 1.5 remove my public key in ssh
- 1.4 remove make, gcc
- 1.3 supervisor listen to SIG*
- 1.2 remove gists dependencies
- 1.1 minor fixies
- 1.0 first realese
