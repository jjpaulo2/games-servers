FROM alpine:3.23

RUN \
    apk update && \
    apk add --no-cache curl bash jq zip && \
    rm -rf /var/cache/apk/*

WORKDIR /srv
