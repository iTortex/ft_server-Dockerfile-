# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: amarcele <amarcele@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/07/31 17:41:58 by amarcele          #+#    #+#              #
#    Updated: 2020/08/24 19:06:50 by amarcele         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install nginx default-mysql-server 
RUN apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-json php-mbstring
RUN apt-get -y install wordpress
RUN apt-get -y install openssl

ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz phpmyadmin.tar.gz
RUN tar xvzf phpmyadmin.tar.gz && mv phpMyAdmin-5.0.2-all-languages /var/www/html/phpmyadmin
RUN mv usr/share/wordpress /var/www/html

RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 777 /var/www/

COPY ./srcs/default /etc/nginx/sites-available
COPY ./srcs/wp-config.php /var/www/html/wordpress/
COPY ./srcs/sql-config.sql /var/
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin/
COPY ./srcs/ft_secure.crt /etc/ssl/certs/
COPY ./srcs/ft_secure.key /etc/ssl/private/
COPY ./srcs/start_server.sh /
COPY ./srcs/autoindex.sh /
 
EXPOSE 80 443

CMD bash start_server.sh