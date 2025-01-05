# Docker builder frankenphp + laravel
Running laravel on FrankenPHP.

## Includes
- frankenphp:latest
- composer
- nodejs
- php laravel required

## Preparation
copy .env.example to .env. update what you need.

## Usage
1. `docker compose up -d`
2. `docker exec -it therapy_app bash`
3. `php artisan migrate`
4. `php artisan key:generate`