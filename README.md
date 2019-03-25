# rails_template_on_docker
rails template on docker.

# 初めにやったこと

## create files
Dockerfile, docker-compose.yml, src/Gemfile, src/Gemfile.lock, mysql-confd/default_authentication.cnf

* Gemfile, Gemfile.lockは初回のrails newを成功させるためのファイル
* default_authentication.cnfはmysql8から導入された認証方式を旧方式に変更する設定ファイル

## rails new
```
docker-compose run web rails new . --force --database=mysql
```

## create a user in mysql

```
# container id 確認
docker ps
# mysqlコンテナへ接続
docker exec -it ${container id} /bin/bash

# mysql cli
mysql
# デフォルトの認証方式を確認(mysql_native_passwordならOK)
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

## コンテナ起動
```
docker-compose up -d
```

## create database
```
docker-compose run web bundle exec rake db:create
```
ここでエラーが発生する。。。mysql上で同じくエリーを発行しても問題ないのになんだろう。。
```
rake aborted!
ActiveRecord::StatementInvalid: Mysql2::Error::ConnectionError: Lost connection to MySQL server during query: SET NAMES utf8,  @@SESSION.sql_mode = CONCAT(CONCAT(@@sql_mode, ',STRICT_ALL_TABLES'), ',NO_AUTO_VALUE_ON_ZERO'),  @@SESSION.sql_auto_is_null = 0, @@SESSION.wait_timeout = 2147483
```
