# 1/ Project name -------------------------------------------------
# Must be lower-case, no spaces and no invalid path chars.
# Will be used also as the WP database name
COMPOSE_PROJECT_NAME=localhost

# TODO: security: don't send this in containers
HOST_VOLUME_ROOT=data

DOMAIN_NAME=hkahsay.42.fr

# 2/ Database user and password -----------------------------------------
# Set non-root database user if wanted (optional)
DB_ROOT_PASSWORD=root
DB_PASSWORD=password
DB_USER=hkahsay
DB_NAME=wordpressdb
DB_HOST=localhost

# 3/ For wordpress auto-install and auto-configuration -------------------
WP_WEBSITE_TITLE="Inception docker from crash"

# URL
WP_WEBSITE_URL="http://localhost"
WP_WEBSITE_URL_WITHOUT_HTTP=localhost

# Website admin identification. Specify a strong password
WP_ADMIN_USER="hkahsay"
WP_ADMIN_PASSWORD="wordpress"
WP_ADMIN_EMAIL="hkahsay@student.42lausanne.ch"

# Website admin identification. Specify a strong password
WP_RANDOM_USER="rAndom_user"
WP_RANDOM_PASSWORD="rAndom_user"
WP_RANDOM_EMAIL="random_user@example.com"
# 4/ Software versions -----------------------------------------------
# WP_VERSION=latest
# MARIADB_VERSION=latest

# 5/ Ports: Can be changed -------------------------------------------

# 6/ Volumes on host --------------------------------------------------
WP_DATA_DIR=./wordpress

# 7/ Healthcheck availability of host services (mysql and woordpress server)
# Waiting time in second
# WAIT_BEFORE_HOSTS=5
# WAIT_AFTER_HOSTS=5
# WAIT_HOSTS_TIMEOUT=300
# WAIT_SLEEP_INTERVAL=60
# WAIT_HOST_CONNECT_TIMEOUT=5

# 8/ Used only in online deployement --------------------------------------
# WORDPRESS_WEBSITE_URL_WITHOUT_WWW=example.com
# PHPMYADMIN_WEBSITE_URL_WITHOUT_HTTP=sql.example.com