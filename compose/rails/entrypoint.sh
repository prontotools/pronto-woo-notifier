#!/bin/bash
set -e
cmd="$@"

# the official postgres image uses 'postgres' as default user if not set explictly.
if [ -z "$POSTGRES_USER" ]; then
    export POSTGRES_USER=postgres
fi

function postgres_ready(){
/usr/bin/env ruby << END
require "pg"
begin
  con = PG.connect  :host => "db", :user => "$POSTGRES_USER", :connect_timeout => 1
rescue
  exit -1
ensure
  con.close if con
end
exit 0
END
}


until postgres_ready; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - continuing..."

exec $cmd
