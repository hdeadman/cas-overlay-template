Gitlab Running Locally in Docker for CAS-SAML demo
=============

## Generate SSL certificates
Run ```./gencert.sh``` script in bash to generate SSL key/cert for gitlab container. 
*Must have access to openssl 1.1.1 or higher (available in recent versins of Git Bash for Windows)*

## Gitlab Configuration Files
 - gitlab.rb.template - Full template of all gitlab (11.7) configuration options, with defaults, everything commented out, for reference
 - gitlab.rb - Gitlab config file with settings for this demo (ldap config, saml config, etc.)

## Generate IDP signing cert fingerprint
```fingerprint_idp.sh``` - Generate sha1 fingerprint from CAS SAML IDP signing certificate for use in gitlab.rb

## Example Certs
Pre-generated cert and key in ```example.org.crt``` and ```example.org.key``` for use instead of running ```gencert.sh```

## Scripts 
```run.bat``` and ```restart.bat``` for running gitlab container in Docker For Windows (Use cmd.exe)

```run.sh``` and ```restart.sh``` for running gitlab container in Bash (on Mac or Linux)