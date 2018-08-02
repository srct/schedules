#!/bin/sh

# generate a secret key for rails to use
export SECRET_KEY_BASE=$(rails secret)

# uncomment for faster docker builds during testing
#cp db/development.sqlite3 db/production.sqlite3

# load data from patriot web into database
rails db:migrate
rails db:seed

# start the server
rails s
