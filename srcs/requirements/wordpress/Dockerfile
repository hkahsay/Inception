FROM debian:bullseye

# Install PHP-FPM, and openSSL
RUN apt-get update && \
    apt-get install -y php-fpm openssl

COPY conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Expose PHP-FPM port (9000 by default)
EXPOSE 9000

# Set up WordPress if it doesn't exist
COPY scripts/install-wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install-wordpress.sh
RUN /usr/local/bin/install-wordpress.sh
# Start PHP-FPM
CMD ["php-fpm", "-F"]