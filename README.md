## What's this
The purpose of this project is to build a set of PHP environments as Docker images. It also contains an AWS Serverless Application to provide PHP support for Lambda functions

## Stack
- [**PHP Base**](#php-base): Based on the PHP binaries of [Bref](http://bref.sh/), install composer and a production-ready ini config file
- [**PHP Lambda**](#php-lambda): Based on *PHP Base*, add an AWS Lambda [PHP Runtime](https://github.com/gbmcarlos/php-runtime)
- [**PHP Nginx**](#php-nginx): Based on *PHP Lambda*, install and configure Nginx
- [**PHP API**](#php-api): Based on *PHP Nginx*, prepare some downstream triggers for a fully functional API project
- [**PHP Web**](#php-web): Based on *PHP Nginx*, prepare some downstream triggers for a fully functional Web project

### PHP Base
Uses [Bref's](http://bref.sh/) development FPM image, because it contains the appropiate SAPIs, and it contains Xdebug.
Installs `git` and `zip`, which are required by Composer. 
Removes Bref's ini file, and copies the production-ready ini file from the official Docker image of PHP
Installs Composer from their official Docker image.

### PHP Lambda
Uses [*PHP Base*](#php-base) as base image.
Installs a [PHP Runtime](https://github.com/gbmcarlos/php-runtime) from the Docker image.
It also contains instructions to extract all the necessary files as a zip file, create a Lambda Layer with it, and create a public AWS Serverless Application with the Layer.
More details in [the layer's README](layers/php-lambda/aws-sar/README.md)

### PHP Nginx
Uses [*PHP Lambda*](#php-lambda) as base image.
Installs Nginx.
Configures Nginx permissions.
Installs an init file to keep Nginx and PHP-FPM running

### PHP API
Uses [*PHP Nginx*](#php-nginx) as base image.
Registers downstream triggers (instructions that will be executed when this image is used a base image, in the child image's context) to:
- copy the Composer files (`composer.*`)
- install the Composer dependencies
- copy the source code (`src` folder)
- dump the Composer autoloader
- copy the config files (PHP's ini, PHP-FPM's ini, and Nginx)

### PHP Web
Uses [*PHP Nginx*](#php-nginx) as base image.
Installs NodeJS
Registers downstream triggers (instructions that will be executed when this image is used a base image, in the child image's context) to:
- copy the NPM files (`package*`)
- install the NPM dependencies
- copy the Composer files (`composer.*`)
- install the Composer dependencies
- copy the source code (`src` folder)
- compile the Webpack assets
- dump the Composer autoloader
- copy the config files (PHP's ini, PHP-FPM's ini, and Nginx)
