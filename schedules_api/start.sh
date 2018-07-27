#!/bin/sh

export SECRET_KEY_BASE=$(rails secret)
cp db/development.sqlite3 db/production.sqlite3
rails s
