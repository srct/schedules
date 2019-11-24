FROM starefossen/ruby-node:latest

RUN mkdir /api
WORKDIR /api
ADD . /api

EXPOSE 3000

ENV RAILS_ENV production

RUN bundle install --without development test
RUN yarn install
RUN SECRET_KEY_BASE=1 rails assets:precompile

RUN apt-get update
RUN apt-get install -y cron 

RUN whenever --update-crontab

CMD [ "rails server" ]
