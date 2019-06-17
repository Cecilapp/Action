#!/bin/bash
set -e

echo "### Downloading Cecil"

if [[ -z "$CECIL_VERSION" ]]; then
	curl -SOL https://cecil.app/cecil.phar
else
  curl -SOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi

echo "### Building Cecil static site"

php cecil.phar build -v $*

echo "### Cecil Action done"
