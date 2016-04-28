FROM alpine:3.3
MAINTAINER Daisuke Fujita <dtanshi45@gmail.com> (@dtan4)

COPY . /go/src/github.com/dtan4/hchecks
RUN apk --update add git go make mercurial && \
    export GOPATH=/go && \
    cd /go/src/github.com/dtan4/hchecks && \
    make build-linux && \
    mkdir /app && \
    cp bin/hchecks-linux_amd64 /app/hchecks && \
    cd /app && \
    rm -rf /go && \
    apk del --purge git go make mercurial && \
    rm -rf /var/cache/apk/*

WORKDIR /app

EXPOSE 8080

CMD ["./hchecks"]
