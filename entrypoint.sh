#!/bin/sh
set -e

if [[ -z "$CECIL_VERSION" ]]; then
  echo "### Downloading Cecil"
  curl -sSOL https://cecil.app/cecil.phar
else
  echo "### Downloading Cecil $CECIL_VERSION"
  curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi

echo "### Building Cecil static site"
php cecil.phar build -v
echo "### Cecil Action done"
