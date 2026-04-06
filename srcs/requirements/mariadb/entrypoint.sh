# #!/bin/sh
# set -e

# DB_DIR="/var/lib/mysql"
# RUN_DIR="/run/mysqld"
# INIT_SQL="/tmp/init.sql"

# mkdir -p "$DB_DIR" "$RUN_DIR"
# chown -R mysql:mysql "$DB_DIR" "$RUN_DIR"
# chmod 750 "$DB_DIR"

# FIRST_INIT=0
# if [ ! -d "$DB_DIR/mysql" ] || [ ! -f "$DB_DIR/ibdata1" ]; then
#     FIRST_INIT=1
# fi

# if [ "$FIRST_INIT" -eq 1 ]; then
#     mariadb-install-db --user=mysql --datadir="$DB_DIR" --rpm >/dev/null

#     cat > "$INIT_SQL" <<EOF
# USE mysql;
# FLUSH PRIVILEGES;
# CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
# CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PW}';
# GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PW}';
# FLUSH PRIVILEGES;
# EOF
#     chown mysql:mysql "$INIT_SQL"
#     chmod 600 "$INIT_SQL"
# else
#     touch "$INIT_SQL"
#     chown mysql:mysql "$INIT_SQL"
# fi

# exec mysqld --user=mysql

#!/bin/sh
set -e

# 1. Inicjalizacja bazy, jeśli folder jest pusty
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "[MariaDB] Initializing database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --rpm >/dev/null

    # Uruchomienie w tle bez sieci do bezpiecznej konfiguracji
    mariadbd --user=mysql --skip-networking &
    pid="$!"

    # Czekanie na socket (zgodnie z Twoim .cnf)
    until mariadb -u root --protocol=socket -S /run/mysqld/mysqld.sock -e "SELECT 1" >/dev/null 2>&1; do
        sleep 1
    done

    echo "[MariaDB] Setting up users and passwords..."
    mariadb -u root --protocol=socket -S /run/mysqld/mysqld.sock <<EOF
        -- Tworzenie bazy danych
        CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`;
        -- Tworzenie usera WordPress
        CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PW}';
        GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_USER}'@'%';
        -- Ustawienie hasła roota (ważne dla Healthchecka!)
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PW}';
        FLUSH PRIVILEGES;
EOF

    echo "[MariaDB] Shutdown temporary server..."
    kill "$pid"
    wait "$pid"
fi

# 2. Start właściwego serwera
echo "[MariaDB] Starting server..."
exec mariadbd --user=mysql