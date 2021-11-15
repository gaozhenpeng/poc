FROM alpine:latest

# https://github.com/helm/helm/releases
ENV HELM_VERSION 2.13.1

RUN apk add --no-cache --update \
    make ca-certificates openssl python git && \
    update-ca-certificates && \
    wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz && \
    tar zxvf google-cloud-sdk.tar.gz && \
    rm google-cloud-sdk.tar.gz && \
    ./google-cloud-sdk/install.sh --usage-reporting=false && \
    ./google-cloud-sdk/bin/gcloud --quiet components update && \
    ./google-cloud-sdk/bin/gcloud components install kubectl && \
    ln -fvs /google-cloud-sdk/bin/kubectl /usr/local/bin/kubectl && \
    cd /tmp && wget https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz && \
    tar -zxvf helm-v$HELM_VERSION-linux-amd64.tar.gz && \
    rm helm-v$HELM_VERSION-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm

# add gcloud to path
ENV PATH="/google-cloud-sdk/bin:${PATH}"

WORKDIR /google-cloud-sdk

EXPOSE 8080
