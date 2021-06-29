#!/bin/bash
set -e

# Download Cecil
echo "Download Cecil $INPUT_VERSION"
if [[ -z "$INPUT_VERSION" ]]; then
  curl -sSOL https://cecil.app/cecil.phar
else
  curl -sSOL https://cecil.app/download/$INPUT_VERSION/cecil.phar
fi

# Install theme(s)
if [[ -f "composer.json" && $INPUT_INSTALL_THEMES = 'yes' ]]; then
  echo "Install theme(s)"
  #curl -sS https://getcomposer.org/installer | php
  #php composer.phar install --prefer-dist --no-dev --no-progress --no-interaction
  composer install --prefer-dist --no-dev --no-progress --no-interaction
fi

# Install INTL extensions
if [[ $INPUT_INSTALL_INTL = 'yes' ]]; then
  echo "Install INTL extensions"
  apk update > /dev/null
  apk add --no-cache gettext-dev icu-dev > /dev/null
  docker-php-ext-install -j$(nproc) gettext > /dev/null
  docker-php-ext-install -j$(nproc) intl > /dev/null
fi

# Run build
if [[ -z "${{ inputs.config }}" ]]; then
  php cecil.phar build $INPUT_ARGS
else
  php cecil.phar build $INPUT_ARGS --config=${{ inputs.config }}
fi
