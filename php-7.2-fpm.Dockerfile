FROM php:7.2-fpm

RUN apt-get update && apt-get install -y wget curl \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

ADD ./php_ini/base.ini /usr/local/etc/php/php.ini

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

WORKDIR /var/www