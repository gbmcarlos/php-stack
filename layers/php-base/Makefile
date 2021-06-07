.DEFAULT_GOAL := build
.PHONY: build publish

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-base

build:
	docker build \
	-t ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	--target base \
	--build-arg COMPOSER_VERSION \
	--build-arg PHP_VERSION \
	--build-arg PHP_VERSION_SHORT \
	--build-arg BREF_VERSION \
	${CURDIR}

publish: build
	docker push ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}
