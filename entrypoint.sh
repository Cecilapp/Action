#!/bin/bash
set -e

echo "Starting the Cecil Action"

composer install

curl -SOL https://cecil.app/cecil.phar

sh -c "php cecil.phar build -v $*"

echo "Completed the Cecil Action"
