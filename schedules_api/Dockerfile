FROM ruby:2.5

RUN mkdir /api
WORKDIR /api
ADD . /api

EXPOSE 3000

ENV RAILS_ENV production

RUN bundle install
RUN rails db:migrate
RUN rails db:seed
RUN rails docs:generate
