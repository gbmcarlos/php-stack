#####
# This image builds upon php-lambda
# Here we are going to 1) install and configure nginx and 2) install the init script, which will start and controll Nginx and PHP-FPM
# The result is an image upon which we can run PHP web applications
#####

FROM gbmcarlos/php-lambda:2.0.0 as base

## System dependencies
RUN amazon-linux-extras install \
        nginx1.12

### Set up permissions
RUN     groupadd www \
    &&  adduser -g www www \
    &&  mkdir -p /var/tmp/nginx \
    &&  chown -R www:www /var/tmp/nginx \
    &&  chown -R www:www /tmp

### Copy the init script
COPY init.sh /opt/bin/init.sh

### By default, execute the init.sh script
CMD ["/bin/sh", "-c", "/opt/bin/init.sh"]

WORKDIR /var/task
