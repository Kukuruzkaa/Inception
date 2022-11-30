FROM alpine:3.16
ARG PHP_VERSION=8 
   
RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHO_VERSION}-cli \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-gd \
    php${PHP_VESRION}-intl \
    php${PHP_VESRION}-opcache \
    wget \
    mysql-client \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = www-data|g" \
      /etc/php8/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = www-data|g" \
      /etc/php8/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

COPY  requirements/wordpress/tools/wp-start.sh /var/wp-start.sh
RUN chmod +x /var/wp-start.sh
RUN mkdir /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT [ "sh", "/var/wp-start.sh" ]
