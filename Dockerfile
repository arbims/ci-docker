# Dockerfile

# Utiliser l'image PHP avec FPM
FROM php:8.3-fpm

# Installer les extensions nécessaires
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo pdo_mysql zip

# Copier le contenu du projet dans le conteneur
COPY . /srv/app

# Créer les répertoires nécessaires
RUN mkdir -p /srv/app/writable /srv/app/public

# Définir les permissions des dossiers
RUN chown -R www-data:www-data /srv/app/writable \
    && chown -R www-data:www-data /srv/app/public

# Exposer le port
EXPOSE 9000

# Lancer le serveur PHP
CMD ["php-fpm"]
