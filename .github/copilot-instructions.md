# Spring Boot API para gestión de aplicaciones y catálogos auxiliares

## Endpoints principales

- `POST /apps` — Agrega una nueva aplicación (y sus relaciones) a la base de datos.
- `POST /aux/{tabla}` — Agrega un nuevo ítem a una tabla auxiliar (catálogo).
- `GET /consult` — Consulta todas las aplicaciones usando la lógica de funciones SQL y retorna el JSON correspondiente.

## Consideraciones
- La API usa Java 21, Spring Boot 3.5.0, Spring Web, Spring Data JDBC y PostgreSQL Driver.
- El acceso a base de datos se realiza mediante JDBC y consultas SQL nativas.
- El endpoint `/consult` ejecuta la lógica de funciones SQL para devolver la estructura JSON esperada.
- El endpoint `/apps` valida que solo se relacione un tipo de propiedad específica por aplicación.
- El endpoint `/aux/{tabla}` permite agregar ítems a cualquier tabla auxiliar (por ejemplo: env_directory, country_directory, etc).

<!-- Use this file to proporcionar instrucciones personalizadas para Copilot en este workspace. Más detalles en https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->
