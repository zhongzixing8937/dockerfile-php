FROM php:7.2-fpm

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
        wget \
        ssh \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libzip-dev \
        zlib1g-dev \
        libpng-dev \
        libxml2-dev \
        libmcrypt-dev \
    ; \
    \
    docker-php-ext-configure gd \
        --with-freetype-dir=/usr \
        --with-jpeg-dir=/usr \
        --with-png-dir=/usr \
    ; \
    \
    docker-php-ext-install -j$(nproc) \
        iconv \
        opcache \
        zip \
        gd \
        pdo \
        pdo_mysql \
        pcntl \
        soap \
    ; \
    \
    pecl install mcrypt-1.0.2 && docker-php-ext-enable mcrypt; \
    pecl install redis && docker-php-ext-enable redis; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*
