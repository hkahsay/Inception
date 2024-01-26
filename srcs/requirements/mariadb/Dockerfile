FROM debian:bullseye

# Install mariadb
RUN apt-get update -y && \
    apt upgrade -y && \
    apt-get install mariadb-server mariadb-client -y  


COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf


# Set ownership of the MySQL data directory
RUN chown -R mysql:mysql /var/lib/mysql

# Expose mariadb port
EXPOSE 3306

# Copy the script and set permissions
COPY ./tools/script.sh /script.sh
RUN chmod 755 /script.sh

# Set the entry point
ENTRYPOINT ["sh", "/script.sh"]