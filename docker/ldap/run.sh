#!/bin/bash
docker stop ldap-server
docker rm ldap-server
docker run -d -p 10389:389 --name="ldap-server" cas/ldap