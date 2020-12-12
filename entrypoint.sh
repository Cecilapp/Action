#!/bin/sh
set -e

# Install INTL extensions
if [[ $INPUT_INSTALL_THEMES = 'yes' ]]; then
  apk update
  apk add --no-cache gettext-dev icu-dev
  docker-php-ext-install -j$(nproc) gettext
  docker-php-ext-install -j$(nproc) intl
fi

# Install theme(s)
if [[ -f "composer.json" && $INPUT_INSTALL_THEMES = 'yes' ]]; then
  echo "Installing theme(s)..."
  #curl -sS https://getcomposer.org/installer | php
  #php composer.phar install --prefer-dist --no-dev --no-progress
  composer install --prefer-dist --no-dev --no-progress
fi

# Download Cecil
if [[ -z "$CECIL_VERSION" ]]; then
  echo "Downloading Cecil..."
  curl -sSOL https://cecil.app/cecil.phar
else
  echo "Downloading Cecil $CECIL_VERSION..."
  curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi

# Run build
php cecil.phar build $INPUT_ARGS
