-- ===============================
-- CREACIÓN DE FUNCIONES PARA CONSULTA DE PROPIEDADES DE APLICACIONES
-- ===============================

-- ELIMINACIÓN DE FUNCIONES ANTERIORES
DROP FUNCTION IF EXISTS get_microservice_app_properties(INT) CASCADE;
DROP FUNCTION IF EXISTS get_was_app_properties(INT) CASCADE;
DROP FUNCTION IF EXISTS get_pims_app_properties(INT) CASCADE;
DROP FUNCTION IF EXISTS get_database_app_properties(INT) CASCADE;
DROP FUNCTION IF EXISTS get_datastage_app_properties(INT) CASCADE;

-- FUNCIONES ACTUALIZADAS CON p_id_app_general COMO PARÁMETRO

-- MICROSERVICE
CREATE OR REPLACE FUNCTION get_microservice_app_properties(p_id_app_general INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT,
    usage TEXT,
    cpulimits TEXT,
    cpurequest TEXT,
    memorylimits TEXT,
    memoryrequest TEXT,
    replicas INT,
    token TEXT,
    namespace_name TEXT,
    secrets_enabled BOOLEAN,
    configmap_enabled BOOLEAN,
    volume_enabled BOOLEAN,
    volume_path TEXT,
    image_name TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name::TEXT,
        pj.project_acronym::TEXT,
        COALESCE(pic.nombre, '')::TEXT,
        COALESCE(pic.email, '')::TEXT,
        COALESCE(sc.nombre, '')::TEXT,
        COALESCE(sc.email, '')::TEXT,
        COALESCE(env.env, '')::TEXT,
        COALESCE(ct.country, '')::TEXT,
        COALESCE(lbl.app_label, '')::TEXT,
        COALESCE(apt.app_type, '')::TEXT,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        COALESCE(rt.runtime_name, '')::TEXT,
        COALESCE(rt.version_path, '')::TEXT,
        COALESCE(agp.sonarqubepath_exec, '')::TEXT,
        COALESCE(u.usage, '')::TEXT,
        COALESCE(msd.cpulimits, '')::TEXT,
        COALESCE(msd.cpurequest, '')::TEXT,
        COALESCE(msd.memorylimits, '')::TEXT,
        COALESCE(msd.memoryrequest, '')::TEXT,
        msd.replicas,
        COALESCE(tok.token, '')::TEXT,
        COALESCE(tok.namespace_name, '')::TEXT,
        op.secrets_enabled,
        op.configmap_enabled,
        op.volume_enabled,
        COALESCE(pd.volume_path, '')::TEXT,
        COALESCE(img.image_name, '')::TEXT
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN microservice_properties_directory msd ON agp.id_microservice_directory = msd.id
    LEFT JOIN usage_directory u ON msd.id_usage_directory = u.id
    LEFT JOIN token_directory tok ON msd.id_token_directory = tok.id
    LEFT JOIN openshift_properties_directory op ON msd.id_openshift_properties_directory = op.id
    LEFT JOIN path_directory pd ON msd.id_path_directory = pd.id
    LEFT JOIN image_directory img ON msd.id_image_directory = img.id
    WHERE agp.id = p_id_app_general;
END;
$$ LANGUAGE plpgsql;

-- WAS
CREATE OR REPLACE FUNCTION get_was_app_properties(p_id_app_general INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT,
    host TEXT,
    instance_name TEXT,
    context_root TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name::TEXT,
        pj.project_acronym::TEXT,
        pic.nombre::TEXT,
        pic.email::TEXT,
        sc.nombre::TEXT,
        sc.email::TEXT,
        env.env::TEXT,
        ct.country::TEXT,
        lbl.app_label::TEXT,
        apt.app_type::TEXT,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name::TEXT,
        rt.version_path::TEXT,
        agp.sonarqubepath_exec::TEXT,
        was.host::TEXT,
        was.instance_name::TEXT,
        was.context_root::TEXT
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN was_properties_directory was ON agp.id_was_properties_directory = was.id
    WHERE agp.id = p_id_app_general;
END;
$$ LANGUAGE plpgsql;

-- PIMS
CREATE OR REPLACE FUNCTION get_pims_app_properties(p_id_app_general INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT,
    nexus_url TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name::TEXT,
        pj.project_acronym::TEXT,
        pic.nombre::TEXT,
        pic.email::TEXT,
        sc.nombre::TEXT,
        sc.email::TEXT,
        env.env::TEXT,
        ct.country::TEXT,
        lbl.app_label::TEXT,
        apt.app_type::TEXT,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name::TEXT,
        rt.version_path::TEXT,
        agp.sonarqubepath_exec::TEXT,
        pims.nexus_url::TEXT
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN pims_properties_directory pims ON agp.id_pims_properties_directory = pims.id
    WHERE agp.id = p_id_app_general;
END;
$$ LANGUAGE plpgsql;

-- DATABASE
CREATE OR REPLACE FUNCTION get_database_app_properties(p_id_app_general INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name::TEXT,
        pj.project_acronym::TEXT,
        pic.nombre::TEXT,
        pic.email::TEXT,
        sc.nombre::TEXT,
        sc.email::TEXT,
        env.env::TEXT,
        ct.country::TEXT,
        lbl.app_label::TEXT,
        apt.app_type::TEXT,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name::TEXT,
        rt.version_path::TEXT,
        agp.sonarqubepath_exec::TEXT
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN database_properties_directory db ON agp.id_database_properties_directory = db.id
    WHERE agp.id = p_id_app_general;
END;
$$ LANGUAGE plpgsql;

-- DATASTAGE
CREATE OR REPLACE FUNCTION get_datastage_app_properties(p_id_app_general INT)
RETURNS TABLE (
    app_general_id INT,
    app_name TEXT,
    repo_name TEXT,
    repo_url TEXT,
    project_name TEXT,
    project_acronym TEXT,
    person_in_charge TEXT,
    person_email TEXT,
    security_champion TEXT,
    security_email TEXT,
    env TEXT,
    country TEXT,
    app_label TEXT,
    app_type TEXT,
    pipeline_securitygate BOOLEAN,
    pipeline_unittests BOOLEAN,
    pipeline_sonarqube BOOLEAN,
    pipeline_qualitygate BOOLEAN,
    runtime_name TEXT,
    runtime_version TEXT,
    sonarqubepath_exec TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        agp.id,
        appn.app,
        ad.repo_name,
        ad.repo_url,
        pj.project_name::TEXT,
        pj.project_acronym::TEXT,
        pic.nombre::TEXT,
        pic.email::TEXT,
        sc.nombre::TEXT,
        sc.email::TEXT,
        env.env::TEXT,
        ct.country::TEXT,
        lbl.app_label::TEXT,
        apt.app_type::TEXT,
        pp.securitygate,
        pp.unittests,
        pp.sonarqube,
        pp.qualitygate,
        rt.runtime_name::TEXT,
        rt.version_path::TEXT,
        agp.sonarqubepath_exec::TEXT
    FROM app_general_properties agp
    JOIN app_directory ad ON agp.id_app_directory = ad.id
    JOIN appname_directory appn ON ad.id_appname = appn.id
    JOIN project_directory pj ON agp.id_project_directory = pj.id
    LEFT JOIN person_in_charge pic ON agp.id_person_in_charge = pic.id
    LEFT JOIN security_champion sc ON agp.id_security_champion = sc.id
    LEFT JOIN env_directory env ON agp.id_env_directory = env.id
    LEFT JOIN country_directory ct ON agp.id_country_directory = ct.id
    LEFT JOIN label_directory lbl ON agp.id_label_directory = lbl.id
    LEFT JOIN app_type_directory apt ON agp.id_app_type_directory = apt.id
    LEFT JOIN pipeline_properties_directory pp ON agp.id_pipeline_properties_directory = pp.id
    LEFT JOIN runtime_directory rt ON agp.id_runtime_directory = rt.id
    JOIN datastage_properties_directory ds ON agp.id_datastage_properties_directory = ds.id
    WHERE agp.id = p_id_app_general;
END;
$$ LANGUAGE plpgsql;
