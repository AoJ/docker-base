NAME ?= aooj/base
VERSION ?= slim

build:
	docker build --rm -t $(NAME):$(VERSION) .

debug: build
	docker run --rm -t -i $(NAME):$(VERSION)

.PHONY: build debug
