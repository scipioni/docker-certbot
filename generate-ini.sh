#!/bin/sh

conf=$1
DNS=$2

KEYNAME=$(sed -n "s/.*key \"\(.*\)\".*/\1/p" < $conf)
ALGO=$(sed -n "s/.*algorithm \(.*\);.*/\1/p" < $conf)
SECRET=$(sed -n "s/.*secret \"\(.*\)\";.*/\1/p" < $conf)

cat <<EOF
dns_rfc2136_server = ${DNS}
dns_rfc2136_port = 53
dns_rfc2136_name = $KEYNAME
dns_rfc2136_secret = $SECRET
dns_rfc2136_algorithm = $ALGO
EOF