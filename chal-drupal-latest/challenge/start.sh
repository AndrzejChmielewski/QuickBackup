#!/bin/bash

file="/opt/drupal/web/sites/default/files/A"
if [ ! -f "$file" ] 
    then
    /opt/drupal/vendor/bin/drush php-script /opt/drupal/auth-flag.php
    touch /opt/drupal/web/sites/default/files/A
fi

apache2-foreground > /dev/null 2>&1 &

# Proxy stdin/stdout to server
socat - TCP:127.0.0.1:8080,forever

