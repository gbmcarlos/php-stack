.DEFAULT_GOAL := build
.PHONY: build extract package publish

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-lambda

build:
	docker build \
	-t ${IMAGE_USER}/${IMAGE_REPO} \
	--target base \
	${CURDIR}

# Run an ephemeral container of PHP to extract the necessary files into a zip
extract: build
	docker run \
	--rm \
	-v ${CURDIR}:/var/mount \
	--entrypoint /bin/sh \
	${IMAGE_USER}/${IMAGE_REPO} \
	-c "cd /opt; zip -r /var/mount/php-runtime.zip ./bin ./bootstrap ./bref"

package: extract
	aws cloudformation package \
     	--template-file sam.yaml \
     	--s3-bucket ${SAM_ARTIFACTS_BUCKET} \
     	--output-template-file sam-output.yaml

publish: package
	docker tag ${IMAGE_USER}/${IMAGE_REPO} ${IMAGE_USER}/${IMAGE_REPO}:latest
	docker tag ${IMAGE_USER}/${IMAGE_REPO} ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG}
	docker push ${IMAGE_USER}/${IMAGE_REPO}
