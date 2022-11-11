FROM golang:1.16.5-alpine3.12@sha256:db2475a1dbb2149508e5db31d7d77a75e6600d54be645f37681f03f2762169ba AS build

RUN apk add --no-cache curl tar
RUN mkdir -p /go/github.com/DNSCrypt/dnscrypt-proxy
RUN curl --silent -L https://github.com/DNSCrypt/dnscrypt-proxy/archive/2.1.2.tar.gz | tar -C /go/github.com/DNSCrypt/dnscrypt-proxy --strip-components=1 -xzvf -
WORKDIR /go/github.com/DNSCrypt/dnscrypt-proxy/dnscrypt-proxy
RUN go install -ldflags "-s -w"

FROM alpine:3.16.2@sha256:65a2763f593ae85fab3b5406dc9e80f744ec5b449f269b699b5efd37a07ad32e
RUN apk add --no-cache bind-tools
COPY --from=build /go/bin/dnscrypt-proxy /usr/bin/
COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

ENTRYPOINT ["/usr/bin/dnscrypt-proxy"]
CMD ["-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]

HEALTHCHECK CMD host -t A one.one.one.one || exit 1

