build: clean
	go build -o bin/hchecks

build-linux: clean
	GOOS=linux GOARCH=amd64 go build -o bin/hchecks-linux_amd64

clean:
	rm -f bin/hchecks
	rm -f bin/hchecks-linux_amd64

test:
	go test

PHONY: build build-linux clean
