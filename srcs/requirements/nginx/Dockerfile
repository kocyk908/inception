FROM alpine:3.22

ARG DOMAIN=lkoc.42.fr

EXPOSE 443

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl /run/nginx && \
    openssl req -x509 -nodes -newkey rsa:4096 -sha256 -days 365 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=PL/ST=Warsaw/L=Warsaw/O=42 School/OU=${DOMAIN}/CN=${DOMAIN}/" && \
    chmod 600 /etc/nginx/ssl/server.key && \
    rm -f /etc/nginx/conf.d/default.conf /etc/nginx/http.d/default.conf

COPY ./conf.d/nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]