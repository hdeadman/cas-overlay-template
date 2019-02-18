#!/bin/bash
# Generate sha1 fingerprint of IDP signing cert (CAS) for use in gitlab.rb SAML config

# Pass in path to IDP signing cert, otherwise look for it in likely places
CAS_CERT=${1-/c/etc/cas/saml/idp-signing.crt}
if [[ ! -f $CAS_CERT ]] ; then 
    CAS_CERT=/etc/cas/saml/idp-signing.crt
fi
if [[ ! -f $CAS_CERT ]] ; then 
    echo "Can't find CAS SAML IDP signing certificate"
    exit 1
fi
openssl x509 -noout -fingerprint -sha1 -inform pem -in ${CAS_CERT}