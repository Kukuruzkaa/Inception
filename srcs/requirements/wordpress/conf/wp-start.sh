#!bin/sh

# if [ ! -f "/var/www/wp-config.php" ]; then

# EOF
# fi

set -xv

sleep 5
wp download core --allow-root
wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --prompt=${DB_PASS} --dbhost=mariadb --allow-root
wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} \
    --admin_email=${WP_ADMIN_EMAIL} --prompt=${WP_PASS} 
wp user create --user=${WP_USER} --admin_email=${WP_USER_EMAIL} --prompt=${WP_PASS} 

exec php-fpm8 -F
