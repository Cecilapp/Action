#!/bin/sh
set -e

# Download Cecil
if [[ -z "$INPUT_VERSION" ]]; then
  echo "Downloading Cecil..."
  curl -sSOL https://cecil.app/cecil.phar
else
  echo "Downloading Cecil $INPUT_VERSION..."
  curl -sSOL https://cecil.app/download/$INPUT_VERSION/cecil.phar
fi

# Install theme(s)
if [[ -f "composer.json" && $INPUT_INSTALL_THEMES = 'yes' ]]; then
  echo "Installing theme(s)..."
  #curl -sS https://getcomposer.org/installer | php
  #php composer.phar install --prefer-dist --no-dev --no-progress
  composer install --prefer-dist --no-dev --no-progress
fi

# Install INTL extensions
if [[ $INPUT_INSTALL_THEMES = 'yes' ]]; then
  echo "Installing INTL extensions..."
  apk update > /dev/null
  apk add --no-cache gettext-dev icu-dev > /dev/null
  docker-php-ext-install -j$(nproc) gettext > /dev/null
  docker-php-ext-install -j$(nproc) intl > /dev/null
fi

# Run build
php cecil.phar build $INPUT_ARGS
