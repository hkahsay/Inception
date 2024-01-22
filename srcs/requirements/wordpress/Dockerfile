FROM debian:bullseye

# Install PHP-FPM, and openSSL
RUN apt-get update && \
    apt-get install -y openssl curl wget \
    lsb-release \
	gnupg gnupg2 gnupg1 && \
    wget -qO - https://packages.sury.org/php/apt.gpg | tee /etc/apt/trusted.gpg.d/php.gpg >/dev/null && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list

RUN apt-get update -y
RUN apt-get install -y php8.0
RUN apt-get install -y php8.0-fpm
RUN apt-get install -y php8.0-cli
RUN apt-get install -y php8.0-mysql
RUN apt-get install -y php8.0-xdebug 
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod u+x /usr/local/bin/wp 
RUN wp --info

COPY conf/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf
COPY conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

# Expose PHP-FPM port (9000 by default)
EXPOSE 9000

# Set up WordPress if it doesn't exist
COPY scripts/install-wordpress.sh /usr/local/bin/
# COPY scripts/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/install-wordpress.sh
RUN /usr/local/bin/install-wordpress.sh
# Start PHP-FPM
# ENTRYPOINT ["/bin/sh", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm8.0", "-F"]
#CMD ["sleep", "infinity"]