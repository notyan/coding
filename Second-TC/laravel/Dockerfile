#FROM php:8.4
FROM composer:latest

ARG DB_NAME
ARG DB_HOST
ARG DB_USER
ARG DB_PASS

ENV DB_NAME=${DB_NAME}
ENV DB_HOST=${DB_HOST}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}

#RUN apt-get update -y && apt-get install -y openssl zip unzip
RUN apk update && apk add openssl zip unzip
RUN docker-php-ext-install pdo_mysql
WORKDIR /app
COPY ./app /app
RUN cp .env.example .env
RUN sed -i "s/DB_HOST=127.0.0.1/DB_HOST=${DB_HOST}/" .env
RUN sed -i "s/DB_USERNAME=root/DB_USERNAME=${DB_USER}/" .env
RUN sed -i "s/DB_PASSWORD=/DB_PASSWORD=${DB_PASS}/" .env
RUN sed -i "s/DB_DATABASE=laravel/DB_DATABASE=${DB_NAME}/" .env
RUN composer install -n -q
RUN php artisan key:generate

CMD php artisan migrate && php artisan serve --host=0.0.0.0 --port=2121
EXPOSE 2121