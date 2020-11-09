#!/bin/bash

service nginx restart
service mysql restart
service php7.3-fpm start
bash init_sql.sh
bash