FROM alpine:3.16
RUN apk add --no-cache mariadb mariadb-client
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
RUN mysql_admin
RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
