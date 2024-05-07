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

RUN /usr/sbin/useradd --no-create-home -u 1000 user

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]

ENV APP_ROOT /var/www/html/laravel
ENV ROUTES_DIR $APP_ROOT/routes
ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_BIN /usr/local/bin/composer/composer.phar

RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    libxml2 \
    autoconf \
    pkg-config \
    libssl-dev \
    wget \
    curl \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    unzip

RUN mkdir -p /home/user

RUN curl -sS https://getcomposer.org/installer | php \
    && mkdir -p /usr/local/bin/composer \
    && mv composer.phar $COMPOSER_BIN \
    && $COMPOSER_BIN self-update

RUN git clone https://github.com/laravel/laravel.git $APP_ROOT \
    && cd $APP_ROOT \
    && $COMPOSER_BIN install

VOLUME /var/www/html/laravel/storage
RUN apt-get update; exit 0
RUN apt-get install socat -y --force-yes; exit 0

RUN mkdir -p $ROUTES_DIR

RUN echo "Route::get('/', function() {return view('welcome');});" >> $ROUTES_DIR/web.php

RUN cp /var/www/html/laravel/.env.example /var/www/html/laravel/.env \
    && sed -i -e "s/APP_KEY=.*$/APP_KEY=base64:your-base64-encoded-key-here/g" /var/www/html/laravel/.env
    
FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f

COPY --from=chroot / /chroot
RUN chown -Rc user /chroot/home/user
VOLUME /chroot/home/user/
VOLUME /chroot/var/www/html/laravel/

COPY nsjail.cfg /home/user/nsjail.cfg

CMD kctf_setup \
    && (kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 1337 -- /usr/local/bin/start.sh)

#ENTRYPOINT ["/usr/local/bin/php", "/var/www/html/laravel/artisan", "serve", "--host=0.0.0.0"]