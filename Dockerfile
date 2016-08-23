FROM ubuntu:14.04

MAINTAINER prontotools
ENV APPLICATION_ROOT /app/

RUN apt-get update

RUN mkdir -p $APPLICATION_ROOT
WORKDIR $APPLICATION_ROOT
ADD . $APPLICATION_ROOT
