#!/bin/sh
(set -e)

#chmod -R 0777 /var/run/postgresql

exec postgres > 2>&1 &
socat - TCP:127.0.0.1:5432,forever 

#start
#CMD ["postgres"]
#To conect to it:
#kctf chal debug port-forward --port 5432
#psql -h 127.0.0.1 -p 43739 -U myuser -d mydatabase
