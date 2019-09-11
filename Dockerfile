FROM golang:alpine AS build

RUN apk add --no-cache curl tar
RUN mkdir -p /go/github.com/jedisct1/dnscrypt-proxy
RUN curl --silent -L https://github.com/jedisct1/dnscrypt-proxy/archive/2.0.27.tar.gz | tar -C /go/github.com/jedisct1/dnscrypt-proxy --strip-components=1 -xzvf -
WORKDIR /go/github.com/jedisct1/dnscrypt-proxy/dnscrypt-proxy
RUN go install -ldflags "-s -w"

FROM alpine:3.10
RUN apk add --no-cache bind-tools
COPY --from=build /go/bin/dnscrypt-proxy /usr/bin/
COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

ENTRYPOINT ["/usr/bin/dnscrypt-proxy"]
CMD ["-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]

HEALTHCHECK CMD host -t A one.one.one.one || exit 1

