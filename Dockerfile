FROM php:8.1.0-apache

RUN apt-get update && apt-get install -y \
    libpng-dev mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-enable opcache \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-source delete

# Security
RUN sed -ri -e 's!expose_php = On!expose_php = Off!g' $PHP_INI_DIR/php.ini-production \
    && sed -ri -e 's!ServerTokens OS!ServerTokens Minor!g' /etc/apache2/conf-available/security.conf \
    && sed -ri -e 's!ServerSignature On!ServerSignature Off!g' /etc/apache2/conf-available/security.conf \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN a2enmod rewrite

CMD ["apache2-foreground"]
