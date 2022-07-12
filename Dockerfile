FROM ruby:2.7.2-alpine3.11

RUN apk --update add netcat-openbsd postgresql-dev
RUN apk --update add --virtual build-dependencies make g++

RUN mkdir /bravado_ror

WORKDIR /bravado_ror

ADD Gemfile /bravado_ror/Gemfile
ADD Gemfile.lock /bravado_ror/Gemfile.lock

RUN bundle install
RUN apk del build-dependencies && rm -rf /var/cache/apk/*

ADD . /bravado_ror

COPY docker-entrypoint.sh  /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3000