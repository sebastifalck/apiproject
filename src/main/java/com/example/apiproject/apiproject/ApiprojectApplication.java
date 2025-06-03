package com.example.apiproject.apiproject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.*;

@SpringBootApplication
@RestController
@RequestMapping
public class ApiprojectApplication {
    private static final Logger logger = LoggerFactory.getLogger(ApiprojectApplication.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Endpoint para consultar aplicaciones (GET /consult)
    @GetMapping("/consult")
    public ResponseEntity<List<Map<String, Object>>> consultApps(@RequestParam(required = false) Integer id) {
        String baseSql = "SELECT agp.id, CASE " +
                " WHEN agp.id_microservice_directory IS NOT NULL THEN (SELECT row_to_json(x) FROM get_microservice_app_properties(agp.id) x) " +
                " WHEN agp.id_was_properties_directory IS NOT NULL THEN (SELECT row_to_json(x) FROM get_was_app_properties(agp.id) x) " +
                " WHEN agp.id_pims_properties_directory IS NOT NULL THEN (SELECT row_to_json(x) FROM get_pims_app_properties(agp.id) x) " +
                " WHEN agp.id_database_properties_directory IS NOT NULL THEN (SELECT row_to_json(x) FROM get_database_app_properties(agp.id) x) " +
                " WHEN agp.id_datastage_properties_directory IS NOT NULL THEN (SELECT row_to_json(x) FROM get_datastage_app_properties(agp.id) x) " +
                " ELSE NULL END AS json_obj FROM app_general_properties agp";
        String sql = baseSql;
        List<Object> params = new ArrayList<>();
        if (id != null) {
            sql = baseSql + " WHERE agp.id = ?";
            params.add(id);
        }
        logger.info("SQL ejecutado en /consult: {} | Parámetros: {}", sql, params);
        try {
            List<Map<String, Object>> result = params.isEmpty() ?
                jdbcTemplate.queryForList(sql) :
                jdbcTemplate.queryForList(sql, params.toArray());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            logger.error("Error en /consult", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Endpoint para agregar ítems a tablas auxiliares (POST /aux/{tabla})
    @PostMapping("/aux/{tabla}")
    public ResponseEntity<?> addAuxItem(@PathVariable String tabla, @RequestBody Map<String, Object> body) {
        try {
            StringBuilder sql = new StringBuilder("INSERT INTO ").append(tabla).append(" (");
            StringBuilder values = new StringBuilder(" VALUES (");
            List<Object> params = new ArrayList<>();
            int i = 0;
            for (String key : body.keySet()) {
                if (i > 0) { sql.append(","); values.append(","); }
                sql.append(key); values.append("?");
                params.add(body.get(key));
                i++;
            }
            sql.append(")").append(values).append(") RETURNING id;");
            Map<String, Object> res = jdbcTemplate.queryForMap(sql.toString(), params.toArray());
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            logger.error("Error en /aux/" + tabla, e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error insertando en tabla auxiliar: " + e.getMessage());
        }
    }

    // Endpoint para agregar una nueva aplicación (POST /apps)
    @PostMapping("/apps")
    public ResponseEntity<?> addApp(@RequestBody Map<String, Object> body) {
        try {
            // Validar que solo un tipo de propiedad específica esté presente
            int count = 0;
            String[] props = {"id_microservice_directory", "id_datastage_properties_directory", "id_database_properties_directory", "id_was_properties_directory", "id_pims_properties_directory"};
            for (String prop : props) {
                if (body.containsKey(prop) && body.get(prop) != null) count++;
            }
            if (count != 1) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Debe especificar solo un tipo de propiedad específica por aplicación");
            }
            // Insertar en appname_directory
            Number appNameId = jdbcTemplate.queryForObject(
                "INSERT INTO appname_directory (app) VALUES (?) RETURNING id",
                (rs, rowNum) -> rs.getLong("id"),
                body.get("app")
            );
            // Insertar en app_directory
            Number appDirId = jdbcTemplate.queryForObject(
                "INSERT INTO app_directory (id_appname, repo_name, repo_url) VALUES (?, ?, ?) RETURNING id",
                (rs, rowNum) -> rs.getLong("id"),
                appNameId, body.get("repo_name"), body.get("repo_url")
            );
            // Insertar en app_general_properties
            StringBuilder sql = new StringBuilder("INSERT INTO app_general_properties (");
            StringBuilder values = new StringBuilder(" VALUES (");
            List<Object> params = new ArrayList<>();
            sql.append("id_project_directory, id_app_directory, id_person_in_charge, id_security_champion, id_env_directory, id_country_directory, id_label_directory, id_app_type_directory, id_pipeline_properties_directory, id_runtime_directory, sonarqubepath_exec");
            values.append("?,?,?,?,?,?,?,?,?,?,?");
            params.add(body.get("id_project_directory"));
            params.add(appDirId);
            params.add(body.get("id_person_in_charge"));
            params.add(body.get("id_security_champion"));
            params.add(body.get("id_env_directory"));
            params.add(body.get("id_country_directory"));
            params.add(body.get("id_label_directory"));
            params.add(body.get("id_app_type_directory"));
            params.add(body.get("id_pipeline_properties_directory"));
            params.add(body.get("id_runtime_directory"));
            params.add(body.get("sonarqubepath_exec"));
            for (String prop : props) {
                if (body.containsKey(prop) && body.get(prop) != null) {
                    sql.append(", ").append(prop);
                    values.append(",?");
                    params.add(body.get(prop));
                }
            }
            sql.append(")").append(values).append(") RETURNING id;");
            Map<String, Object> res = jdbcTemplate.queryForMap(sql.toString(), params.toArray());
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            logger.error("Error en /apps", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error insertando aplicación: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(ApiprojectApplication.class, args);
    }
}
