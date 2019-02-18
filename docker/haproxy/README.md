HAProxy For CAS & Gitlab Demo 
=============

Rather than bind mounting in the haproxy.cfg which would require knowing the files absolute path, this just adds the haproxy.cfg file to a new image every time you run the run scripts. 

The SSL certificate used by HAProxy is also added to the image and the script to generate it is in `gencert.sh`. 


