#!/bin/bash

MAIL=stefano.scipioni@csgalileo.org

DOMAIN=$1
CWD=$(pwd -P)

mkdir -p etc/letsencrypt var/lib/letsencrypt

docker run -it --rm --name certbot \
  -v "$CWD/dns-key.ini:/tmp/dns-key.ini" \
  -v "$CWD/etc/letsencrypt:/etc/letsencrypt" \
  -v "$CWD/var/lib/letsencrypt:/var/lib/letsencrypt" \
  certbot/dns-rfc2136 certonly $DRYRUN \
    --dns-rfc2136 \
    --dns-rfc2136-credentials /tmp/dns-key.ini \
    --dns-rfc2136-propagation-seconds 30 -n --agree-tos --no-eff-email \
    --email $MAIL \
    -d $DOMAIN

