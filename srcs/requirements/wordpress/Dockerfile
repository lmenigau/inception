# syntax=docker/dockerfile:1
FROM alpine:3.16
RUN apk add --no-cache wait4ports php8-gd php8-mbstring php8-phar php8-fpm php8-mysqli
RUN wget -O /bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
		&& chmod +x /bin/wp
RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/php8/php-fpm.d/www.conf
RUN adduser -D wp && mkdir wordpress && chown wp:wp wordpress && chown wp /var/log/php8
USER wp
RUN wp core --path=/wordpress download
ARG DB_PASSWD
RUN wp --path=/wordpress config create --skip-check --dbhost=mariadb --dbname=wpdb --dbuser=wp --dbpass="${DB_PASSWD}"

COPY --chmod=755 <<EOF entry.sh
#!/bin/sh
cd /wordpress
wait4ports tcp://mariadb:mysql
if ! wp core is-installed
then
	wp core install --url=https://lomeniga.42.fr --admin_user=louis --admin_password="\$WP_PWD"\\
		--admin_email=elon@x.com --skip-email --title=Blog
	wp user create bob bob@example.com
fi
exec "\$@"
EOF
ENTRYPOINT ["./entry.sh"]
VOLUME /wordpress
