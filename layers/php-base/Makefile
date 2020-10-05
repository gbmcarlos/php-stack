.DEFAULT_GOAL := build
.PHONY: build publish test

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-base

build:
	docker build \
	-t ${IMAGE_USER}/${IMAGE_REPO} \
	--target base \
	${CURDIR}

publish: build
	docker tag ${IMAGE_USER}/${IMAGE_REPO} ${IMAGE_USER}/${IMAGE_REPO}:latest
	docker tag ${IMAGE_USER}/${IMAGE_REPO} ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}
	docker push ${IMAGE_USER}/${IMAGE_REPO}
