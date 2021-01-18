#####
# This image builds upon php-base
# Download the source code of ddtrace, `make` it, and isolate in a clean image
#####

ARG DD_VERSION=0.53.0

FROM bref/build-php-74:1.1.1 as build

ARG DD_VERSION

RUN LD_LIBRARY_PATH= yum install -y \
        curl-devel

RUN     curl -sL https://github.com/DataDog/dd-trace-php/archive/${DD_VERSION}.tar.gz | tar -xz && cd dd-trace-php-${DD_VERSION} \
    &&  phpize \
    &&  ./configure \
            --enable-option-checking=fatal \
            --enable-ddtrace \
    &&  make \
    &&  make install

FROM scratch as base

# Copy things we installed to the final image
COPY --from=build /opt/bref/lib/php/extensions/no-debug-non-zts-20190902/ddtrace.so /opt/bref/lib/php/extensions/no-debug-non-zts-20190902/ddtrace.so
COPY --from=build /tmp/build/php/dd-trace-php-0.53.0/bridge/dd_wrap_autoloader.php /opt/bref/lib/php/extensions/ddtrace/dd_wrap_autoloader.php