#!/bin/bash

# Check if WordPress is already installed
if [ ! -e /var/www/html/wp-config.php ]; then
    # Download and extract WordPress
    curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1
    rm /tmp/wordpress.tar.gz

    # Set up configuration
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i 's/database_name_here/your_database_name/' /var/www/html/wp-config.php
    sed -i 's/username_here/your_database_user/' /var/www/html/wp-config.php
    sed -i 's/password_here/your_database_password/' /var/www/html/wp-config.php

    # Set proper permissions
    chown -R www-data:www-data /var/www/html
fi
