# 1. Check if WordPress is intalled at /var/www/wordpress. If not, install it:
#   1.1 ...
# See https://make.wordpress.org/cli/handbook/how-to/how-to-install/

# Check what wpi-cli is installed and can run
wp cli version --allow-root
if [ ! -f /var/www/wordpress/wp-config.php ] # Checks if wp-config.php exists
then
    echo "Installing WordPress..."
    
fi

# 2. Start php-fpm
php-fpm7.4 -F