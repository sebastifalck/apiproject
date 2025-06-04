# reset_stack.ps1
# Script para limpiar, reconstruir y levantar el stack completo (PowerShell)
# powershell -ExecutionPolicy Bypass -File ./reset_stack.ps1                              s


Write-Host "Deteniendo y eliminando contenedores..."
podman stop frontend 2>$null
podman rm frontend 2>$null
podman stop apiproject 2>$null
podman rm apiproject 2>$null
podman stop postgres16 2>$null
podman rm postgres16 2>$null

Write-Host "Eliminando imágenes locales..."
podman rmi localhost/apiproject_frontend:latest 2>$null
podman rmi localhost/apiproject_apiproject:latest 2>$null
podman rmi docker.io/library/postgres:16 2>$null

Write-Host "Reconstruyendo imágenes (frontend, backend)..."
podman-compose build

Write-Host "Levantando base de datos..."
podman-compose up -d postgres16
Start-Sleep -Seconds 5

Write-Host "Levantando backend..."
podman-compose up -d apiproject
Start-Sleep -Seconds 5

Write-Host "Levantando frontend..."
podman-compose up -d frontend

Write-Host "¿Deseas recrear las tablas y datos de ejemplo? (s/n)"
$recreate = Read-Host
if ($recreate -eq 's') {
    $PGUSER = "usuario"
    $PGDB = "midb"
    Write-Host "Cargando modelo.sql (tablas)..."
    podman cp modelo.sql postgres16:/modelo.sql
    podman exec -it postgres16 psql -U $PGUSER -d $PGDB -f /modelo.sql
    Write-Host "Cargando functions_app_properties.sql (funciones)..."
    podman cp functions_app_properties.sql postgres16:/functions_app_properties.sql
    podman exec -it postgres16 psql -U $PGUSER -d $PGDB -f /functions_app_properties.sql
    Write-Host "Cargando insert_ficticio.sql (datos ficticios)..."
    podman cp insert_ficticio.sql postgres16:/insert_ficticio.sql
    podman exec -it postgres16 psql -U $PGUSER -d $PGDB -f /insert_ficticio.sql
    Write-Host "Carga de modelo, funciones y datos ficticios completada."
}

Write-Host "Stack listo."
