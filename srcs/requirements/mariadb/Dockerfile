FROM debian:bullseye

# Install mariadb
RUN apt-get update && \
    apt upgrade -y && \
    apt-get install mariadb-server -y  

COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# Expose mariadb port
EXPOSE 3306

CMD ["sh", "/script.sh"]