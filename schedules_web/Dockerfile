FROM node:9

COPY . /web
WORKDIR /web

RUN yarn install && yarn run prod

FROM nginx:1.15.0
COPY --from=0 /web/dist /web
