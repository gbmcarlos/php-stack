#####
# This image builds upon php-base
# Here we are going to add gbmcarlos/php-runtime's PHP Lambda Runtime
#####

FROM gbmcarlos/php-runtime as runtime

FROM gbmcarlos/php-base as base

COPY --from=runtime /opt/bootstrap /opt/bootstrap
