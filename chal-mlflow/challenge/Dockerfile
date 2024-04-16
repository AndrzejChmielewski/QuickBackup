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
FROM ghcr.io/mlflow/mlflow as chroot

RUN /usr/sbin/useradd -m -u 1000 user

RUN pip install mlflow 
RUN mkdir -p /.mlflow 
ADD start.sh /start.sh
RUN chmod +x /start.sh
#RUN chown -Rc user /.mlflow

ADD basic_auth.db /


VOLUME /tmp

RUN echo 'deb http://archive.debian.org/debian/ bullseye main' >> /etc/apt/sources.list
RUN apt-get update; exit 0
RUN apt-get install socat -y --force-yes; exit 0

FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f

#VOLUME /chroot/.mlflow
VOLUME /chroot/mlruns

COPY --from=chroot / /chroot

COPY nsjail.cfg /home/user/nsjail.cfg

CMD kctf_setup \
    && (kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 1337 -- /start.sh)


#to run with auth
#/usr/local/bin/mlflow server --host 0.0.0.0 --app-name basic-auth

#[mlflow]
#mlflow_tracking_username = username
#mlflow_tracking_password = password
