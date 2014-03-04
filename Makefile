# Project: docker base
# Author: AooJ <aooj@n13.cz>
# Date: 2014
# usage:
#	make build	- build new image from Dockerfile
#	make run	- debug run already created image by tag
#	make debug	- build and run bash in docker, dont run /run/start.sh


NAME=aooj/base
VERSION=1.6


build:
	docker build -t $(NAME):$(VERSION) .


run:
	docker run -p 22 -t -i $(NAME):$(VERSION)

debug: build
	docker run -p 22 -t -i $(NAME):$(VERSION) /bin/bash	

tag:
	docker tag $(NAME):$(VERSION) $(NAME):$(VERSION)
	docker tag $(NAME):$(VERSION) $(NAME):latest

release: tag
	@if ! docker images aooj/base | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME):$(VERSION) is not yet built. Run 'make build'"; false; fi
	docker push $(NAME)
	@echo "Now create a tag in repository. git tag $(VERSION)"


ssh:
	@ID=$$(docker ps | grep -F "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		IP=$$(docker inspect $$ID | grep IPAddr | sed 's/.*: "//; s/".*//') && \
		echo "SSHing into $$IP" && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost

.PHONY: build run debug ssh tag
