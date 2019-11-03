FROM nginx

ADD ./vhosts/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www