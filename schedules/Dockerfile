FROM starefossen/ruby-node:latest

RUN mkdir /api
WORKDIR /api
ADD . /api

EXPOSE 3000

ENV RAILS_ENV production

RUN bundle install
RUN yarn install
RUN export SECRET_KEY_BASE=$(rails secret)
RUN rails assets:precompile
RUN rails db:migrate
RUN rails db:seed
RUN rails runner db/load_course_ratings.rb

RUN whenever --update-crontab

CMD [ "rails server" ]
