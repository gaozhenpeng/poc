#!/bin/bash

# config
for VARIABLE in `env | cut -f1 -d=`; do
  VAR=${VARIABLE//:/_}
  sed -i "s={{ $VAR }}=${!VAR}=g" /etc/dovecot/dovecot-passwd
done

/usr/sbin/dovecot -F
