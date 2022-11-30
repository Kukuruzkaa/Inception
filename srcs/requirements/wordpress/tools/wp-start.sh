#!bin/sh

if [ ! -f "/var/www/html/wp-config.php" ]; 
then

    set -xv

    sleep 5
    cd /var/www/html
    rm -rf /var/www/html/wp-config-sample.php
    wp core download --allow-root
    wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost='mariadb:3306' --dbcharset="utf8" 
                  
    wp core install \
            --url=${DOMAIN_NAME} \
            --title=${WP_TITLE} \
            --admin_user=${WP_ADMIN_USER} \
            --admin_password=${WP_ADMIN_PASS} \
            --admin_email=${WP_ADMIN_EMAIL} \
            --allow-root

    wp theme install twentyseventeen --activate

    wp user create $WP_USER $WP_EMAIL \
	    --role=author \
            --user_pass=${WP_PASS} \
            --allow-root
    chown -R www-data:www-data /var/www/html/
fi

exec php-fpm8 -F
