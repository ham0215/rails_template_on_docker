# rails_template_on_docker
rails template on docker.

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

## create a user in mysql

```
# connect to mysql
docker-compose exec db bash

# mysql cli
mysql -p
# check default authentication. (mysql_native_password is OK)
show variables like 'default_authentication_plugin';
# create user
create user rails@"%" identified with mysql_native_password by 'rails_password';
select User, Plugin from mysql.user;
grant ALL on *.* to rails@"%";
show grants for rails@"%";
```

## rails new
```
$ docker-compose run web bash
# rails new . --force --database=mysql --skip-test
# bundle install
# bundle exec rails webpacker:install
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

# create database
docker-compose exec web bundle exec rake db:create

# migration
docker-compose exec web bundle exec rake db:migrate
```
