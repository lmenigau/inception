# syntax=docker.io/docker/dockerfile:1
FROM alpine:3.15
RUN apk add mysql
RUN rm /etc/my.cnf.d/mariadb-server.cnf
RUN adduser -D mariadb -G mysql
RUN mysql_install_db --user=mariadb --datadir=/var/lib/mysql
RUN mkdir /run/mysqld && chown mariadb /run/mysqld
ARG DB_PASSWD
ARG ROOT_PWD
RUN <<DEOF mysqld --user=mariadb --datadir=/var/lib/mysql --bootstrap
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PWD';
CREATE DATABASE wpdb;
CREATE USER wp IDENTIFIED BY "$DB_PASSWD";
GRANT ALL PRIVILEGES ON wpdb.* TO wp;
DEOF
VOLUME /var/lib/mysql
