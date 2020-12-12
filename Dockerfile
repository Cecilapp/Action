FROM php:7.4-cli-alpine

# Arguments
ARG args
RUN if [[ -z "$args" ]] ; then echo Argument not provided ; else echo Argument is $args ; fi

# i18n
RUN apk add --no-cache gettext-dev icu-dev \
&& docker-php-ext-install -j$(nproc) gettext \
&& docker-php-ext-install -j$(nproc) intl

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
