#!/bin/sh
RAILS_ENV=production rake db:migrate
export SECRET_KEY_BASE=$(rake secret)
puma
