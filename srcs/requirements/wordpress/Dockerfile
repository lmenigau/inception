FROM alpine:3.16
RUN apk add --no-cache php8-phar php8-fpm php8-mysqli
RUN wget https://wordpress.org/latest.tar.gz && tar x -f latest.tar.gz
RUN wget -O /bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
		&& chmod +x /bin/wp
RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/php8/php-fpm.d/www.conf
ADD ./wp-config.php /wordpress/ 
RUN wp core install --url=lomeniga.42.fr --admin_user=louis --admin_email=loou@x.com --title=Blog
VOLUME /wordpress/

