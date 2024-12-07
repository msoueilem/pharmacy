FROM php:7.4-apache

# Install necessary extensions
RUN apt-get update && \
    apt-get install -y \
    libonig-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    libjpeg62-turbo-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable GD extension
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Enable ZIP extension
RUN docker-php-ext-install zip

WORKDIR /var/www/html

COPY composer.json composer.lock ./

# Ensure the database/seeds directory exists
RUN mkdir -p database/seeds
RUN mkdir -p database/factories

# Run composer install as www-data
RUN su www-data -s /bin/bash -c "composer install --no-dev --optimize-autoloader --no-scripts"

COPY . .

RUN chown -R www-data:www-data /var/www/html/storage

CMD ["apache2-foreground"]
