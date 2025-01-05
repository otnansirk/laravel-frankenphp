FROM dunglas/frankenphp:latest


# Install dependencies
RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    git \
    vim \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpq-dev \
    curl \
    ffmpeg \
    net-tools \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_pgsql zip gd sockets \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js (versi sesuai yang diperlukan untuk Vite.js)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs

WORKDIR /var/www/public_html

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY ./source-app .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node.js dependencies
RUN npm install

RUN chown -R www-data:www-data /var/www/public_html \
    && chmod -R 775 /var/www/public_html/storage \
    && chmod -R 775 /var/www/public_html/bootstrap/cache

EXPOSE 80

CMD ["frankenphp", "php-server", "-r", "public/"]
