# https://hub.docker.com/_/alpine
FROM alpine:3.14.0

RUN apk add --no-cache dovecot dovecot-lmtpd bash && \
    adduser -h /home/vmail -D -s /sbin/nologin -u 2000 vmail

COPY dovecot.conf   /etc/dovecot/dovecot.conf
COPY dovecot-passwd /etc/dovecot/dovecot-passwd

# lmtp imap
EXPOSE 24 143
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
