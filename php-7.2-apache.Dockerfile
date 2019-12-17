FROM php:7.2-apache

RUN sed -ri 's/^www-data:x:33:33:/www-data:x:1000:1000:/' /etc/passwd

ENV APACHE_LOG_DIR /var/log/apache2

ADD ./secret/vhosts/apache/ /etc/apache2/sites-enabled
ADD ./secret/php_ini/optorg.ini /usr/local/etc/php/conf.d/optorg.ini


RUN apt-get update && apt-get install -y wget curl libbz2-dev libpng-dev

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN docker-php-ext-install -j$(nproc) pdo
RUN docker-php-ext-enable pdo

RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-enable pdo_mysql

RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-enable iconv

RUN docker-php-ext-install -j$(nproc) bz2
RUN docker-php-ext-enable bz2

RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-enable gd

RUN docker-php-ext-install -j$(nproc) ctype
RUN docker-php-ext-enable ctype

RUN docker-php-ext-install -j$(nproc) mbstring
RUN docker-php-ext-enable mbstring

RUN apt-get install -y libicu-dev
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-enable intl

RUN apt-get install -y imagemagick libmagickwand-dev
RUN pecl install imagick
RUN docker-php-ext-enable imagick

RUN docker-php-ext-install -j$(nproc) json
RUN docker-php-ext-enable json

RUN docker-php-ext-install -j$(nproc) simplexml
RUN docker-php-ext-enable simplexml

RUN docker-php-ext-install -j$(nproc) xmlwriter
RUN docker-php-ext-enable xmlwriter

RUN apt-get install -y libxml2-dev \
    	&& CFLAGS="-I/usr/src/php" docker-php-ext-install xmlreader \
    # should be able to uninstall the dev now
    	&& apt-get purge -y --auto-remove libxml2-dev \
    	&& rm -r /var/lib/apt/lists/*


RUN a2enmod ssl rewrite


WORKDIR /etc/apache2
RUN mkdir ssl
WORKDIR /etc/apache2/ssl
RUN openssl genrsa -passout pass:foobar -out notEncodedPk.key 3072
RUN openssl req -new -out optorg.csr -sha256 -key notEncodedPk.key \
    -subj '/C=RU/ST=SPb/L=SPb/O=Global Security/OU=IT Department/CN=op-torg.ru/CN=test'
RUN openssl x509 -req -in optorg.csr -days 365 -signkey notEncodedPk.key -out optorg.cert -outform PEM


WORKDIR /var/www/optorg