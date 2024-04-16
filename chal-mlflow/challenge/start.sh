#!/bin/sh

cp /basic_auth.db /home/user
(/usr/local/bin/mlflow server --host 0.0.0.0 --app-name basic-auth --workers=1) > /dev/null 2>&1 &
socat - TCP:127.0.0.1:5000,forever 