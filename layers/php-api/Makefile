.DEFAULT_GOAL := build
.PHONY: publish build

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-api

build:
	docker build \
	-t ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	--target base \
	${CURDIR}

publish: build
	docker push ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}