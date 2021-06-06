# Location of the layers
layers := php-base php-extensions php-nginx php-api php-web

# The available targets and the default target
.PHONY: publish build $(layers)
.DEFAULT_GOAL := build

export IMAGE_USER ?= gbmcarlos
export IMAGE_TAG ?= 3.0.0

export COMPOSER_VERSION := 2.0
export PHP_VERSION := 7.4
export PHP_VERSION_SHORT := 74
export BREF_VERSION := 1.2.6
export DD_VERSION := 0.55.0

# Delegate 'build' and 'publish' to each layer
publish build: $(layers)

# php-api and php-web depend on php-nginx
php-api php-web: php-nginx

# php-nginx depends on php-base
php-nginx: $(php-base)

# php-extensions depends on php-base
php-extensions: $(php-base)

# The way to make each layer is to sub-make them in their directory
$(layers):
	$(MAKE) IMAGE_TAG=$(IMAGE_TAG) -C "layers/$@" $(TARGET)