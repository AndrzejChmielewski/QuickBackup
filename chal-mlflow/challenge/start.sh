#!/bin/sh

echo "[mlflow]
mlflow_tracking_username = username
mlflow_tracking_password = password" > /.mlflow/credentials

(/usr/local/bin/mlflow server --host 0.0.0.0 --app-name basic-auth) > /dev/null 2>&1 &
socat - TCP:127.0.0.1:5000,forever 