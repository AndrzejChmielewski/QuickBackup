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
FROM duonghuuphuc/tomcat-8.5.32:latest as chroot

RUN /usr/sbin/useradd --no-create-home -u 1000 user

RUN chmod -R 777 /usr/local/tomcat
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
RUN mkdir -p /home/user

RUN echo 'deb http://archive.debian.org/debian/ stretch main' > /etc/apt/sources.list
RUN apt-get update; exit 0
RUN apt-get install socat -y --force-yes; exit 0

FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f

COPY --from=chroot / /chroot
RUN chown -Rc user /chroot/home/user
VOLUME /chroot/home/user/
VOLUME /chroot/usr/local/tomcat

COPY nsjail.cfg /home/user/nsjail.cfg

CMD kctf_setup \
    && (kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 1337 -- /usr/local/bin/start.sh)