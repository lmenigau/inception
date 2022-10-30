FROM alpine:3.16
RUN apk add --no-cache php81-fpm php81-mysqli
RUN wget https://wordpress.org/latest.tar.gz
RUN tar x -o -f latest.tar.gz
run sed -i 's/127.0.0.1/0.0.0.0/' /etc/php81/php-fpm.d/www.conf
VOLUME /wordpress

