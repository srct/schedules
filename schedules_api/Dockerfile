FROM ruby:2.5

RUN mkdir /api
WORKDIR /api
ADD . /api

RUN bundle install --without development
ENV RAILS_ENV=production
