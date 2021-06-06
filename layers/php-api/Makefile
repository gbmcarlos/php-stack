.DEFAULT_GOAL := build
.PHONY: publish build

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-api

export PHP_NGINX_VERSION := ${IMAGE_TAG}

build:
	docker build \
	-t ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	--target base \
	--build-arg PHP_NGINX_VERSION \
	${CURDIR}

publish: build
	docker push ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}