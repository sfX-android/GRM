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
#
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:jammy-1.0.1

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python3-launchpadlib
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y packagekit-gtk3-module yad file
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential libgtk-3-dev libcairo2-dev libglib2.0-dev pkg-config

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add latest GRM to the image
ADD https://github.com/sfX-android/GRM/archive/refs/tags/latest.tar.gz /opt/GRM.tgz
RUN tar --one-top-level=/opt/GRM --strip-components=1 -xvzf /opt/GRM.tgz
RUN rm /opt/GRM.tgz

# prepare broadway
ENV GDK_BACKEND broadway
ENV BROADWAY_DISPLAY :5
EXPOSE 8085
COPY grm_docker.sh /grm_docker.sh

# run GRM with broadway
CMD ["/grm_docker.sh"]
