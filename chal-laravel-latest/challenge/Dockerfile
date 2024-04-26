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
FROM php:latest

ENV COMPOSER_BIN /usr/local/bin/composer/composer.phar
ENV APP_ROOT /var/www/html/laravel
ENV ROUTES_DIR $APP_ROOT/routes

RUN apt-get update && apt-get install -y libonig-dev
RUN apt-get update && apt-get install -y libzip-dev
RUN apt-get update \
    && apt-get install -y autoconf pkg-config libssl-dev wget \
    curl \
    git \
    grep \
    nginx \
    libmemcached-dev \
    libxml2-dev \
    autoconf \
    vim

# Install Laravel dependencies
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        zlib1g-dev \
        unzip \
        git

# Install composer, a package manager for PHP.
RUN curl -sS https://getcomposer.org/installer | php \
    && mkdir -p /usr/local/bin/composer \
    && mv composer.phar $COMPOSER_BIN \
    && $COMPOSER_BIN self-update

# Clone the latest laravel/laravel repo
RUN git clone https://github.com/laravel/laravel.git $APP_ROOT \
    && cd $APP_ROOT \
    && $COMPOSER_BIN install

#Volume laravel storage
VOLUME /var/www/html/laravel/storage

# Add a basic route
RUN mkdir -p $ROUTES_DIR \
    && echo "Route::get('/', function() {return view('welcome');});" >> $ROUTES_DIR/web.php

# Fix up local .env file
RUN cp $APP_ROOT/.env.example $APP_ROOT/.env \
    && sed -i -e "s/APP_KEY=.*$/APP_KEY=base64:your-base64-encoded-key-here/g" $APP_ROOT/.env \
    && echo "WARNING: USING HARD CODED APP_KEY" && grep "^APP_KEY" $APP_ROOT/.env

EXPOSE 8000 8000
ENTRYPOINT ["/usr/local/bin/php", "/var/www/html/laravel/artisan", "serve", "--host=0.0.0.0"]