#!/bin/sh

# generate a secret key for rails to use
export SECRET_KEY_BASE=$(rails secret)

# uncomment for faster docker builds during testing
#cp db/development.sqlite3 db/production.sqlite3

# load data from patriot web into database
# rails db:migrate
# rails db:seed

# docker doesn't remove the server socket when the container is closed
# so remove it if it's still there
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# start the server
rails s
