#!/bin/sh
set -e

cd /var/www/html

if [ ! -f wp-config.php ]; then
    until nc -z ${DB_HOST} 3306; do
        sleep 1
    done

    wp core download --allow-root

    wp config create \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PW} \
        --dbhost=${DB_HOST}:3306 \
        --allow-root
        
    wp core install \
        --url=https://${DOMAIN} \
        --title=${WORDPRESS_TITLE} \
        --admin_user=${WORDPRESS_ADM} \
        --admin_password=${WORDPRESS_ADM_PW} \
        --admin_email=${WORDPRESS_ADM_EMAIL} \
        --skip-email \
        --allow-root

    wp user create \
        ${WORDPRESS_USER} \
        ${WORDPRESS_USER_EMAIL} \
        --user_pass=${WORDPRESS_USER_PW} \
        --role=author \
        --allow-root

    chown -R www-data:www-data /var/www/html
fi

echo "Starting PHP-FPM server..."
exec "$@"
