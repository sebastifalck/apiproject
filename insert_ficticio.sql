-- ===============================
-- INSERCIÓN DE DATOS FICTICIOS PARA 10 APLICACIONES
-- ===============================

-- Ambientes
tRUNCATE env_directory RESTART IDENTITY CASCADE;
INSERT INTO env_directory (env) VALUES ('dev'), ('qa'), ('master');

-- Países
TRUNCATE country_directory RESTART IDENTITY CASCADE;
INSERT INTO country_directory (country) VALUES ('Colombia'), ('México'), ('Argentina');

-- Labels
TRUNCATE label_directory RESTART IDENTITY CASCADE;
INSERT INTO label_directory (app_label) VALUES ('core'), ('frontend'), ('backend');

-- Tipos de aplicación
TRUNCATE app_type_directory RESTART IDENTITY CASCADE;
INSERT INTO app_type_directory (app_type) VALUES ('microservice'), ('datastage'), ('database'), ('was'), ('pims');

-- Pipeline properties
TRUNCATE pipeline_properties_directory RESTART IDENTITY CASCADE;
INSERT INTO pipeline_properties_directory DEFAULT VALUES;
INSERT INTO pipeline_properties_directory DEFAULT VALUES;
INSERT INTO pipeline_properties_directory DEFAULT VALUES;

-- Runtime
TRUNCATE runtime_directory RESTART IDENTITY CASCADE;
INSERT INTO runtime_directory (runtime_name, version_path) VALUES ('java', '11'), ('python', '3.9'), ('node', '16');

-- Personas
TRUNCATE person_in_charge RESTART IDENTITY CASCADE;
TRUNCATE security_champion RESTART IDENTITY CASCADE;
INSERT INTO person_in_charge (nombre, email) VALUES ('Juan Perez', 'juan@empresa.com'), ('Ana Ruiz', 'ana@empresa.com');
INSERT INTO security_champion (nombre, email) VALUES ('Carlos Lopez', 'carlos@empresa.com'), ('Maria Diaz', 'maria@empresa.com');

-- Usos, imágenes, paths, tokens, openshift
TRUNCATE usage_directory RESTART IDENTITY CASCADE;
TRUNCATE image_directory RESTART IDENTITY CASCADE;
TRUNCATE path_directory RESTART IDENTITY CASCADE;
TRUNCATE token_directory RESTART IDENTITY CASCADE;
TRUNCATE openshift_properties_directory RESTART IDENTITY CASCADE;
INSERT INTO usage_directory (usage) VALUES ('api'), ('batch'), ('etl');
INSERT INTO image_directory (image_name) VALUES ('repo/app1:latest'), ('repo/app2:latest');
INSERT INTO path_directory (volume_path) VALUES ('/data'), ('/var/log');
INSERT INTO token_directory (token, namespace_name) VALUES ('tok1', 'ns1'), ('tok2', 'ns2');
INSERT INTO openshift_properties_directory DEFAULT VALUES;
INSERT INTO openshift_properties_directory DEFAULT VALUES;

-- Proyectos
TRUNCATE project_directory RESTART IDENTITY CASCADE;
INSERT INTO project_directory (project_name, project_acronym) VALUES ('Proyecto A', 'PA'), ('Proyecto B', 'PB');

-- Nombres de aplicaciones
TRUNCATE appname_directory RESTART IDENTITY CASCADE;
INSERT INTO appname_directory (app) VALUES ('AppUno'), ('AppDos'), ('AppTres'), ('AppCuatro'), ('AppCinco'), ('AppSeis'), ('AppSiete'), ('AppOcho'), ('AppNueve'), ('AppDiez');

