#!/usr/bin

# 1. Check if WordPress is intalled at /var/www/wordpress. If not, install it:
#   1.1 ...
# See https://make.wordpress.org/cli/handbook/how-to/how-to-install/
set -x

sleep 10
# Check what wpi-cli is installed and can run
wp cli version --allow-root
# Checks if wp-config.php exists
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    # rm -rf /var/www/wordpress/*
    echo "Downloading and Installing WordPress..."
    #download WordPress
    wp core download \ 
    --locale="en_US" \
    --allow-root

    #generate a config file and set up the database credentials for our installation.
    wp config create \
    --dbname=DB_DATABASE \
    --dbuser=DB_USER \
    --prompt=DB_PASSWORD
    --path='/var/www/wordpress' \
    --extra-php \
    --allow-root
    Success: Generated 'wp-config.php' file.

    # To create the database based on the information we passed to the wp-config.php

    wp db create
    Success: Database created.

    chmod 777 wp-config.php

    # install WordPress now
    wp core install --url=wpclidemo.dev \
    --title=WP_WEBSITE_TITLE \
    --admin_user=WP_ADMIN_USER \
    --admin_password=WP_ADMIN_PASSWORD \
    --admin_email=WP_ADMIN_EMAIL
    Success: WordPress installed successfully.

    wp user create \
    --allow-root \
    --role=author $WP_RANDOM_USER $WP_RANDOM_EMAIL \
    --user_pass=$WP_RANDOM_PASSWORD \
    --path='/var/www/wordpress' >> /log.txt
else
    printf "WordPress installed\n"
    
fi

# if [ ! -d /run/php ]; then
#     mkdir -p /run/php
# fi
# /usr/sbin/php-fpm7.3 -F

# 2. Start php-fpm
php-fpm7.4 -F