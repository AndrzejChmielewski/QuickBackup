#!/bin/sh

#/usr/bin/sqlite3 /var/www/html/laravel/database/database.sqlite < /var/www/html/laravel/database/schema/create-tables.sql &
#/usr/local/bin/php /var/www/html/laravel/artisan migrate &

/usr/local/bin/php /var/www/html/laravel/artisan serve --host=0.0.0.0 > /dev/null 2>&1 &
/usr/local/bin/php /var/www/html/laravel/artisan pail -vv > /dev/null 2>&1 &
socat - TCP:127.0.0.1:8000,forever
