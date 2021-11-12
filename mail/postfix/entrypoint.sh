#!/bin/bash

# config
for VARIABLE in `env | cut -f1 -d=`; do
  VAR=${VARIABLE//:/_}
  sed -i "s={{ $VAR }}=${!VAR}=g" /etc/postfix/main.cf
  cd /etc/postfix
  sed -i "s={{ $VAR }}=${!VAR}=g" $(find | grep \_maps)
done

# create vhost
#VHOST_PATH=/var/mail/vhosts/$DOMAIN
#if [ ! -d "$VHOST_PATH" ]; then
#  mkdir -p $VHOST_PATH
#fi

# permissons
chmod -R 777 /var/mail
chmod 744 /etc/postfix/*maps

/usr/sbin/postfix start-fg
