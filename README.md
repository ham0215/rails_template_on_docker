# rails_template_on_docker
rails template on docker.

# initialize

## create files
Dockerfile, docker-compose.yml, src/Gemfile, src/Gemfile.lock, mysql-confd/default_authentication.cnf

* default_authentication.cnf is configuration file to change the authentication method introduced from mysql8 to the old method

## rails new
```
docker-compose run web rails new . --force --database=mysql
```

## create a user in mysql

```
# check container id
docker ps
# connect to mysql
docker exec -it ${container id} /bin/bash

# mysql cli
mysql
# check default authentication. (mysql_native_password is OK)
show variables like 'default_authentication_plugin';
# create user
create user rails@"%" identified with mysql_native_password by 'rails_password';
select User, Plugin from mysql.user;
grant ALL on *.* to rails@"%";
show grants for rails@"%";
```

## edit database.yml

```
# edit username, password, host
vi src/config/database.yml
```

## build
```
docker-compose build
```

## run container
```
docker-compose up -d
```

## commands
```
# create database
docker-compose run web bundle exec rake db:create
```
