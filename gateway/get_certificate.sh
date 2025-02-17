#!/bin/bash

set -eux

if (( $? == 0 ))
then
  echo "Need at least one domain name." >/dev/stderr
  exit 1
fi

DOMAIN_CMD=""
for DOMAIN in $*
do
  DOMAIN_CMD="-d ${DOMAIN} ${DOMAIN_CMD}"
done

docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ --dry-run -d uklft-dg.swansea.ac.uk -d uklft-dg.swan.ac.uk -d uklft-dg.abertawe.ac.uk
