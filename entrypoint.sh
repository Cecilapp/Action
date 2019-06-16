#!/bin/bash
set -e

echo "### Starting the Cecil Action"

curl -SOL https://cecil.app/cecil.phar

php cecil.phar build -v $*

echo "### Completed the Cecil Action"
