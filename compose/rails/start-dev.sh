#!/bin/sh
mkdir -p shared/pids shared/sockets shared/log
rake db:create
rake db:migrate
rake db:seed
bundle exec rails s -p 3000 -b '0.0.0.0'
