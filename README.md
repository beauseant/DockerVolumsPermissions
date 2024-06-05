# DockerVolumsPermissions
Una prueba de cómo asignar permisos a un volumen local en Docker

El repositorio crea un contenedor basado en PHP y monta el directorio data local en el /var/www/html del volumen.

Al hacer eso, el usuario dentro del contenedor www-data no puede escribir en ese directorio.

Para solucionarlo se mapea el usuario de la máquina como www-data dentro del contenedor y se cambia su id.

Para ejecutarlo, primero definimos las variables de entorno y luego lo levantamos.
export UID=$(id -u) 
export GID=$(id -g)
docker-compose up -d

Si ahora hacemos un ssh dentro del contenedor lo haremos como www-data, no somos root.
docker exec  -it pruebasdocker  bash

Si queremos entrar como root al contenedor:
docker exec  -u root -it pruebasdocker  bash

La clave para que funcione es que en el compose tenemos definido el usuario y el grupo del contenedor:
  web:
    user: "${UID}:${GID}" 
    build: 
        context: .
        dockerfile: Dockerfile
        args:
            - UID=${UID}
            - GID=${GID}

    
Y, en el Dockerfile, le cambiamos el id con las variables creadas:
ARG UID
ARG GID
RUN groupmod -g ${GID} www-data 
RUN usermod -u ${UID}  www-data


