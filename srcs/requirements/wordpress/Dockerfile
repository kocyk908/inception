FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache \
    bash \
    curl \
    mariadb-client \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-phar \
    php82-curl \
    php82-mbstring \
    php82-session \
    php82-json \
    php82-gd \
    php82-intl \
    php82-pdo_mysql \
    php82-openssl
    
RUN addgroup -S www-data || true; \
    adduser -S -G www-data -h /var/www -s /sbin/nologin www-data || true; \
    mkdir -p /var/www/html /run/php && \
    chown -R www-data:www-data /var/www /run/php

RUN ln -s /usr/bin/php82 /usr/bin/php && \
    sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's|^user = .*|user = www-data|' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's|^group = .*|group = www-data|' /etc/php82/php-fpm.d/www.conf && \
    sed -i 's|^;clear_env = no|clear_env = no|' /etc/php82/php-fpm.d/www.conf

RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

WORKDIR /var/www/html

RUN mkdir -p /usr/src/wordpress && \
    curl -o /tmp/wordpress.tar.gz -fSL https://wordpress.org/latest.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /usr/src/wordpress --strip-components=1 && \
    rm /tmp/wordpress.tar.gz && \
    chown -R www-data:www-data /usr/src/wordpress

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/php-fpm82", "-F"]