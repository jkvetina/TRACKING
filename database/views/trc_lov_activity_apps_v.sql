CREATE OR REPLACE FORCE VIEW trc_lov_activity_apps_v AS
SELECT
    a.application_id,
    a.application_id || ' - ' || a.application_name AS application_name,
    a.workspace
FROM trc_activity_log_v a
WHERE a.application_id IS NOT NULL
GROUP BY
    a.application_id,
    a.application_name,
    a.workspace;
--
COMMENT ON TABLE trc_lov_activity_apps_v IS '';

