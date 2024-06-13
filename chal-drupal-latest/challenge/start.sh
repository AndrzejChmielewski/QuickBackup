#!/bin/bash

cp -r /copy/sites/* /opt/drupal/web/sites/

#sqlite3 /opt/drupal/web/sites/default/files/.ht.sqlite "UPDATE users SET password_hash = '$PASSWORD' WHERE id = 1;"
apache2-foreground > /dev/null 2>&1 &

# Proxy stdin/stdout to server
socat - TCP:127.0.0.1:8080,forever