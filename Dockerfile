FROM debian:8.2

MAINTAINER Ha Phan <thanhha.work@gmail.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    wget \
    apt-utils \
    apt-transport-https

ADD ./repo/dotdeb.list /etc/apt/sources.list.d/
RUN wget -qO - https://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends  -y \
    nginx \
    supervisor \
    php7.0-fpm \
    php7.0-cli \
    php7.0-json \
    php7.0-intl \
    php7.0-opcache \
    php7.0-mysql \
    php7.0-mcrypt &&\
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Forward access log to log collector
RUN  \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

#PHP-FPM
ADD ./php/fpm/php.ini /etc/php/7.0/fpm/php.ini
ADD ./php/fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD ./php/fpm/www.conf /etc/php/7.0/fpm/pool.d/www.conf

#NGINX config
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./nginx/vhost.conf /etc/nginx/sites-available/default

#SUPERVISOR
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

EXPOSE 80 443

VOLUME ["/srv"]

WORKDIR /srv

CMD ["/usr/bin/supervisord"]