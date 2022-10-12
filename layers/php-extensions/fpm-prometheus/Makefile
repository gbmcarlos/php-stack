.DEFAULT_GOAL := build
.PHONY: publish build

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-ext-fpm-prometheus
export PHP_BASE_VERSION := ${IMAGE_TAG}

build:
	DOCKER_BUILDKIT=1 docker buildx build \
	--push \
	--platform linux/arm64,linux/amd64 \
	-t ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	--pull=false \
	--target base \
	--build-arg PHP_BASE_VERSION \
	${CURDIR}

publish: build
	docker push ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}