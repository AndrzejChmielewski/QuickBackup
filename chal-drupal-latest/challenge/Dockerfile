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
FROM drupal:latest 

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt-get update

# Install packages
RUN apt-get update && apt-get install -y zip unzip curl git sqlite3 vim

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer self-update
RUN composer install --no-dev

RUN composer create-project drupal/recommended-project drupal && cd drupal

# Install socat
#USER root
#RUN echo 'deb http://archive.debian.org/debian/ stretch main' > /etc/apt/sources.list
#RUN apt-get update; exit 0
#RUN apt-get install socat -y --force-yes; exit 0

# Configure 8080 port
RUN sed -i '5s/80/8080/' /etc/apache2/ports.conf
RUN sed -i '1s/80/8080/' /etc/apache2/sites-enabled/000-default.conf

VOLUME /run/apache2
VOLUME /var/www/html/sites

CMD [ "apache2-foreground" ]