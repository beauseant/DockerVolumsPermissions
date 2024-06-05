FROM php:8.0-apache
ARG UID
ARG GID
RUN groupmod -g ${GID} www-data 
RUN usermod -u ${UID}  www-data






