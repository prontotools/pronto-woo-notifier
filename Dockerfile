FROM ruby:2.3.1

MAINTAINER prontotools
ENV APPLICATION_ROOT /app

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

RUN mkdir -p $APPLICATION_ROOT
WORKDIR $APPLICATION_ROOT
ADD . $APPLICATION_ROOT
