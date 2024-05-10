#!/bin/sh

#cp -r /database /var/www/html/laravel/database

#/usr/local/bin/php /var/www/html/laravel/laravel-app/artisan make:cache-table > /logs/log 2>&1 &
#/usr/local/bin/php /var/www/html/laravel/laravel-app/artisan migrate > /logs/log 2>&1 &
/usr/local/bin/php /var/www/html/laravel/laravel-app/artisan serve --host=0.0.0.0 > /logs/log 2>&1 &
/usr/local/bin/php /var/www/html/laravel/laravel-app/artisan pail -vv > /logs/log 2>&1 &
socat - TCP:127.0.0.1:8000,forever
