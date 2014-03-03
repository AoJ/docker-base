# Docker base image

docker base image for my usage

## Usage

### in Dockerfile
    FROM aooj/base:latest

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
- change FROM to https://github.com/AoJ/docker-base.git
- make tests

## Changelog
- 1.5 remove my public key in ssh
- 1.4 remove make, gcc
- 1.3 supervisor listen to SIG*
- 1.2 remove gists dependencies
- 1.1 minor fixies
- 1.0 first realese
