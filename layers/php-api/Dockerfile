#####
# This image builds upon php-nginx
# Here we are going to set the instructions necessary to have a full Lumen project running
# All these instrucionts will be executed on the downstream Dockerfile (the Dockerfile that uses this image as FROM)
#####

ARG PHP_NGINX_VERSION

FROM gbmcarlos/php-nginx:${PHP_NGINX_VERSION} as base

## Composer dependencies
### Install just the dependencies, without the code, so no need to dump the autoloader yet
ONBUILD COPY ./composer.* ./
ONBUILD RUN composer install \
                -v --no-autoloader --no-dev --no-interaction --no-ansi

## Source code
ONBUILD COPY --chown=www:www ./src ./src

## Composer autoloader
### Now that we've copied the source code, dump the autoloader, optimized by default
ONBUILD RUN composer dump-autoload -v --classmap-authoritative --no-dev --no-interaction --no-ansi

### Project-specific config files
ONBUILD COPY config/php.ini ./php/conf.d/php.ini
ONBUILD COPY config/php-fpm.ini ./php-fpm/conf.d/php-fpm.ini
ONBUILD COPY config/nginx.conf /etc/nginx/nginx.conf

## ENV VARS
### Release and other app-defining env vars
### PHP-FPM configuration
### Deployment configuration
ONBUILD ARG APP_RELEASE=latest
ONBUILD ENV APP_RELEASE=$APP_RELEASE \
    APP_NAME=localhost \
    APP_PORT=80 \
    BASIC_AUTH_ENABLED=true \
    BASIC_AUTH_USERNAME=admin \
    BASIC_AUTH_PASSWORD=${APP_NAME}"_password" \
    XDEBUG_MODE=off \
    MEMORY_LIMIT="128M" \
    PHP_FPM=dynamic \
    PHP_FPM_MAX_CHILDREN=100 \
    PHP_FPM_MAX_REQUESTS=500 \
    PHP_FPM_MIN_SPARE_SERVERS=16 \
    PHP_FPM_MAX_SPARE_SERVERS=32
