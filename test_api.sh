#!/bin/bash

# 1. Consultar todas las aplicaciones
echo "==> GET /consult"
curl -s http://localhost:8080/consult | head -c 1000; echo

# 2. Agregar un ambiente al catálogo de ambientes
echo "==> POST /aux/env_directory"
resp_env=$(curl -s -X POST http://localhost:8080/aux/env_directory \
  -H "Content-Type: application/json" \
  -d '{"env": "test-env"}')
echo "$resp_env"
id_env=$(echo $resp_env | grep -o '"id"[ ]*:[ ]*[0-9]*' | grep -o '[0-9]*')

# 3. Agregar un país al catálogo de países
echo "==> POST /aux/country_directory"
resp_country=$(curl -s -X POST http://localhost:8080/aux/country_directory \
  -H "Content-Type: application/json" \
  -d '{"country": "Perú"}')
echo "$resp_country"
id_country=$(echo $resp_country | grep -o '"id"[ ]*:[ ]*[0-9]*' | grep -o '[0-9]*')

# 4. Agregar una nueva aplicación (ajusta los IDs según los catálogos existentes)
echo "==> POST /apps"
resp_app=$(curl -s -X POST http://localhost:8080/apps \
  -H "Content-Type: application/json" \
  -d '{
    "app": "AppTest",
    "repo_name": "repo-apptest",
    "repo_url": "https://git/apptest",
    "id_project_directory": 1,
    "id_person_in_charge": 1,
    "id_security_champion": 1,
    "id_env_directory": '"$id_env"',
    "id_country_directory": '"$id_country"',
    "id_label_directory": 1,
    "id_app_type_directory": 1,
    "id_pipeline_properties_directory": 1,
    "id_runtime_directory": 1,
    "sonarqubepath_exec": "/sonar/app",
    "id_microservice_directory": 1
  }')
echo "$resp_app"
id_app=$(echo $resp_app | grep -o '"id"[ ]*:[ ]*[0-9]*' | grep -o '[0-9]*')

# 5. Consultar la aplicación recién creada (ajusta el ID devuelto en el paso anterior)
echo "==> GET /consult?id=1"
curl -s http://localhost:8080/consult?id=1 | head -c 1000; echo

# 6. Prueba de error: POST /apps con dos propiedades específicas
echo "==> POST /apps (error: dos propiedades específicas)"
resp_error=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST http://localhost:8080/apps \
  -H "Content-Type: application/json" \
  -d '{
    "app": "AppError",
    "repo_name": "repo-apperror",
    "repo_url": "https://git/apperror",
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
    "id_microservice_directory": 1,
    "id_database_properties_directory": 1
  }')
echo "$resp_error"

echo "FIN DE PRUEBAS"
