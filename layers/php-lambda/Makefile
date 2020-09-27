.DEFAULT_GOAL := build
.PHONY: build extract package publish

export DOCKER_BUILDKIT ?= 1
export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

export IMAGE_REPO := php-lambda

build:
	docker build \
	-t ${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	--target base \
	${CURDIR}

# Run an ephemeral container of PHP to extract the necessary files into a zip
extract: build
	docker run \
	--rm \
	-v ${CURDIR}:/var/mount \
	--entrypoint /bin/sh \
	${IMAGE_USER}/${IMAGE_REPO}:${IMAGE_TAG} \
	-c "cd /opt; zip -r /var/mount/php-runtime.zip ./bin ./bootstrap ./bref"

package: extract
	aws cloudformation package \
     	--template-file sam.yaml \
     	--s3-bucket ${SAM_ARTIFACTS_BUCKET} \
     	--output-template-file sam-output.yaml

# Package the SAM template
publish: package
	docker push ${IMAGE_REPO}
