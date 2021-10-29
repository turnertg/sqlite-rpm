## WARNING: DO NOT BUILD ON BTRFS, TWO UNIT TESTS IN SQLITE FAIL. IT IS FINE ON XFS/EXT4 ##
#
# base image
#

FROM centos:7 AS base
MAINTAINER deploymentdog

# general build tools
RUN yum install -y rpm-build tar make autoconf gcc curl 

# make depends
RUN yum install -y ncurses-devel readline-devel glibc-devel tcl-devel zlib-devel systemtap-sdt-devel

#
# builder image 
#

FROM base AS builder

ARG SQLITE_VER
ARG TCL_VER

# rpmbuild command recommends to use `builder:builder` as user:group.
RUN useradd -u 1000 builder

RUN mkdir -p /home/builder/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
RUN mkdir -p /home/builder/sqlite-rpm
RUN chown -R builder:builder /home/builder/rpmbuild
RUN chown -R builder:builder /home/builder/sqlite-rpm

WORKDIR /home/builder/sqlite-rpm
USER builder

RUN curl -LO https://download.rockylinux.org/pub/rocky/8/BaseOS/source/tree/Packages/tcl-$TCL_VER.el8.src.rpm
RUN rpmbuild --rebuild tcl-$TCL_VER.el8.src.rpm

USER root
RUN yum install -y /home/builder/rpmbuild/RPMS/x86_64/tcl{,-devel}-$TCL_VER.el7.x86_64.rpm

USER builder
RUN curl -LO http://download.rockylinux.org/pub/rocky/8/BaseOS/source/tree/Packages/sqlite-$SQLITE_VER.el8.src.rpm
RUN rpmbuild --rebuild sqlite-$SQLITE_VER.el8.src.rpm


#
# tester image - not used, the intense unit tests from sqlite are enough imo
#

#FROM base AS tester
#ARG SQLITE_VER
#ARG TCL_VER
