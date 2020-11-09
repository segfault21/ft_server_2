#!/bin/bash

bash mv /etc/nginx/sites-avaliable/default /etc/nginx/sites-avaliable/default.tmp
bash mv /etc/nginx/sites-avaliable/tmp.conf /etc/nginx/sites-avaliable/default
bash mv /etc/nginx/sites-avaliable/default.tmp /etc/nginx/sites-avaliable/tmp.conf
service nginx restart