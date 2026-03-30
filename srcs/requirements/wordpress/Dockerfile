FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache \
    bash \
    curl \
    mariadb-client \
    netcat-openbsd \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-phar \
    php82-curl \
    php82-mbstring \
    php82-xml \
    php82-session \
    php82-openssl \
    php82-json \
    php82-zip \
    php82-gd \
    php82-intl \
    php82-pdo \
    php82-pdo_mysql \
    php82-tokenizer \
    php82-dom

RUN ln -s /usr/bin/php82 /usr/bin/php && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    addgroup -S www-data && \
    adduser -S -G www-data -h /var/www -s /sbin/nologin www-data || true && \
    sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's|^user = .*|user = www-data|' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's|^group = .*|group = www-data|' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's|^;clear_env = no|clear_env = no|' /etc/php82/php-fpm.d/www.conf && \
    mkdir -p /var/www/html /run/php && \
    chown -R www-data:www-data /var/www /run/php

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/sbin/php-fpm82", "-F"]
