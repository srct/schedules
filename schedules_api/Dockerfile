FROM ruby:2.5

RUN mkdir /api
WORKDIR /api
ADD . /api

EXPOSE 3000

RUN bundle install
RUN rails db:migrate
RUN rails db:seed
