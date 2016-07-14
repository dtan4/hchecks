FROM scratch
MAINTAINER Daisuke Fujita <dtanshi45@gmail.com> (@dtan4)

COPY bin/hchecks-linux_amd64 /hchecks

EXPOSE 8080

CMD ["/hchecks"]
