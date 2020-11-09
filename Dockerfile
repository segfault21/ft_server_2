# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmedusa <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/22 14:52:20 by lmedusa           #+#    #+#              #
#    Updated: 2020/08/22 14:52:22 by lmedusa          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vim nginx wget curl mariadb-server

#WORDPRESS
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxvf latest.tar.gz && rm latest.tar.gz
RUN mv wordpress /var/www/html/wordpress

#PHP
RUN apt-get install -y php-fpm php-mysql php-curl php-mbstring php-gd php-xml php-xmlrpc php-zip php-intl php-soap

#SSL KEY
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/certs/lmedusa.crt -keyout /etc/ssl/certs/lmedusa.key -subj "/C=RU/ST=Moscow/L=Moscow/O=SCHOOL21/OU=lmedusa/CN=www.lmedusa.com"

#COPY
COPY /srcs/nginx.conf /etc/nginx/sites-avaliable/default
COPY /srcs/tmp.conf /etc/nginx/sites-avaliable/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-avaliable/default /etc/nginx/sites-enabled/default
COPY /srcs/wp-config.php /var/www/html/wordpress/wp-config.php
COPY /srcs/*.sh ./
RUN chmod +x *.sh

#PHPMYODMEN
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && rm phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
COPY /srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php

EXPOSE 80 443

#RM DEFAULT PAGE
RUN rm -f /var/www/html/index.nginx-debian.html

#CHMOD
RUN chown -R www-data:www-data /var/www/html
RUN chmod 775 -R /var/www/html

CMD bash start_service.sh
