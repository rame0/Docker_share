FROM mariadb:10.3

ADD ./mysql-conf.d/00-custom.cnf /etc/mysql/conf.d/00-custom.cnf
ADD ./secret/optorg.sql.gz /root/mysqldump.sql.gz

# RUN mysql  -e "CREATE USER 'root'@'%' IDENTIFIED BY 'root';"
# RUN mysql  -e "grant all on *.* to 'root'@'%';"
