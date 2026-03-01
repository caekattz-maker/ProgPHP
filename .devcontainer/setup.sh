#!/usr/bin/env bash
set -e

# 1) Composer
if ! command -v composer >/dev/null 2>&1; then
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  rm composer-setup.php
fi

# 2) Extensiones PHP mínimas (pdo, pdo_mysql ya vienen en la imagen base 8.3)
php -v
composer -V

# 3) Si no existe carpeta src, creamos proyecto Laravel
if [ ! -d "src" ]; then
  mkdir -p src
  cd src
  composer create-project laravel/laravel . --no-interaction
else
  cd src
fi

# 4) Variables de entorno para MariaDB
cp -n .env.example .env
php -r "file_put_contents('.env', preg_replace('/^DB_CONNECTION=.*/m','DB_CONNECTION=mysql', file_get_contents('.env')));"
php -r "file_put_contents('.env', preg_replace('/^DB_HOST=.*/m','DB_HOST=mariadb', file_get_contents('.env')));"
php -r "file_put_contents('.env', preg_replace('/^DB_PORT=.*/m','DB_PORT=3306', file_get_contents('.env')));"
php -r "file_put_contents('.env', preg_replace('/^DB_DATABASE=.*/m','DB_DATABASE=bitnami_myapp', file_get_contents('.env')));"
php -r "file_put_contents('.env', preg_replace('/^DB_USERNAME=.*/m','DB_USERNAME=bn_myapp', file_get_contents('.env')));"
php -r "file_put_contents('.env', preg_replace('/^DB_PASSWORD=.*/m','DB_PASSWORD=b1tnam1_my@pp', file_get_contents('.env')));"

php artisan key:generate
php artisan migrate || true

echo "Setup listo."
