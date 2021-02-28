#####
# This image builds upon php-base
# Download the source code of ddtrace, generate the ini file, and isolate them a clean image
#####

ARG DD_VERSION=0.55.0

FROM bref/build-php-74:1.1.1 as build

ARG DD_VERSION

RUN     curl -sL https://github.com/DataDog/dd-trace-php/releases/download/${DD_VERSION}/datadog-php-tracer-${DD_VERSION}.x86_64.tar.gz | tar -xz \
    &&  mv opt/* /opt/

RUN echo $'\
extension=/opt/datadog-php/extensions/no-debug-non-zts-20190902/ddtrace.so \n\
ddtrace.request_init_hook=/opt/bref/lib/php/extensions/dd-trace-php-0.54.0/bridge/dd_wrap_autoloader.php' \
    > /tmp/ext.ini

FROM scratch as base

# Copy the extensions, the source for the tracer and the statsd, and the ini file
COPY --from=build /opt/datadog-php/extensions/ddtrace-20190902.so /opt/datadog-php/extensions/no-debug-non-zts-20190902/ddtrace.so
COPY --from=build /opt/datadog-php/dd-trace-sources /opt/datadog-php/dd-trace-sources
COPY --from=build /tmp/ext.ini /opt/bref/etc/php/conf.d/ext-ddtrace.ini