-- Repositorios de aplicaciones
TRUNCATE app_directory RESTART IDENTITY CASCADE;
INSERT INTO app_directory (id_appname, repo_name, repo_url) VALUES
(1, 'repo-appuno', 'https://git/appuno'),
(2, 'repo-appdos', 'https://git/appdos'),
(3, 'repo-apptres', 'https://git/apptres'),
(4, 'repo-appcuatro', 'https://git/appcuatro'),
(5, 'repo-appcinco', 'https://git/appcinco'),
(6, 'repo-appseis', 'https://git/appseis'),
(7, 'repo-appsiete', 'https://git/appsiete'),
(8, 'repo-appocho', 'https://git/appocho'),
(9, 'repo-appnueve', 'https://git/appnueve'),
(10, 'repo-appdiez', 'https://git/appdiez');

-- Propiedades específicas (solo una por app)
TRUNCATE microservice_properties_directory RESTART IDENTITY CASCADE;
TRUNCATE datastage_properties_directory RESTART IDENTITY CASCADE;
TRUNCATE database_properties_directory RESTART IDENTITY CASCADE;
TRUNCATE was_properties_directory RESTART IDENTITY CASCADE;
TRUNCATE pims_properties_directory RESTART IDENTITY CASCADE;
INSERT INTO microservice_properties_directory (id_usage_directory, cpulimits, cpurequest, memorylimits, memoryrequest, replicas, id_token_directory, id_openshift_properties_directory, id_path_directory, drs_enabled, id_image_directory)
VALUES (1, '500m', '250m', '512Mi', '256Mi', 2, 1, 1, 1, TRUE, 1); -- para AppUno

INSERT INTO datastage_properties_directory DEFAULT VALUES; -- para AppDos
INSERT INTO database_properties_directory DEFAULT VALUES; -- para AppTres
INSERT INTO was_properties_directory (host, instance_name, context_root) VALUES ('was1', 'inst1', '/root1'); -- para AppCuatro
INSERT INTO pims_properties_directory (nexus_url) VALUES ('https://nexus/appcinco'); -- para AppCinco

INSERT INTO microservice_properties_directory (id_usage_directory, cpulimits, cpurequest, memorylimits, memoryrequest, replicas, id_token_directory, id_openshift_properties_directory, id_path_directory, drs_enabled, id_image_directory)
VALUES (2, '1', '500m', '1Gi', '512Mi', 3, 2, 2, 2, FALSE, 2); -- para AppSeis

INSERT INTO datastage_properties_directory DEFAULT VALUES; -- para AppSiete
INSERT INTO database_properties_directory DEFAULT VALUES; -- para AppOcho
INSERT INTO was_properties_directory (host, instance_name, context_root) VALUES ('was2', 'inst2', '/root2'); -- para AppNueve
INSERT INTO pims_properties_directory (nexus_url) VALUES ('https://nexus/appdiez'); -- para AppDiez

