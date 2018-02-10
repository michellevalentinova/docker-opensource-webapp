#!/bin/bash

# based on https://github.com/kubernetes/kubernetes/blob/master/examples/https-nginx/Makefile
# Apache License, Version 2.0

set -uxe

# create temporary directory and ensure cleanup on exit
TMP_DIR=$(mktemp --directory)
trap "rm -rf -- '$TMP_DIR'" EXIT

# place everything under the temporary directory
KEY=$TMP_DIR/nginx.key
CERT=$TMP_DIR/nginx.crt
SECRET=$TMP_DIR/secret.json

# generate a self-signed HTTPS private key and certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY -out $CERT -subj "/CN=dow/O=dow"

# mapping $TMP_DIR to $TMP_DIR is safe as it doesn't exist in the container
sudo docker run --rm  --volume $TMP_DIR:$TMP_DIR --volume $(pwd):/app nandi108/make-secret make_secret -crt $CERT -key $KEY > $SECRET

kubectl create -f $SECRET

# cleanup temporary directory
rm -fr -- "$TMP_DIR"
trap - EXIT
exit
