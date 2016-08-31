FROM ruby:2.3.1

MAINTAINER prontotools
ENV APPLICATION_ROOT /app

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir -p $APPLICATION_ROOT
WORKDIR $APPLICATION_ROOT

ADD Gemfile $APPLICATION_ROOT/Gemfile
ADD Gemfile.lock $APPLICATION_ROOT/Gemfile.lock
RUN bundle install

ADD . $APPLICATION_ROOT
