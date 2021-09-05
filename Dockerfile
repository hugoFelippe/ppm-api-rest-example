FROM alpine:3.14

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    echo "UTC" | tee /etc/timezone && \
    apk del tzdata

RUN apk --no-cache add \
    php7 php7-opcache php7-fpm php7-cgi php7-ctype php7-json php7-dom php7-zip php7-zip php7-gd \
    php7-curl php7-mbstring php7-redis php7-mcrypt php7-iconv php7-posix php7-pdo_mysql php7-tokenizer php7-simplexml php7-session \
    php7-xml php7-sockets php7-openssl php7-fileinfo php7-ldap php7-exif php7-pcntl php7-xmlwriter php7-phar php7-zlib \
    php7-intl

ADD docker/etc/php.ini /etc/php7/php.ini

RUN apk --no-cache add bash

EXPOSE 80

COPY composer.phar /usr/local/bin/composer

WORKDIR /var/www

ADD run-nginx.sh /etc/app/run.sh
ENTRYPOINT ["/bin/bash", "/etc/app/run.sh"]
# ENTRYPOINT ["/bin/bash"]
# ENTRYPOINT ["/bin/bash", "/var/www/vendor/bin/ppm"]