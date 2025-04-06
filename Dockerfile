# Use the official PHP image from Docker Hub
FROM php:8.0-fpm

# Install necessary extensions for Laravel
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Install Composer (for managing PHP dependencies)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory inside the container
WORKDIR /var/www

# Copy the Laravel project files into the container
COPY . .

# Install Laravel's PHP dependencies
RUN composer install --no-interaction --prefer-dist

# Expose the port that PHP-FPM will use
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]

