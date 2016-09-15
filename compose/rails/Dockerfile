FROM ruby:2.3.1

MAINTAINER prontotools
ENV APPLICATION_ROOT /app

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

COPY ./compose/rails/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./compose/rails/start-dev.sh /start-dev.sh
RUN sed -i 's/\r//' /start-dev.sh
RUN chmod +x /start-dev.sh

COPY ./compose/rails/start-production.sh /start-production.sh
RUN sed -i 's/\r//' /start-production.sh
RUN chmod +x /start-production.sh

WORKDIR $APPLICATION_ROOT
ADD . $APPLICATION_ROOT
