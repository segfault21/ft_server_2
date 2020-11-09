#!/bin/bash

mysql -e "CREATE DATABASE wp_base"
mysql -e "CREATE USER 'lmedusa'@'localhost' IDENTIFIED BY 'lmedusa';"
mysql -e "GRANT ALL ON *.* TO 'lmedusa'@'localhost' IDENTIFIED BY 'lmedusa' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES"