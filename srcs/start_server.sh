#!/bin/bash

service mysql start
service php7.3-fpm start
service nginx start
mysql -u root --skip-password < /var/sql-config.sql

sleep infinity