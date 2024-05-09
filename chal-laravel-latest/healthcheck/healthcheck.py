#!/usr/bin/env python3
# -*- coding: utf-8 -*-
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
import requests
import time

def healthcheck():
    url = "http://localhost:1337"
    retries = 3
    delay = 5

    for i in range(retries):
        response = requests.get(url)
        if response.status_code == 200:
            print("Laravel server is healthy")
            return 0
        else:
            print(f"Laravel server is not healthy (attempt {i+1}/{retries})")
            print(f"Status code: {response.status_code}")
            print(f"Response: {response.text}")
            time.sleep(delay)

    print("Healthcheck failed after maximum retries")
    return 1

healthcheck()