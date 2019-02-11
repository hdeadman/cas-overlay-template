Simple 389-ds 
=============

Credit: [@jtgasper3](https://github.com/jtgasper3/docker-images/tree/master/389-ds)

This image is perfect if you need to spin-up a clean ldap image for testing. This is great for integration testing.

## Usage
#### To build the image:

```
docker build --tag="cas/ldap" .
```
Or run the appropriate build script e.g. build.bat or build.sh 

#### To start a container:

```
docker run -d -p 10389:389 --name="ldap-server" cas/ldap
```
Or run the appropriate run script e.g. run.bat or run.sh (which will stop and remove any existing container before starting a new one)


#### To confirm it's working:
Run ```docker logs ldap-server``` to check the logs and ```docker ps -a``` to make sure it's running. 

#### To add users:
Update the `users.ldif` file and then rebuild the image. 

#### To connect to the instance:
Point your favorite LDAP browser to `localhost:10389` and connect with `cn=Directory Manager` and `password`.

If you don't have a favorite LDAP browser, try [Apache Directory Studio](https://directory.apache.org/studio).

