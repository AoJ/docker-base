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

    
## TODO
- change FROM to https://github.com/AoJ/docker-base.git


## Changelog
- 1.4 remove make, gcc
- 1.3 supervisor listen to SIG*
- 1.2 remove gists dependencies
- 1.1 minor fixies
- 1.0 first realese
