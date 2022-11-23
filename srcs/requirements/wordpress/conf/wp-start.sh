#!bin/sh

if [ ! -f "/var/www/wp-config.php" ]; 
then

    set -xv

    sleep 5
    cd /var/www/html
    wp download core --allow-root
    wp config create \
            --dbname=${DB_NAME} \
            --dbuser=${DB_USER} \
            --prompt=${DB_PASS} \
            --dbcharset="utf8" \
            --dbhost=mariadb:3306 \
            --allow-root
            
    wp core install \
            --url=${DOMAIN_NAME} \
            --title=${WP_TITLE} \
            --admin_user=${WP_ADMIN_USER} \
            --prompt=${WP_PASS} \
            --admin_email=${WP_ADMIN_EMAIL} \
            --allow-root

    wp user create \
            --user=${WP_USER} \
            --user_email=${WP_EMAIL} \
            --prompt=${WP_PASS} \
            --allow-root
    chown -R www-data:www-data /var/www/html/
fi

exec php-fpm8 -F
