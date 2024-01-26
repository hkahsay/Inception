#!/bin/bash
set -x

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then

#start mariadb
#mysql_safe --datadir-/var/lib/mysql --user=mysql --bind-addreess=0.0.0.0 &
mysql --user=mysql &

until mysqladmin -u root --password='' ping >/dev/null 2>&1; do
	sleep 1
done

# mysqladmin -u root password '${MYSQL_ROOT_PASSWORD}'


# mysql -u root -p${MYSQL_ROOT_PASSWORD} <<- EOF
mysql -u root --password='' <<- EOF
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}' WITH GRANT OPTION;
    DELETE FROM mysql.user WHERE user != 'root' AND user != 'mariadb.sys' OR (user = 'root' AND host != 'localhost');
    CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};
    CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO ${DB_USER}@'%';
    FLUSH PRIVILEGES;
EOF

mysqladmin -uroot -p${DB_ROOT_PASSWARD} shoutdown

fi


# start MariaDB again, in the background
#mysqld_safe --datadir=/var/lib/mysql --user=mysql &
mysqld --user=mysql &
# wait till last launched process dies (never if all goes okay)
wait