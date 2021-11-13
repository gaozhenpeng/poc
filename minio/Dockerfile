# https://hub.docker.com/_/alpine/
FROM alpine:3.14.3

WORKDIR /test
RUN apk add --no-cache curl \
  && curl -O https://dl.minio.io/client/mc/release/linux-amd64/mc \
  && chmod +x mc

