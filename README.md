# rails_template_on_docker
rails template on docker.

[![CircleCI](https://circleci.com/gh/ham0215/rails_template_on_docker.svg?style=svg)](https://circleci.com/gh/ham0215/rails_template_on_docker)

## ruby version
2.6.3

## rails version
6.0.0.rc1

# initialize

## create files

### Dockerfile, docker-compose.yml, mysql-confd/default_authentication.cnf
refer to repository files.  
default_authentication.cnf is configuration file to change the authentication method introduced from mysql8 to the old method.

### Gemfile
```
source 'https://rubygems.org'

gem 'rails', '6.0.0.rc1'
```

### Gemfile.lock
create empty file

## rails new
```
$ docker-compose run web bash
# rails new . --force --database=mysql --skip-test
# bundle install
```

## edit database.yml

```
# edit username, password, host
vi src/config/database.yml
```

# commands
```
# build
docker-compose build

# run containers in background
docker-compose up -d

# build and run containers in background
docker-compose up --build -d

# rspec install
bundle exec rails g rspec:install

# config install
bundle exec rails g config:install

# create database
docker-compose exec web bundle exec rake db:create

# migration
docker-compose exec web bundle exec rake db:migrate

# run rubocop. ruby2.6 does not support.
docker-compose exec web bundle exec rubocop

# run brakeman
docker-compose exec web bundle exec brakeman -6 -A -w 1

# run rails_best_practices
docker-compose exec web bundle exec rails_best_practices .

# run rspec
docker-compose exec web bundle exec rspec

# mysql
docker-compose exec web mysql -h db --default-character-set=utf8
```
