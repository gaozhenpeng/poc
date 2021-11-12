# https://hub.docker.com/_/alpine
FROM alpine:3.14.0

RUN apk add --no-cache postfix bash

COPY entrypoint.sh /entrypoint.sh
COPY main.cf /etc/postfix/main.cf
COPY valias_maps /etc/postfix/valias_maps
COPY transport_maps /etc/postfix/transport_maps

# create self signed cert
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mail.key -out mailcert.pem
COPY mail.key /etc/ssl/private/mail.key
COPY mailcert.pem /etc/ssl/certs/mailcert.pem

# smtp
EXPOSE 25
ENTRYPOINT ["/entrypoint.sh"]
