#!/bin/bash

set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then

    # Start mariadb
    mysqld_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0 &

    until mysqladmin -u root --password=$DB_ROOT_PASSWORD ping >/dev/null 2>&1; do
        sleep 1
    done

    mysql -u root --password=$DB_ROOT_PASSWORD <<- EOF
        SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}' WITH GRANT OPTION;
        DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
        CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
        CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO ${DB_USER}@'%';
        FLUSH PRIVILEGES;
EOF

    mysqladmin -u root --password=$DB_ROOT_PASSWORD shutdown

fi

# Start MariaDB using mysqld_safe in the background
mysqld_safe --datadir=/var/lib/mysql --user=mysql & wait


# Alternatively, you can use mysqld directly (but mysqld_safe is usually preferred)
# mysqld --datadir=/var/lib/mysql --user=mysql &
