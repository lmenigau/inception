# syntax=docker.io/docker/dockerfile:1
FROM alpine:3.16
RUN apk add mysql
RUN rm /etc/my.cnf.d/mariadb-server.cnf
RUN adduser -D mariadb -G mysq
RUN mysql_install_db --user=mariadb --datadir=/var/lib/mysql
RUN mkdir /run/mysqld && chown mariadb /run/mysqld
ARG DB_PASSWD
RUN <<DEOF mysqld --user=mariadb --datadir=/var/lib/mysql --bootstrap
FLUSH PRIVILEGES;
CREATE DATABASE wpdb;
CREATE USER wp IDENTIFIED BY "$DB_PASSWD";
GRANT ALL PRIVILEGES ON wpdb.* TO wp;
DEOF
VOLUME /var/lib/mysql/wpdb
