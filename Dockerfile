# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:focal-1.2.0

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN apt-get install -y software-properties-common
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
RUN apt-get install -y packagekit-gtk3-module yad file

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add latest GRM to the image
ADD https://github.com/sfX-android/GRM/archive/refs/tags/v1.0.tar.gz /opt/GRM.tgz
RUN tar --one-top-level=/opt/GRM --strip-components=1 -xvzf /opt/GRM.tgz
RUN rm /opt/GRM.tgz

# run GRM
CMD /opt/GRM/grm
