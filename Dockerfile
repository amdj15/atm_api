FROM ruby:2.4.1-alpine

RUN apk update \
  && apk add curl-dev ruby-dev build-base \
  zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev \
  ruby-json yaml nodejs git bash

RUN rm -rf /var/cache/apk/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD . /usr/src/app

RUN bundle install

CMD ["bundle", "exec", "hanami", "server"]
