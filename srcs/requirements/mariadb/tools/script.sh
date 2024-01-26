#!/bin/bash

set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

#if [ ! -f /var/www/wordpress/wp-config.php ]; then

#start mariadb
# mysql_safe --datadir=/var/lib/mysql --user=mysql --bind-address=0.0.0.0
mysqld --datadir=/var/lib/mysql --user=mysql &


mysqld --user=mysql &
mysql_pid=$!

until mysqladmin -u root -p$DB_ROOT_PASSWORD ping >/dev/null 2>&1; do
	sleep 1
done

# mysqladmin -u root password '${MYSQL_ROOT_PASSWORD}'


# mysql -u root -p${MYSQL_ROOT_PASSWORD} <<- EOF
mysql -u root -p$DB_ROOT_PASSWORD <<- EOF
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}' WITH GRANT OPTION;
    DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
    CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO ${DB_USER}@'%';
    FLUSH PRIVILEGES;
EOF

mysqladmin -u root -p${DB_ROOT_PASSWARD} shoutdown

#fi

# Start MariaDB using mysqld_safe in the background
# mysqld_safe --datadir=/var/lib/mysql --user=mysql &

# Alternatively, you can use mysqld directly (but mysqld_safe is usually preferred)
# mysqld --datadir=/var/lib/mysql --user=mysql &
kill $mysql_pid
wait  $mysql_pid
#mysqld --user=mysql --bind-address=0.0.0.0
exec mysqld --user=mysql
# wait till last launched process dies (never if all goes okay)