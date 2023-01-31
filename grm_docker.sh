#!/usr/bin/env bash
##################################################################################
# Copyright 2022 steadfasterX <steadfasterX |at| gmail - com>
# Copyright 2023 steadfasterX <steadfasterX |at| gmail - com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##################################################################################

nohup broadwayd :5 &

mkdir -p /root/Desktop
mkdir -p /root/.config/nautilus
sleep 5
echo -e "\033[1mNow open your browser and connect to: \033[36m\033[1mhttp://localhost:8085\033[0m"
/opt/GRM/grm
