#!/bin/bash

set -eux

HOSTNAME=$1

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./ssl/private/nginx-selfsigned.key -out ./ssl/certs/nginx-selfsigned.crt -subj "/CN=${HOSTNAME}"
