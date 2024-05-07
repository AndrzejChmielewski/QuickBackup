#!/bin/sh

/usr/local/bin/php /var/www/html/laravel/artisan serve --host=0.0.0.0 > /dev/null &
socat - TCP:127.0.0.1:8000,forever
