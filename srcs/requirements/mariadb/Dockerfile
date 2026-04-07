FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client bash openrc

RUN mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/lib/mysql

EXPOSE 3306
VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["entrypoint.sh"]

# FROM alpine:3.22

# RUN apk update && apk add --no-cache mariadb mariadb-client bash

# # Foldery muszą mieć odpowiednie uprawnienia dla użytkownika mysql
# RUN mkdir -p /var/lib/mysql /run/mysqld && \
#     chown -R mysql:mysql /var/lib/mysql /run/mysqld

# # Kopiowanie konfiguracji (upewnij się, że nazwa pliku na hoście jest poprawna)
# COPY conf/mariadb-conf.cnf /etc/my.cnf.d/mariadb-server.cnf
# COPY entrypoint.sh /usr/local/bin/

# RUN chmod +x /usr/local/bin/entrypoint.sh

# EXPOSE 3306

# ENTRYPOINT ["entrypoint.sh"]