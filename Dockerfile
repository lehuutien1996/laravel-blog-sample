FROM php:7.4-fpm

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install OS packages
RUN apt-get update -y && \
    apt-get install -y \
        git \
        zip unzip \
        tini \
        apache2

# Install PHP Extensions
RUN docker-php-ext-install pdo pdo_mysql && \
    docker-php-ext-enable pdo_mysql

# Create shared folder
RUN mkdir -p /shared

COPY rootfs /

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/app

COPY --chown=www-data:www-data . .

RUN composer install --no-scripts

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["php-fpm"]
