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
FROM python:3.10-slim as chroot

RUN /usr/sbin/useradd -m -u 1000 user

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
       python3 python3-pip socat nano

RUN pip3 install numpy --upgrade
RUN pip3 install dm-tree       
RUN pip3 install dm-reverb[tensorflow]
RUN pip3 install tensorrt
#RUN pip3 install numpy --upgrade; pip3 install dm-tree; pip3 install dm-reverb[tensorflow]
RUN chmod +777 /home/user
ADD script.py /home/user
RUN chmod +777 /home/user/script.py
RUN chmod +777 /dev/random
RUN chmod +777 /dev/urandom

ADD start.sh /home/user/start.sh
RUN chmod a+wx /home/user/start.sh

FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f


#VOLUME /chroot/usr/local/lib/python3.10/dist-packages
VOLUME /chroot/dev

COPY --from=chroot / /chroot

VOLUME /chroot/home/user

COPY nsjail.cfg /home/user/

CMD kctf_setup && \
kctf_setup \
&& kctf_drop_privs nsjail --config /home/user/nsjail.cfg --port 1337 -- /bin/bash -i