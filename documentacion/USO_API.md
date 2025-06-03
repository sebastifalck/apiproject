# Uso de la API: Endpoints y ejemplos

## 1. Consultar aplicaciones
### Obtener todas las aplicaciones
```
GET /consult
```
**Respuesta:** Lista de todas las aplicaciones y sus propiedades.

### Obtener una aplicación por ID
```
GET /consult?id=2
```
**Respuesta:** Solo la aplicación con id=2.

## 2. Agregar una nueva aplicación
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
**Nota:** Solo uno de los campos `id_microservice_directory`, `id_datastage_properties_directory`, `id_database_properties_directory`, `id_was_properties_directory`, `id_pims_properties_directory` debe estar presente y no nulo.

## 3. Agregar ítems a catálogos auxiliares
### Ejemplo: agregar un ambiente
```
POST /aux/env_directory
Content-Type: application/json
{
  "env": "test-env"
}
```
### Ejemplo: agregar un país
```
POST /aux/country_directory
Content-Type: application/json
{
  "country": "Perú"
}
```
### Ejemplo: agregar un label
```
POST /aux/label_directory
Content-Type: application/json
{
  "app_label": "api-test"
}
```
### Ejemplo: agregar un tipo de aplicación
```
POST /aux/app_type_directory
Content-Type: application/json
{
  "app_type": "test-type"
}
```
### Ejemplo: agregar un runtime
```
POST /aux/runtime_directory
Content-Type: application/json
{
  "runtime_name": "go",
  "version_path": "1.22"
}
```
### Ejemplo: agregar pipeline properties
```
POST /aux/pipeline_properties_directory
Content-Type: application/json
{
  "securitygate": false,
  "unittests": true,
  "sonarqube": false,
  "qualitygate": true
}
```
### Ejemplo: agregar responsable
```
POST /aux/person_in_charge
Content-Type: application/json
{
  "nombre": "Test User",
  "email": "test@demo.com"
}
```
### Ejemplo: agregar security champion
```
POST /aux/security_champion
Content-Type: application/json
{
  "nombre": "Security User",
  "email": "sec@demo.com"
}
```

## 4. Notas adicionales
- Todos los endpoints POST devuelven el ID del nuevo registro creado.
- Para agregar relaciones, primero crea los ítems auxiliares y usa sus IDs en el POST `/apps`.
- Los endpoints aceptan y devuelven JSON.
