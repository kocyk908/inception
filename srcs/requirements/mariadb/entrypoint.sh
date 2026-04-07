#!/bin/sh
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "[init] Initializing MariaDB"
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --rpm >/dev/null

    echo "[init] Creating init.sql"
    cat <<EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PW}';
ALTER USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PW}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    chown mysql:mysql /tmp/init.sql
else
    touch /tmp/init.sql
    chown mysql:mysql /tmp/init.sql
fi

echo "[run] Starting MariaDB"
exec mariadbd --user=mysql