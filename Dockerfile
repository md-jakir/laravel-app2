FROM php:7.4-fpm-alpine

ENV \
  APP_DIR="/app" \
  APP_PORT="8000"

RUN docker-php-ext-install pdo pdo_mysql sockets
RUN curl -sS https://getcomposer.org/installer | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR $APP_DIR
COPY . .
RUN composer install

CMD php artisan serve --host=0.0.0.0 --port=$APP_PORT
