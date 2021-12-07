# https://hub.docker.com/_/alpine/
FROM alpine:3.14.3

WORKDIR /test
RUN apk add --no-cache curl \
  && curl -O https://dl.minio.io/client/mc/release/linux-amd64/mc \
  && chmod +x mc \
  && wget https://github.com/restic/restic/releases/download/v0.12.1/restic_0.12.1_linux_amd64.bz2 \
  && bzip2 -dk restic_0.12.1_linux_amd64.bz2 \
  && mv restic_0.12.1_linux_amd64 restic \
  && rm restic_* \
  && chmod +x restic

