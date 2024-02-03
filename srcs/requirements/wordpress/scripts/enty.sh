#!bin/bash

#   script.sh WORDPRESS olmartin 26.06.23  V26.13

set -x

sleep 10

if [ ! -f "/wordpress/wp-activate.php" ]; then
    rm -rf /var/www/wordpress/*

    wp core download \
    --locale="en_US" \
    --allow-root

    wp core config \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=$WP_DB_HOST:3306 \
    --path='/var/www/wordpress' \
    --extra-php \
    --allow-root

    chmod 777 wp-config.php


    wp core install \
    --url=$DOMAIN_NAME \
    --title=$WP_SITE_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL\
     --allow-root \
     --path='/var/www/wordpress'

    wp user create \
    --allow-root \
    --role=author $WP_USER $WP_USER_EMAIL \
    --user_pass=$WP_USER_PWD \
    --path='/var/www/wordpress' >> /log.txt
else
    printf "WordPress installed\n"
fi
	

if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi
/usr/sbin/php-fpm7.3 -F