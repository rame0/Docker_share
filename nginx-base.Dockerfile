FROM nginx

ADD ./vhosts/nginx/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www