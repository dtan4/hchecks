BINARY := hchecks
BINARY_LINUX_AMD64 = $(BINARY)-linux_amd64

DOCKER_IMAGE_NAME := quay.io/dtan4/hchecks
DOCKER_IMAGE_TAG := latest
DOCKER_IMAGE = $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

build: clean
	go build -o bin/$(BINARY)

build-linux: clean
	GOOS=linux GOARCH=amd64 go build -o bin/$(BINARY_LINUX_AMD64)

ci-docker-push: docker-build
	@docker login -e="$(DOCKER_QUAY_EMAIL)" -u="$(DOCKER_QUAY_USERNAME)" -p="$(DOCKER_QUAY_PASSWORD)" quay.io
	docker push $(DOCKER_IMAGE)

clean:
	rm -fr bin

docker-build: build-linux
	docker build -t $(DOCKER_IMAGE) .

docker-push:
	docker push $(DOCKER_IMAGE)

test:
	go test

PHONY: build build-linux ci-docker-push clean docker-build test
