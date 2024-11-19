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

# Start with the official PostgreSQL image from Docker Hub
FROM postgres:latest as chroot

RUN /usr/sbin/useradd --no-create-home -u 1000 user

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword
ENV POSTGRES_DB=mydatabase

# Set a writable directory for PostgreSQL runtime files
RUN mkdir -p /var/lib/postgresql/socket && chmod -R 0777 /var/lib/postgresql/socket
ENV PGDATA=/var/lib/postgresql/data

RUN mkdir -p /home/user

#install socat
USER root
RUN echo 'deb http://archive.debian.org/debian/ rodete main' >> /etc/apt/sources.list
RUN apt-get update; exit 0
RUN apt-get install socat -y --force-yes; exit 0


# Copy any custom scripts or configuration files if needed
# COPY ./init.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
#EXPOSE 5432
#VOLUME /var/run/postgresql

ADD start.sh /home/user/start.sh
RUN chmod a+wx /home/user/start.sh

FROM europe-west4-docker.pkg.dev/internet-ctf/custom-images/kctf-source

COPY --from=chroot / /chroot
VOLUME /chroot/home/user
COPY --from=chroot / /chroot
VOLUME /chroot/logs
RUN chown -Rc user /chroot/home/user
VOLUME /chroot/var/run/postgresql

#fix permission
#RUN mkdir -p /chroot/var/run/postgresql
RUN chmod -R 0777 /chroot/var/run/postgresql

COPY nsjail.cfg /home/user/

CMD kctf_setup && \
    kctf_setup \
    && kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 1337 -- /home/user/start.sh

#start
#CMD ["postgres"]

#To conect to it:
#kctf chal debug port-forward --port 5432
#psql -h 127.0.0.1 -p 43739 -U myuser -d mydatabase