-- Relación general de aplicaciones (solo un tipo de propiedad por app)
TRUNCATE app_general_properties RESTART IDENTITY CASCADE;
INSERT INTO app_general_properties (
    id_project_directory, id_app_directory, id_person_in_charge, id_security_champion, id_env_directory, id_country_directory, id_label_directory, id_app_type_directory, id_pipeline_properties_directory, id_runtime_directory, sonarqubepath_exec, id_microservice_directory, id_datastage_properties_directory, id_database_properties_directory, id_was_properties_directory, id_pims_properties_directory
) VALUES
-- AppUno microservice
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '/sonar/appuno', 1, NULL, NULL, NULL, NULL),
(1, 1, 1, 1, 2, 1, 1, 1, 1, 1, '/sonar/appuno', 1, NULL, NULL, NULL, NULL),
(1, 1, 1, 1, 3, 1, 1, 1, 1, 1, '/sonar/appuno', 1, NULL, NULL, NULL, NULL),
-- AppDos datastage
(1, 2, 2, 2, 1, 2, 2, 2, 2, 2, '/sonar/appdos', NULL, 1, NULL, NULL, NULL),
(1, 2, 2, 2, 2, 2, 2, 2, 2, 2, '/sonar/appdos', NULL, 1, NULL, NULL, NULL),
(1, 2, 2, 2, 3, 2, 2, 2, 2, 2, '/sonar/appdos', NULL, 1, NULL, NULL, NULL),
-- AppTres database
(2, 3, 1, 2, 1, 3, 3, 3, 3, 3, '/sonar/apptres', NULL, NULL, 1, NULL, NULL),
(2, 3, 1, 2, 2, 3, 3, 3, 3, 3, '/sonar/apptres', NULL, NULL, 1, NULL, NULL),
(2, 3, 1, 2, 3, 3, 3, 3, 3, 3, '/sonar/apptres', NULL, NULL, 1, NULL, NULL),
-- AppCuatro was
(2, 4, 2, 1, 1, 2, 1, 4, 1, 1, '/sonar/appcuatro', NULL, NULL, NULL, 1, NULL),
(2, 4, 2, 1, 2, 2, 1, 4, 1, 1, '/sonar/appcuatro', NULL, NULL, NULL, 1, NULL),
(2, 4, 2, 1, 3, 2, 1, 4, 1, 1, '/sonar/appcuatro', NULL, NULL, NULL, 1, NULL),
-- AppCinco pims
(1, 5, 1, 2, 1, 1, 2, 5, 2, 2, '/sonar/appcinco', NULL, NULL, NULL, NULL, 1),
(1, 5, 1, 2, 2, 1, 2, 5, 2, 2, '/sonar/appcinco', NULL, NULL, NULL, NULL, 1),
(1, 5, 1, 2, 3, 1, 2, 5, 2, 2, '/sonar/appcinco', NULL, NULL, NULL, NULL, 1),
-- AppSeis microservice
(2, 6, 2, 1, 1, 2, 3, 1, 3, 3, '/sonar/appseis', 2, NULL, NULL, NULL, NULL),
(2, 6, 2, 1, 2, 2, 3, 1, 3, 3, '/sonar/appseis', 2, NULL, NULL, NULL, NULL),
(2, 6, 2, 1, 3, 2, 3, 1, 3, 3, '/sonar/appseis', 2, NULL, NULL, NULL, NULL),
-- AppSiete datastage
(1, 7, 1, 2, 1, 3, 1, 2, 1, 1, '/sonar/appsiete', NULL, 2, NULL, NULL, NULL),
(1, 7, 1, 2, 2, 3, 1, 2, 1, 1, '/sonar/appsiete', NULL, 2, NULL, NULL, NULL),
(1, 7, 1, 2, 3, 3, 1, 2, 1, 1, '/sonar/appsiete', NULL, 2, NULL, NULL, NULL),
-- AppOcho database
(2, 8, 2, 1, 1, 2, 2, 3, 2, 2, '/sonar/appocho', NULL, NULL, 2, NULL, NULL),
(2, 8, 2, 1, 2, 2, 2, 3, 2, 2, '/sonar/appocho', NULL, NULL, 2, NULL, NULL),
(2, 8, 2, 1, 3, 2, 2, 3, 2, 2, '/sonar/appocho', NULL, NULL, 2, NULL, NULL),
-- AppNueve was
(1, 9, 1, 2, 1, 1, 3, 4, 3, 3, '/sonar/appnueve', NULL, NULL, NULL, 2, NULL),
(1, 9, 1, 2, 2, 1, 3, 4, 3, 3, '/sonar/appnueve', NULL, NULL, NULL, 2, NULL),
(1, 9, 1, 2, 3, 1, 3, 4, 3, 3, '/sonar/appnueve', NULL, NULL, NULL, 2, NULL),
-- AppDiez pims
(2, 10, 2, 1, 1, 3, 2, 5, 1, 1, '/sonar/appdiez', NULL, NULL, NULL, NULL, 2),
(2, 10, 2, 1, 2, 3, 2, 5, 1, 1, '/sonar/appdiez', NULL, NULL, NULL, NULL, 2),
(2, 10, 2, 1, 3, 3, 2, 5, 1, 1, '/sonar/appdiez', NULL, NULL, NULL, NULL, 2);
