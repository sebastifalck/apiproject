# Documentación de Endpoints, Ejemplos y Diagramas

## 1. GET `/consult`
### Descripción
Consulta todas las aplicaciones o una aplicación específica por ID.

### Parámetros
- `id` (opcional, Integer): Si se especifica, filtra por el ID de la aplicación.

### Ejemplos de solicitud
**Obtener todas las aplicaciones:**
```
GET /consult
```
**Obtener una aplicación por ID:**
```
GET /consult?id=2
```

### Ejemplo de respuesta
```json
[
  {
    "id": 2,
    "json_obj": {
      "app_general_id": 2,
      "app_name": "AppUno",
      "repo_name": "repo-appuno",
      ...
    }
  }
]
```

### Diagrama de flujo
```
Usuario ──GET /consult──▶ Backend ──SQL──▶ PostgreSQL
         ◀── JSON result ──◀
```

---

## 2. POST `/aux/{tabla}`
### Descripción
Agrega un nuevo ítem a una tabla auxiliar (catálogo).

### Parámetros
- `tabla` (String, path): Nombre de la tabla auxiliar.
- Body: JSON con los campos a insertar.

### Ejemplo de solicitud
**Agregar un ambiente:**
```
POST /aux/env_directory
Content-Type: application/json
{
  "env": "test-env"
}
```
**Agregar un país:**
```
POST /aux/country_directory
Content-Type: application/json
{
  "country": "Perú"
}
```

### Ejemplo de respuesta
```json
{
  "id": 4
}
```

### Diagrama de flujo
```
Usuario ──POST /aux/{tabla}──▶ Backend ──INSERT──▶ PostgreSQL
         ◀── id insertado ──◀
```

---

## 3. POST `/apps`
### Descripción
Agrega una nueva aplicación y sus relaciones.

### Body esperado
Debe incluir los IDs de los catálogos y solo un tipo de propiedad específica (por ejemplo, `id_microservice_directory`).

### Ejemplo de solicitud
```
POST /apps
Content-Type: application/json
{
  "app": "AppTest",
  "repo_name": "repo-apptest",
  "repo_url": "https://git/apptest",
  "id_project_directory": 1,
  "id_person_in_charge": 1,
  "id_security_champion": 1,
  "id_env_directory": 1,
  "id_country_directory": 1,
  "id_label_directory": 1,
  "id_app_type_directory": 1,
  "id_pipeline_properties_directory": 1,
  "id_runtime_directory": 1,
  "sonarqubepath_exec": "/sonar/app",
  "id_microservice_directory": 1
}
```

### Ejemplo de respuesta
```json
{
  "id": 31
}
```

### Diagrama de flujo
```
Usuario ──POST /apps──▶ Backend
   ├─ INSERT appname_directory
   ├─ INSERT app_directory
   └─ INSERT app_general_properties (con relaciones)
         │
         ▼
     PostgreSQL
         │
         ▼
   ◀── id insertado ──◀
```

---

## 4. Manejo de errores
- Si se envía más de un tipo de propiedad específica en `/apps`, devuelve 400 con mensaje claro.
- Si hay error de SQL en `/aux/{tabla}` o `/apps`, devuelve 400 con mensaje de error.

---

## 5. Notas
- Todos los endpoints POST devuelven el ID del nuevo registro creado.
- Para agregar relaciones, primero crea los ítems auxiliares y usa sus IDs en el POST `/apps`.
- Los endpoints aceptan y devuelven JSON.

---

## 6. Diagrama general de la API
```
+-------------------+
|   Usuario/API     |
+-------------------+
          |
          v
+-------------------+
|  ApiprojectApplication.java (Spring Boot REST Controller)
+-------------------+
          |
          v
+-------------------+
|      PostgreSQL   |
+-------------------+
```
