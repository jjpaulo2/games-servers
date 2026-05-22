FROM alpine:3.23

RUN \
    apk update && \
    apk add --no-cache curl bash jq && \
    rm -rf /var/cache/apk/*

COPY scripts/* /app

WORKDIR /app
