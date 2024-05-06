#!/bin/sh

kctf_setup

kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 8000 -- /usr/local/bin/php /var/www/html/laravel/artisan serve --host=0.0.0.0