# Dockerfile

FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y install wget

# Using 7.4 because it seems to be the latest one supported by debian bullseye.
# Suboptimal: 7.4 is already EOL (End Of Life): https://www.php.net/supported-versions.php.
RUN apt-get install -y php7.4
RUN apt-get install -y php7.4-fpm \
php7.4-mysql \
php7.4-phar \
php7.4-json \
php7.4-xml \
php7.4-mbstring \
php7.4-curl \
php7.4-gd \
php7.4-intl \
php7.4-zip \
mariadb-client

COPY ./conf/wp.conf /etc/php/7.4/fpm/pool.d/www.conf
# COPY ./conf/wp-config-docker.php /var/www/wordpress/wp-config.php

# RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
# RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
# RUN chown -R root:root /var/www/wordpress

# wp config cli and config
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY scripts/docker-entrypoint.sh /scripts/entrypoints.sh
RUN chmod +x /scripts/entrypoints.sh

WORKDIR /var/www/wordpress

# See https://www.digitalocean.com/community/tutorials/php-fpm-nginx

# Create a group and user for WordPress
RUN groupadd wordpress_user \
    && useradd -g wordpress_user wordpress_user

# Create a directory for PHP-FPM socket
RUN mkdir /run/php \
    && chmod 755 /run/php \
    && chown wordpress_user:wordpress_user /run/php

EXPOSE 9000
ENTRYPOINT ["sh", "/scripts/entrypoints.sh"]
