#!/bin/sh
mkdir -p shared/pids shared/sockets shared/log
RAILS_ENV=production rake db:migrate
export SECRET_KEY_BASE=$(rake secret)
RAILS_ENV=production puma
RAILS_ENV=production rake assets:precompile
