FROM ruby:2.6.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    vim \
    locales \
    locales-all \
    default-mysql-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV LANG ja_JP.UTF-8

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem update bundler
RUN bundle install
COPY . .
RUN yarn install --check-files
RUN bundle exec rails assets:precompile

RUN rm -f /app/tmp/pids/server.pid

CMD ["rails", "server", "-b", "0.0.0.0"]
