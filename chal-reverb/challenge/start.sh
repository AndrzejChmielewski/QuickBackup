#!/bin/bash

python3 script.py > /home/user/logs 2>&1 &
flask --app app run > /home/user/logs 2>&1 &

# Proxy stdin/stdout to server
socat - TCP:127.0.0.1:5000,forever