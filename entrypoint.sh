#!/bin/bash
set -e

echo "Starting the Cecil Action"

sh -c "php cecil.phar build -v $*"

echo "Completed the Cecil Action"
