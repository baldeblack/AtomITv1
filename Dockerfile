FROM php:7.4-apache

# Instalar extensiones necesarias para Yii
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite

# Copiar el proyecto al contenedor
COPY . /var/www/html

# Copiar el framework Yii al contenedor
COPY yii /var/www/html/yii

# Establecer permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configurar el directorio de trabajo
WORKDIR /var/www/html