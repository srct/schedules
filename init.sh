#! /bin/bash

cd schedules_api/
docker build . -t 'schedules_api'

cd ../schedules_web
docker build . -t 'schedules_web'

cd ..
docker-compose up -d
docker-compose exec api rails db:seed
