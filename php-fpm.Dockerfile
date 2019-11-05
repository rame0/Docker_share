ARG PHP_VERSION=7.2


FROM php:$PHP_VERSION-fpm
ARG APT_INSTALL=-
ARG PECL_INSTALL=-
ARG EXTS_INSTALL=-
ARG EXTS_ENABLE=-

ENV APT_INSTALL ${APT_INSTALL}
ENV PECL_INSTALL ${PECL_INSTALL}
ENV EXTS_INSTALL ${EXTS_INSTALL}
ENV EXTS_ENABLE ${EXTS_ENABLE}

ADD ./scripts/init.sh /var/scripts/init.sh
RUN /bin/bash /var/scripts/init.sh

# RUN apt-get update && apt-get install -y $APT_INSTALL \
#     && pecl install $PECL_INSTALL \
#     && docker-php-ext-enable $EXTS_ENABLE


WORKDIR /var/www
