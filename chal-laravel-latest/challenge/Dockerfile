# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM php:latest as chroot

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
ENV APP_ROOT /var/www/html/laravel
ENV ROUTES_DIR $APP_ROOT/routes
ENV COMPOSER_BIN /usr/local/bin/composer/composer.phar

RUN mkdir -p /logs
RUN touch /logs/log
RUN chmod -R +777 /logs

RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    autoconf \
    pkg-config \
    libssl-dev \
    wget \
    curl \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    socat \
    unzip \
    sqlite3

RUN docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-install pcntl
RUN curl -sS https://getcomposer.org/installer | php \
    && mkdir -p /usr/local/bin/composer \
    && mv composer.phar $COMPOSER_BIN \
    && $COMPOSER_BIN self-update 

RUN git clone https://github.com/laravel/laravel.git $APP_ROOT \
    && cd $APP_ROOT \
    && $COMPOSER_BIN install \
    && $COMPOSER_BIN require laravel/pail 

RUN mkdir -p /home/user && mkdir -p $ROUTES_DIR
RUN echo "Route::get('/', function() {return view('welcome');});" >> $ROUTES_DIR/web.php
RUN cp $APP_ROOT/.env.example $APP_ROOT/.env \
    && sed -i -e "s;^APP_KEY=.*$;APP_KEY=base64:9UZUmEfHhV7WXXYewtNRtCxAYdQt44IAgJUKXk2ehRk=;" $APP_ROOT/.env \
    && echo "WARNING: USING HARD CODED APP_KEY" && grep "^APP_KEY" $APP_ROOT/.env
RUN chmod -R 777 /var/www/html/laravel/database/
RUN mkdir -p /var/www/html/laravel/database
RUN touch /var/www/html/laravel/database/database.sqlite

FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f

COPY --from=chroot / /chroot
RUN chown -Rc user /chroot/home/user
VOLUME /chroot/logs
VOLUME /chroot/home/user/
VOLUME /chroot/var/www/html/laravel/

COPY nsjail.cfg /home/user/nsjail.cfg

CMD kctf_setup \
    && (kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 1337 -- /usr/local/bin/start.sh) & \
    tail -f /chroot/logs/log
