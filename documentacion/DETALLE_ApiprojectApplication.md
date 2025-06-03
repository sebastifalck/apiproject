# Documentación detallada: ApiprojectApplication.java

Este archivo implementa el controlador principal de la API Spring Boot para la gestión de aplicaciones y catálogos auxiliares. A continuación se describe cada parte relevante del código, su propósito y funcionamiento.

---

## 1. Anotaciones y configuración
- `@SpringBootApplication`: Marca la clase como punto de entrada de una aplicación Spring Boot.
- `@RestController`: Indica que la clase expone endpoints REST.
- `@RequestMapping`: Permite mapear rutas a los métodos del controlador.

## 2. Inyección de dependencias
- `@Autowired JdbcTemplate jdbcTemplate`: Permite ejecutar consultas SQL nativas y operaciones sobre la base de datos PostgreSQL.

## 3. Logging
- Se utiliza SLF4J (`Logger logger`) para registrar información y errores de la API.

---

## 4. Endpoints principales

### 4.1. GET `/consult`
- **Propósito:** Consultar todas las aplicaciones o una aplicación específica por ID.
- **Parámetro opcional:** `id` (Integer)
- **Funcionamiento:**
  - Si se pasa `id`, filtra por ese ID (`WHERE agp.id = ?`).
  - Ejecuta una consulta SQL que, según el tipo de propiedad específica asociada a la app, llama a la función SQL correspondiente (`get_microservice_app_properties`, `get_was_app_properties`, etc.) y retorna el resultado como JSON.
  - Devuelve una lista de mapas con los datos de cada aplicación.
- **Manejo de errores:** Devuelve 500 si ocurre un error en la consulta.

### 4.2. POST `/aux/{tabla}`
- **Propósito:** Agregar un nuevo ítem a cualquier tabla auxiliar (catálogo).
- **Funcionamiento:**
  - Recibe el nombre de la tabla como path variable y un JSON con los campos a insertar.
  - Construye dinámicamente el SQL de inserción y ejecuta el insert.
  - Devuelve el ID del nuevo registro creado.
- **Manejo de errores:** Devuelve 400 si ocurre un error en la inserción.

### 4.3. POST `/apps`
- **Propósito:** Agregar una nueva aplicación y sus relaciones.
- **Funcionamiento:**
  1. **Validación:**
     - Solo se permite un tipo de propiedad específica por aplicación (microservice, datastage, database, was, pims), ya sea por ID o por objeto.
  2. **Inserción de propiedad específica:**
     - Si se recibe un objeto de propiedades específicas (por ejemplo, `microservice`), primero lo inserta en la tabla correspondiente y obtiene el ID generado.
     - Si se recibe solo el ID, lo usa directamente.
  3. **Inserción de catálogos relacionados:**
     - Inserta el nombre de la app en `appname_directory` y obtiene su ID.
     - Inserta el repositorio en `app_directory` y obtiene su ID.
  4. **Inserción en `app_general_properties`:**
     - Inserta todos los IDs de catálogos y el ID de la propiedad específica en la tabla principal.
     - Devuelve el ID de la nueva aplicación creada.
- **Manejo de errores:** Devuelve 400 si ocurre un error en la inserción.

---

## 5. Estructura general del flujo de inserción de una app
1. **Recibe el JSON:** Puede contener IDs de catálogos y/o un objeto de propiedad específica.
2. **Valida:** Solo un tipo de propiedad específica.
3. **Inserta propiedad específica:** Si es objeto, inserta y obtiene el ID; si es ID, lo usa.
4. **Inserta catálogos:** appname y app_directory.
5. **Inserta en app_general_properties:** Con todos los IDs y la propiedad específica.
6. **Devuelve el ID de la app creada.**

---

## 6. Manejo de errores y logs
- Todos los endpoints capturan excepciones y devuelven mensajes claros en caso de error.
- Se registran los SQL ejecutados y los errores para facilitar la depuración.

---

## 7. Consideraciones de seguridad y buenas prácticas
- El endpoint `/aux/{tabla}` permite insertar en cualquier tabla auxiliar, por lo que debe usarse con precaución y validarse en producción.
- El uso de SQL dinámico está controlado por la lógica del backend, pero se recomienda validar los nombres de tabla y campos si se expone a usuarios externos.

---

## 8. Ejemplo de inserción de app con propiedad específica
```json
{
  "app": "AppDemo",
  "repo_name": "repo-appdemo",
  "repo_url": "https://git/appdemo",
  "id_project_directory": 1,
  "id_person_in_charge": 1,
  "id_security_champion": 1,
  "id_env_directory": 1,
  "id_country_directory": 1,
  "id_label_directory": 1,
  "id_app_type_directory": 1,
  "id_pipeline_properties_directory": 1,
  "id_runtime_directory": 1,
  "sonarqubepath_exec": "/sonar/appdemo",
  "microservice": {
    "id_usage_directory": 1,
    "cpulimits": "500m",
    "cpurequest": "250m",
    "memorylimits": "512Mi",
    "memoryrequest": "256Mi",
    "replicas": 2,
    "id_token_directory": 1,
    "id_openshift_properties_directory": 1,
    "id_path_directory": 1,
    "drs_enabled": true,
    "id_image_directory": 1
  }
}
```

---

## 9. Main
- El método `main` inicia la aplicación Spring Boot.

---

**Este archivo es el núcleo de la lógica de negocio y orquestación de la API.**
