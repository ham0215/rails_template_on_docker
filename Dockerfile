FROM ruby:2.6.2

RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN mkdir -p /app/src
WORKDIR /app/src

COPY src/Gemfile /app/src/Gemfile
COPY src/Gemfile.lock /app/src/Gemfile.lock

RUN bundle install
# ローカルのsrcをコピー
COPY src /app/src
