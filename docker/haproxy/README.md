HAProxy For CAS & Gitlab Demo 
=============

Rather than bind mounting in the haproxy.cfg which would require knowing the files absolute path, this just adds the haproxy.cfg file to a new image every time you run the run scripts. 

The SSL certificate used by HAProxy is also added to the image and the script to generate it is in `gencert.sh`. 

Run `run.bat` or `run.sh` to build the image and run it in the background. Then browse to `http://localhost:1936/haproxy?stats` for statistics. 

Once Gitlab and CAS are running behind this container you should be able to browse to `https://example.org` for Gitlab and `https://example.org/cas/` for CAS. This assumes an entry in your hosts file like the following:

```
YOUR IP example.org 
```

Login to stats page as `admin/password`.
