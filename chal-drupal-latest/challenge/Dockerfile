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
FROM drupal:latest as chroot

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
# Install packages
RUN apt-get update && apt-get install -y zip unzip curl git sqlite3 vim
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer self-update
RUN composer install --no-dev
# Install drush
RUN composer require drush/drush
# Install REST UI module
RUN composer require drupal/restui 
#Install site
RUN composer create-project drupal/recommended-project 
RUN drush site-install --db-url="sqlite://sites/default/files/.ht.sqlite" --site-name="Drupal-latest" --account-pass=password
# Install socat

RUN apt-get install socat sqlite3 -y --force-yes; exit 0
# Configure 8080 port
RUN sed -i '5s/80/8080/' /etc/apache2/ports.conf
RUN sed -i '1s/80/8080/' /etc/apache2/sites-enabled/000-default.conf

COPY start.sh /
RUN chmod +777 /start.sh
COPY files /opt/drupal/web/sites/default/files
RUN chmod a+w -R /opt/drupal/web/sites/default/files

ADD  auth-flag.php /opt/drupal/auth-flag.php
RUN chmod +777 auth-flag.php /opt/drupal/auth-flag.php

FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f
COPY --from=chroot / /chroot

VOLUME /chroot/opt/drupal/web/sites

COPY nsjail.cfg /home/user/nsjail.cfg
   
CMD sed -i "s@Edit profile@CAPTUREFLAG@g" /chroot/opt/drupal/web/core/modules/user/src/ToolbarLinkBuilder.php; \
	kctf_setup \
	&& kctf_drop_privs nsjail -E PASSWORD=$(cat /flag/password.txt) -E AUTHBYPASS=$(cat /flag/flag-exposed-auth-bypass.txt)  --config /home/user/nsjail.cfg --port 1337 -- /start.sh