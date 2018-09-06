#! /bin/bash

# Build the API image
cd schedules_api/
docker build . -t 'schedules_api' -f Dockerfile.dev

# Build the Web image
cd ../schedules_web
docker build . -t 'schedules_web' -f Dockerfile.dev

# Start and link the images together
cd ..
docker-compose up
