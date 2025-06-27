# GitLab Docker Compose Setup

Este proyecto contiene una configuración de Docker Compose para ejecutar GitLab utilizando la imagen `gitlab/gitlab-ee`. A continuación se presentan las instrucciones para ejecutar el contenedor de GitLab y detalles sobre la configuración.

## Requisitos Previos

Asegúrate de tener Docker y Docker Compose instalados en tu máquina.

## Instrucciones para Ejecutar GitLab

1. Clona este repositorio o descarga los archivos necesarios.
2. Navega al directorio del proyecto:
   ```
   cd gitlab-docker-compose
   ```
3. Modifica el archivo `docker-compose.yml` si es necesario, especialmente la sección de `environment` para configurar el acceso a GitLab.
4. Ejecuta el siguiente comando para iniciar GitLab:
   ```
   docker-compose up -d
   ```
5. Espera unos minutos mientras GitLab se inicializa. Puedes acceder a GitLab en tu navegador en `http://localhost`.

## Persistencia de Datos

Los datos de GitLab se almacenan en los volúmenes definidos en el archivo `docker-compose.yml`. Asegúrate de no eliminar estos volúmenes si deseas conservar tus datos.

## Acceso a GitLab

- **Usuario predeterminado:** `root`
- **Contraseña predeterminada:** La contraseña se debe establecer en el archivo de secretos. Asegúrate de seguir las instrucciones para configurarla.

## Notas Adicionales

- Para detener el contenedor, utiliza:
  ```
  docker-compose down
  ```
- Para ver los registros de GitLab, puedes usar:
  ```
  docker-compose logs -f
  ```

Este archivo README proporciona una guía básica para comenzar con GitLab utilizando Docker Compose. Asegúrate de consultar la documentación oficial de GitLab para obtener más información sobre la configuración y el uso.