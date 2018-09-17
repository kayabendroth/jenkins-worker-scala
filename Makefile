.PHONY: image build push


DOCKER_IMAGE_NAME=kayabendroth/jenkins-worker-scala
DOCKER_IMAGE_TAG=20180917

image:
	docker image build -f Dockerfile -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .
	docker tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) $(DOCKER_IMAGE_NAME):latest

build: image

push:
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
	docker push $(DOCKER_IMAGE_NAME):latest
