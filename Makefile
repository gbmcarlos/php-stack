# Location of the layers
layers := php-base php-extensions php-lambda php-nginx php-api php-web

# The available targets and the default target
.PHONY: publish build $(layers)
.DEFAULT_GOAL := build

export IMAGE_USER ?= gbmcarlos
export IMAGE_TAG ?= 2.0.0

# Delegate 'build' and 'publish' to each layer
publish build: $(layers)

# php-api and php-web depend on php-nginx
php-api php-web: php-nginx

# php-nginx depends on php-lambda
php-nginx: $(php-lambda)

# php-lambda depends on php-base
php-lambda: $(php-base)

# php-extensions depends on php-base
php-extensions: $(php-base)

# The way to make each layer is to sub-make them in their directory
$(layers):
	$(MAKE) IMAGE_TAG=$(IMAGE_TAG) -C "layers/$@" $(TARGET)