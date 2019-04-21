FROM alpine:3.9

RUN apk update \
    && apk add --update --no-cache nginx \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx.vh.php.conf /etc/nginx/conf.d/default.conf
COPY index.php /usr/share/nginx/html/index.php

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

