# Pasos de desarrollo de la API Spring Boot para gestión de aplicaciones

## 1. Estructura y tecnologías
- **Lenguaje:** Java 21
- **Framework:** Spring Boot 3.5.0
- **Dependencias:** Spring Web, Spring Data JDBC, PostgreSQL Driver
- **Base de datos:** PostgreSQL 16 (en contenedor)
- **Contenedores:** Docker Compose y Podman

## 2. Configuración del entorno
1. Clona el repositorio y entra a la carpeta del proyecto.
2. Revisa y ajusta el archivo `docker-compose.yml` para los servicios de PostgreSQL y backend.
3. Asegúrate de que la contraseña de la base de datos en `src/main/resources/application.properties` coincida con la de Docker Compose.
4. Compila el backend con:
   ```
   ./mvnw clean package -DskipTests
   ```
5. Construye la imagen del backend:
   ```
   podman build --no-cache -t apiproject .
   ```

## 3. Preparación de la base de datos
1. Levanta los servicios:
   ```
   podman-compose up -d
   ```
2. Copia los scripts SQL al contenedor de PostgreSQL:
   ```
   podman cp modelo.sql postgres16:/modelo.sql
   podman cp functions_app_properties.sql postgres16:/functions_app_properties.sql
   podman cp insert_ficticio.sql postgres16:/insert_ficticio.sql
   ```
3. Ejecuta los scripts dentro del contenedor:
   ```
   podman exec -it postgres16 psql -U usuario -d midb -f /modelo.sql
   podman exec -it postgres16 psql -U usuario -d midb -f /functions_app_properties.sql
   podman exec -it postgres16 psql -U usuario -d midb -f /insert_ficticio.sql
   ```

## 4. Despliegue y pruebas
1. Reinicia el backend si es necesario:
   ```
   podman restart apiproject
   ```
2. Prueba los endpoints principales:
   - GET `/consult`
   - GET `/consult?id=1`
   - POST `/apps`
   - POST `/aux/{tabla}`

## 5. Observaciones
- El endpoint `/consult` filtra correctamente por ID.
- Los endpoints `/aux/{tabla}` permiten agregar ítems a cualquier catálogo auxiliar.
- El endpoint `/apps` valida que solo se relacione un tipo de propiedad específica por aplicación.
- Los scripts SQL permiten reinicializar y poblar la base de datos con datos de ejemplo.

---
