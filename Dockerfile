FROM debian:wheezy

MAINTAINER Hierony Manurung <hierony.manurung@gdplabs.id>

ENV DEBIAN_FRONTEND noninteractive

COPY nginx_signing.key /tmp/nginx_signing.key
COPY dotdeb.gpg /tmp/dotdeb.gpg

RUN apt-key add /tmp/nginx_signing.key && \
    apt-key add /tmp/dotdeb.gpg && \
    echo "deb http://packages.dotdeb.org wheezy all" > \
    /etc/apt/sources.list.d/dotdeb.list && \
    echo "deb http://packages.dotdeb.org wheezy-php56 all" >> \
    /etc/apt/sources.list.d/dotdeb.list && \
    echo "deb http://nginx.org/packages/debian wheezy nginx" > \
    /etc/apt/sources.list.d/nginx.list && \
    apt-get clean && \
    apt-get update && \
    apt-get install -y \
    wget \
    curl \
    unzip \
    tar \
    vim \
    cron \
    procps \
    supervisor \
    nginx \
    php5 \
    php5-cli \
    php5-fpm \
    php5-mysql \
    php5-curl

COPY www.conf /etc/php5/fpm/pool.d/www.conf
COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY regrader /etc/nginx/sites-available/regrader
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /etc/nginx/sites-enabled /var/log/fpm && \
    rm -fr /etc/nginx/conf.d/* && \
    ln -sf /etc/nginx/sites-available/regrader /etc/nginx/sites-enabled/regrader && \
    mkdir -p /var/www/regrader

RUN DEBIAN_FRONTEND=noninteractive apt-get clean && \
    apt-get update && \
    apt-get install -y \
    build-essential \
    libfuse-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    mime-support \
    automake \
    libtool \
    tar && \
    apt-get autoremove -y && \
    rm -fr /var/lib/apt/list/*

COPY regrader-v2.2.1.tar.gz regrader-v2.2.1.tar.gz
RUN tar zxvf regrader-v2.2.1.tar.gz -C /var/www/regrader && \
    rm regrader-v2.2.1.tar.gz

COPY .env /var/www/regrader/.env
COPY regrader.ini /etc/php5/cli/conf.d/regrader.ini
COPY regrader.ini /etc/php5/fpm/conf.d/regrader.ini

RUN chown -R www-data /var/www/regrader
RUN apt-get install -y  php5-mysqlnd

RUN apt-get update && \
    apt-get install -y --no-install-recommends g++ && \
    rm -rf /var/lib/apt/lists/

RUN apt-get update && \
    apt-get install -y --no-install-recommends fp-compiler && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-7-jdk && \
    apt-get purge -y openjdk-6-jre-headless && \
    rm -rf /var/lib/apt/lists/*

COPY Site.php /var/www/regrader/application/controllers/Site.php

VOLUME ["/var/www/html/var/log", "/var/log/nginx", "/var/log/fpm"]
EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
