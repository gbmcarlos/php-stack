#####
# This image builds upon Bref's compiled php
# Here we are going to fix a few things and replace a few others
# The result is an image where /opt contains everything required to execute PHP (+php-fpm, +composer)
#####

## Composer
### We extract composer executable from this image
FROM composer:2.0 as target-composer

## PHP config
### We extract php's production-ready config file from this image
FROM php:7.4 as target-php

## PHP GD extension
### The GD extension is not installed by default, so we have to extract it from a separate image
FROM bref/extra-gd-php-74:0.8 as gd-extra

## Base PHP
### We start with this image as base
FROM bref/php-74-fpm-dev:1.0.0 as base

### We need to switch to root to use yum
USER root

### Add the GD extension
### (https://github.com/brefphp/extra-php-extensions#local-development)
COPY --from=gd-extra /opt /opt

### vim, htop, less and tree are utilities to work inside the container more comfortably
### git, zip and unzip are necessary for Composer to install dependencies
RUN     amazon-linux-extras install -y epel \
    &&  yum -y install \
            vim htop less tree \
            git zip unzip

### Replace bref's config file with the oficial PHP image's config file
RUN rm /opt/bref/etc/php/conf.d/bref.ini
COPY --from=target-php /usr/local/etc/php/php.ini-production /opt/bref/etc/php/conf.d/php.ini

### Add composer
COPY --from=target-composer /usr/bin/composer /opt/bin/composer

### Add /usr/sbin to the path
ENV PATH="/usr/sbin:${PATH}"
