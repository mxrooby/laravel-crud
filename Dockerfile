# Set working directory
WORKDIR /var/www/html

# Copy app files
COPY . /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Laravel dependencies
RUN composer install --no-interaction --prefer-dist \
    && php artisan config:clear \
    && php artisan route:clear \
    && php artisan view:clear \
    && php artisan optimize

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# 👇 Add this to make Apache serve from the public directory
WORKDIR /var/www/html/public

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
