#!/bin/bash

set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then

# --user refers to Unix user used to run mysql
# Command documentation: https://dev.mysql.com/doc/refman/5.7/en/mysql-install-db.html#option_mysql_install_MYSQL_USER
mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

if [ ! -f /home/hkahsay/data/wordpress/wp-config.php ]; then
# Start mariadb
# --user refers to Unix user used to run mysql
# Command documentation: https://dev.mysql.com/doc/refman/8.0/en/mysqld-safe.html#option_mysqld_safe_user
mysqld_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0 &

# --user and --password refer to the  MySQL account used for connecting to the server
# Command documentation: https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html#option_mysqladmin_password
until mysqladmin --user root ping >/dev/null 2>&1; do
    sleep 1
done

# Check if the database already exists
# Command documentation: https://dev.mysql.com/doc/refman/8.0/en/mysql-command-options.html

mysql --user root <<- EOF
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}' WITH GRANT OPTION;
    DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
    CREATE DATABASE ${DB_NAME};
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOF


mysqladmin --user=root --password=${DB_ROOT_PASSWORD} shutdown

fi

# Start MariaDB using mysqld_safe in the background
# --user refers to Unix user used to run mysql
mysqld_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0
