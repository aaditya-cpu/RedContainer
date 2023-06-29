FROM wordpress:php8.1-fpm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    less \
    libjpeg-dev \
    libpng-dev \
    libzip-dev \
    zlib1g-dev \
    libonig-dev \
    libxml2 \
    libxml2-dev \
    unzip \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j "$(nproc)" gd opcache pdo_mysql zip bcmath soap sockets \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo 'xdebug.mode=debug' >> /usr/local/etc/php/php.ini \
    && echo 'xdebug.client_host=host.docker.internal' >> /usr/local/etc/php/php.ini \
    && echo 'xdebug.client_port=9000' >> /usr/local/etc/php/php.ini \
    && echo 'xdebug.start_with_request=yes' >> /usr/local/etc/php/php.ini \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
