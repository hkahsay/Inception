#!/bin/bash

# 1. Check if WordPress is installed at /var/www/wordpress. If not, install it:
#   1.1 ...
# See https://make.wordpress.org/cli/handbook/how-to/how-to-install/

set -x

# TODO: wait until the database is ready with a loop
sleep 10

# Check which version of wp-cli is installed and can run
wp cli version --allow-root

# Checks if wp-config.php exists
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    # rm -rf /var/www/wordpress/*
    echo "Downloading and Installing WordPress..."
    
    # Download WordPress
    wp core download \
        --locale="en_US" \
        --allow-root

    # Generate a config file and set up the database credentials for our installation.
    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=$DB_HOST \
        --path='/var/www/wordpress' \
        --extra-php \
        --allow-root

    # Success: Generated 'wp-config.php' file.

    # No need to do it, already created in the mariadb container
    # To create the database based on the information we passed to the wp-config.php
    #wp db create --allow-root
    # Success: Database created.

    # cp wp-config.php wp-config.php
    chmod 777 wp-config.php

    # Install WordPress now
    wp core install --url=wpclidemo.dev \
        --title=$WP_WEBSITE_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    # Success: WordPress installed successfully.

    wp user create \
        --allow-root \
        --role=author $WP_RANDOM_USER $WP_RANDOM_EMAIL \
        --user_pass=$WP_RANDOM_PASSWORD \
        --path='/var/www/wordpress' >> /log.txt
else
    printf "WordPress installed\n"
fi

#if [ ! -d /run/php ]; then
#    mkdir -p /run/php
#fi

# 2. Start php-fpm
php-fpm7.4 -F
