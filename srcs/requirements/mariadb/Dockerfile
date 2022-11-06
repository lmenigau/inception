# syntax=docker/dockerfile:1
FROM alpine:3.16
RUN apk add mysql
RUN rm /etc/my.cnf.d/mariadb-server.cnf
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN <<DEOF mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap
FLUSH PRIVILEGES;
CREATE DATABASE wpdb;
CREATE USER wp IDENTIFIED BY "$DB_PASSWD";
GRANT ALL PRIVILEGES ON wpdb.* TO wp;
SHUTDOWN;
DEOF
VOLUME /var/lib/mysql
