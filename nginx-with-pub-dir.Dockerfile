FROM nginx

ARG DOMAIN=withpublicdir
ADD ./vhosts/nginx/$DOMAIN.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www