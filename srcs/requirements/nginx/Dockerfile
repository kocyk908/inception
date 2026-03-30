FROM alpine:3.22

ARG DOMAIN=lkoc.42.fr

RUN apk update && apk upgrade && apk add --no-cache nginx openssl bash

RUN mkdir -p /etc/nginx/ssl /run/nginx

RUN openssl req -x509 -nodes -newkey rsa:4096 -sha256 -days 365 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=PL/ST=Warsaw/L=Warsaw/O=42/OU=Inception/CN=${DOMAIN}"

RUN chmod 600 /etc/nginx/ssl/server.key

RUN rm -f /etc/nginx/http.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
