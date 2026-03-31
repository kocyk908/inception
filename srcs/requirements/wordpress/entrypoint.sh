#!/bin/bash
set -e

WP_PATH="${WP_PATH:-/var/www/html}"
WP_SOURCE_DIR="/usr/src/wordpress"
DB_PORT="${DB_PORT:-3306}"
WP_USER_ROLE="${WP_USER_ROLE:-author}"

mkdir -p "${WP_PATH}"

if [ ! -f "${WP_PATH}/wp-settings.php" ]; then
	if [ -f "${WP_SOURCE_DIR}/wp-settings.php" ]; then
		cp -r "${WP_SOURCE_DIR}/." "${WP_PATH}/"
	else
		wp core download --path="${WP_PATH}" --allow-root
	fi
fi

chown -R www-data:www-data "${WP_PATH}"

for i in $(seq 1 30); do
	if mariadb --skip-ssl \
		-h"${DB_HOST}" \
		-P"${DB_PORT}" \
		-u"${DB_USER}" \
		-p"${DB_PW}" \
		--protocol=tcp \
		-e "USE ${DB_NAME};" >/dev/null 2>&1; then
		break
	fi
	sleep 2
	if [ "${i}" -eq 30 ]; then
		echo "Database is not ready"
		exit 1
	fi
done

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
	wp config create \
		--path="${WP_PATH}" \
		--dbname="${DB_NAME}" \
		--dbuser="${DB_USER}" \
		--dbpass="${DB_PW}" \
		--dbhost="${DB_HOST}:${DB_PORT}" \
		--skip-check \
		--allow-root
fi

if ! wp core is-installed --path="${WP_PATH}" --allow-root >/dev/null 2>&1; then
	wp core install \
		--path="${WP_PATH}" \
		--url="https://${DOMAIN}" \
		--title="${WORDPRESS_TITLE}" \
		--admin_user="${WORDPRESS_ADM}" \
		--admin_password="${WORDPRESS_ADM_PW}" \
		--admin_email="${WORDPRESS_ADM_EMAIL}" \
		--skip-email \
		--allow-root
fi

wp option update home "https://${DOMAIN}" --path="${WP_PATH}" --allow-root >/dev/null 2>&1
wp option update siteurl "https://${DOMAIN}" --path="${WP_PATH}" --allow-root >/dev/null 2>&1

if wp user get "${WORDPRESS_ADM}" --path="${WP_PATH}" --allow-root >/dev/null 2>&1; then
	wp user update "${WORDPRESS_ADM}" \
		--user_email="${WORDPRESS_ADM_EMAIL}" \
		--user_pass="${WORDPRESS_ADM_PW}" \
		--display_name="${WORDPRESS_ADM}" \
		--path="${WP_PATH}" \
		--allow-root >/dev/null 2>&1
else
	wp user create "${WORDPRESS_ADM}" "${WORDPRESS_ADM_EMAIL}" \
		--role=administrator \
		--user_pass="${WORDPRESS_ADM_PW}" \
		--path="${WP_PATH}" \
		--allow-root >/dev/null 2>&1
fi

if [ -n "${WORDPRESS_USER}" ] && [ -n "${WORDPRESS_USER_EMAIL}" ] && [ -n "${WORDPRESS_USER_PW}" ]; then
	if wp user get "${WORDPRESS_USER}" --path="${WP_PATH}" --allow-root >/dev/null 2>&1; then
		wp user update "${WORDPRESS_USER}" \
			--user_email="${WORDPRESS_USER_EMAIL}" \
			--user_pass="${WORDPRESS_USER_PW}" \
			--path="${WP_PATH}" \
			--allow-root >/dev/null 2>&1
		wp user set-role "${WORDPRESS_USER}" "${WP_USER_ROLE}" \
			--path="${WP_PATH}" \
			--allow-root >/dev/null 2>&1
	else
		wp user create "${WORDPRESS_USER}" "${WORDPRESS_USER_EMAIL}" \
			--role="${WP_USER_ROLE}" \
			--user_pass="${WORDPRESS_USER_PW}" \
			--path="${WP_PATH}" \
			--allow-root >/dev/null 2>&1
	fi
fi

exec "$@"