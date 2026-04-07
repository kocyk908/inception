#!/bin/bash
set -e

echo "Starting WordPress setup"

if [ ! -f "/var/www/html/wp-settings.php" ]; then
    cp -r /usr/src/wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html
fi

until mariadb-admin ping -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PW}" --silent; do
    sleep 2
done
echo "DB is ready"

if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp config create \
        --path="/var/www/html" \
        --dbname="${DB_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PW}" \
        --dbhost="${DB_HOST}:3306" \
        --allow-root
fi

if [ ! wp core is-installed --path="/var/www/html" --allow-root 2>/dev/null ]; then
    echo "Installing WordPress"
    wp core install \
        --path="/var/www/html" \
        --url="https://${DOMAIN}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADM}" \
        --admin_password="${WORDPRESS_ADM_PW}" \
        --admin_email="${WORDPRESS_ADM_EMAIL}" \
        --skip-email \
        --allow-root

    echo "Second user"
    wp user create "${WORDPRESS_USER}" "${WORDPRESS_USER_EMAIL}" \
        --role="author" \
        --user_pass="${WORDPRESS_USER_PW}" \
        --path="/var/www/html" \
        --allow-root
fi

exec "$@"