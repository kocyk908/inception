FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client bash

RUN mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY conf/mariadb-conf.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/lib/mysql
EXPOSE 3309
VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["entrypoint.sh"]