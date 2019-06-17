#!/bin/bash
set -e

echo "### Downloading Cecil"

curl -SOL https://cecil.app/cecil.phar

echo "### Building Cecil static site"

php cecil.phar build -v $*

echo "### Cecil Action done"
