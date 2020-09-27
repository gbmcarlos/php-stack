# Location of the layers
layers := layers/php-base layers/php-lambda layers/php-nginx layers/php-api layers/php-web

# The available targets and the default target
.PHONY: publish build $(layers)
.DEFAULT_GOAL := build

export IMAGE_USER := gbmcarlos
export IMAGE_TAG := latest

# Delegate 'build' and 'publish' to each layer
build: $(layers)

# php-api and php-web depend on php-nginx
php-api php-web: php-nginx

# php-nginx depends on php-lambda
php-nginx: $(php-lambda)

# php-lambda depends on php-base
php-lambda: $(php-base)

# The way to make each layer is to sub-make them in their directory
$(layers):
	$(MAKE) -C $@ $(TARGET)