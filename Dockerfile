FROM php:7.4-apache

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y \
        libonig-dev \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install gd \
        pdo pdo_mysql mbstring zip

# Set working directory
WORKDIR /var/www/html

# Copy composer files
COPY composer.json composer.lock ./

# Install composer dependencies
# Use --no-scripts to prevent issues with post-install scripts running as root
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copy project files
COPY . .

# Set up Apache
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
