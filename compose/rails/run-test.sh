#!/bin/sh
rake db:create
rake db:migrate
rake test
