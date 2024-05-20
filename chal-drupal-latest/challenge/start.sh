#!/bin/bash

#sudo mkdir -p /var/www/html/sites
cp -r /copy/sites .
#cp -r /copy/sites/* /opt/drupal/web/sites/

#/opt/drupal/vendor/bin/drush site-install --db-url="sqlite://sites/default/files/.ht.sqlite" --site-name="Drupal-latest" --account-pass=password
apache2-foreground > /dev/null 2>&1 &

# Proxy stdin/stdout to server
socat - TCP:127.0.0.1:8080,forever