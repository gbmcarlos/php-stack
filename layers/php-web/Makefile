.DEFAULT_GOAL := build
.PHONY: publish build

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-web

export PHP_NGINX_VERSION := ${IMAGE_TAG}

build:
	docker buildx build \
	--push \
	--platform linux/arm64,linux/amd64 \
	-t ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	--target base \
	--build-arg PHP_NGINX_VERSION \
	--build-arg NODEJS_VERSION \
	${CURDIR}

publish: build
	docker push ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}