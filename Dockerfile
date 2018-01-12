FROM golang:1.9 AS builder

LABEL maintainer="Filip Tepper https://github.com/filiptepper/docker-bitly-oauth2-proxy"

WORKDIR /go/src/github.com/bitly/oauth2_proxy

COPY oauth2_proxy .

RUN go get -d -v; \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo . ; \
    curl -o ca-certificates.crt https://curl.haxx.se/ca/cacert.pem;

FROM scratch

COPY --from=builder /go/src/github.com/bitly/oauth2_proxy/oauth2_proxy /bin/oauth2_proxy
COPY --from=builder /go/src/github.com/bitly/oauth2_proxy/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 4180

ENTRYPOINT ["/bin/oauth2_proxy"]
