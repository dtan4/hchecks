BINARY := hchecks
BINARY_LINUX_AMD64 = $(BINARY)-linux_amd64

DOCKER_IMAGE_NAME := quay.io/dtan4/hchecks
DOCKER_IMAGE_TAG := latest
DOCKER_IMAGE = $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

build: clean
	go build -o bin/$(BINARY)

build-linux: clean
	GOOS=linux GOARCH=amd64 go build -o bin/$(BINARY_LINUX_AMD64)

ci-docker-push: docker-release-build
	@docker login -e="$(DOCKER_QUAY_EMAIL)" -u="$(DOCKER_QUAY_USERNAME)" -p="$(DOCKER_QUAY_PASSWORD)" quay.io
	docker push $(DOCKER_IMAGE)

docker-build: clean
	docker build -t $(DOCKER_IMAGE) .

docker-release-build: build-linux
	docker build -f Dockerfile.release -t $(DOCKER_IMAGE) .

docker-push:
	docker push $(DOCKER_IMAGE)

clean:
	rm -f bin/$(BINARY)
	rm -f bin/$(BINARY_LINUX_AMD64)

test:
	go test

PHONY: build build-linux clean docker-build docker-release-build test
