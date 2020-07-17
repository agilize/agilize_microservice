FROM php:7.4-fpm-alpine

# System dependencies
RUN apk add --no-cache \
        openssl \
        bash-doc \
        bash-completion \
        libcurl \
        libzip-dev \
        oniguruma-dev \
        curl-dev \
        libxml2-dev \
        libxslt-dev \
        icu-dev \
        gettext \
        gettext-dev \
        postgresql-dev

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Packages
# Feel free to remove things you won't use
RUN docker-php-ext-install -j$(nproc) pdo \
        pdo_pgsql \
        mbstring \
        bcmath \
        opcache \
        calendar \
        exif \
        pcntl \
        shmop \
        sysvmsg \
        sysvsem \
        sysvshm \
        curl \
        xml \
        soap \
        xsl \
        gettext \
        zip \
        sockets

RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER true

# Run composer and phpunit installation.
RUN composer selfupdate && \
  composer global require --dev "phpunit/phpunit:^9" && \
  ln -s ~/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

# PHP.ini Config

RUN sed -i 's|;date.timezone =|date.timezone = "America/Bahia"|g' "$PHP_INI_DIR/php.ini"
RUN sed -i 's|upload_max_filesize = 2M|upload_max_filesize = 100M|g' "$PHP_INI_DIR/php.ini"
RUN sed -i 's|post_max_size = 8M|post_max_size = 100M|g' "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/html

COPY . .

## two step build