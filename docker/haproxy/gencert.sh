#!/bin/bash
# Creating self signed certificate
DOMAIN=${1-example.org}
SUBJECT="/C=US/ST=V/O=Demo, Inc./CN=$DOMAIN"
echo $SUBJECT
echo "Requires Openssl 1.1.1 or higher, latest git bash on Windows has new enough version"
openssl version

# Using MSYS_NO_PATHCONV=1 to turn off git bash on windows behavior of converting forward slashes to back slashes which breaks subject
# without the -nodes option (i.e. don't encrypt private key) this was hanging on windows, probably waiting for password or something
MSYS_NO_PATHCONV=1 openssl req -x509 -sha256 \
    -newkey rsa:2048 \
    -nodes \
    -subj "${SUBJECT}" \
    -keyout ${DOMAIN}.key \
    -addext "subjectAltName = DNS:${DOMAIN},DNS:www.${DOMAIN},DNS:gitlab.${DOMAIN},DNS:cas.${DOMAIN}" \
    -out ${DOMAIN}.crt

# Combing cert and and key into a single file for use by HAProxy
cat ${DOMAIN}.crt ${DOMAIN}.key > site.pem