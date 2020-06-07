FROM mariadb:10.3

ADD ./mysql-conf.d /etc/mysql/conf.d

# RUN mysql  -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root';"
# RUN mysql  -e "grant all on *.* to 'root'@'%';"
